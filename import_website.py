#!/usr/bin/env python3
"""
Complete Website Import Tool
Scrapes a website and generates PostgreSQL import script

Supports two scraping modes:
1. Local Playwright (default) - Uses local browser
2. Stealth Browser MCP - Uses remote stealth browser for anti-bot bypass

Usage:
    python import_website.py <url> [template_name] [timeout_seconds] [--stealth]

Example:
    python import_website.py https://example.com my_template 300
    python import_website.py https://example.com my_template 600 --stealth
"""

import sys
import os
import json
import asyncio
from sql_generator import SQLGenerator


def get_scraper(url: str, template_name: str, timeout_seconds: int, use_stealth: bool = False):
    """Get the appropriate scraper based on mode"""
    if use_stealth:
        from stealth_browser_scraper import StealthBrowserScraper
        return StealthBrowserScraper(url, template_name, timeout_seconds)
    else:
        from web_scraper_playwright import PlaywrightWebsiteScraper
        return PlaywrightWebsiteScraper(url, template_name, timeout_seconds)


async def import_website(url: str, template_name: str = None, timeout_seconds: int = 300, use_stealth: bool = False):
    """Complete import pipeline"""

    mode = "Stealth Browser MCP" if use_stealth else "Playwright"
    print("╔" + "═" * 58 + "╗")
    print("║" + f" Website Template Importer - {mode} ".center(58) + "║")
    print("╚" + "═" * 58 + "╝")

    # Step 1: Scrape website
    print("\n" + "┌" + "─" * 58 + "┐")
    if use_stealth:
        print("│ STEP 1: Web Scraping with Stealth Browser MCP          │")
    else:
        print("│ STEP 1: Web Scraping with Playwright + BeautifulSoup   │")
    print("└" + "─" * 58 + "┘")

    scraper = get_scraper(url, template_name, timeout_seconds, use_stealth)

    # Call the appropriate async method
    if use_stealth:
        template_data = await scraper.scrape_website()
    else:
        template_data = await scraper.scrape_website_async()

    # Step 2: Save JSON
    json_file = f"scraped_{scraper.template_name}.json"
    with open(json_file, 'w') as f:
        json.dump(template_data, f, indent=2, default=str)

    print(f"\n📄 Scraped data saved: {json_file}")

    # Step 3: Generate SQL
    print("\n" + "┌" + "─" * 58 + "┐")
    print("│ STEP 2: Generating PostgreSQL Import Script           │")
    print("└" + "─" * 58 + "┘")

    generator = SQLGenerator(template_data)
    sql_file = generator.generate_sql()

    # Step 4: Generate image BYTEA updates (optional)
    images_dir = scraper.images_dir
    if os.path.exists(images_dir) and os.listdir(images_dir):
        print(f"\n📸 Generating BYTEA updates for {len(os.listdir(images_dir))} images...")
        bytea_updates = generator.generate_image_bytea_updates(images_dir)

        if bytea_updates:
            # Append to SQL file
            with open(sql_file, 'a') as f:
                f.write(bytea_updates)
            print("   ✅ Image BYTEA updates added to SQL")

    # Summary
    print("\n" + "╔" + "═" * 58 + "╗")
    print("║" + " IMPORT COMPLETE! ".center(58) + "║")
    print("╚" + "═" * 58 + "╝")

    print(f"""
📊 Summary:
   • Template: {scraper.template_name}
   • Sections: {len(template_data['sections'])}
   • Source: {url}

📁 Generated Files:
   • JSON Data:     {json_file}
   • SQL Script:    {sql_file}
   • Images:        {images_dir}/

🚀 Next Steps:
   1. Review the generated SQL file
   2. Import to PostgreSQL:
      $ psql -d website_builder < {sql_file}
   3. Launch Website Builder to see the template!
""")

    return {
        'json_file': json_file,
        'sql_file': sql_file,
        'images_dir': images_dir,
        'template_name': scraper.template_name
    }


def main():
    if len(sys.argv) < 2:
        print("""
╔════════════════════════════════════════════════════════════╗
║         Website Template Importer v2.1                     ║
║         Playwright + Stealth Browser MCP Support           ║
╚════════════════════════════════════════════════════════════╝

Usage:
    python import_website.py <url> [template_name] [timeout] [--stealth]

Arguments:
    url             The website URL to scrape
    template_name   Optional custom name for the template
    timeout         Timeout in seconds (default: 300)
    --stealth       Use Stealth Browser MCP (bypasses anti-bot)

Examples:
    # Local Playwright (default)
    python import_website.py https://example.com
    python import_website.py https://studio.com pilates_template

    # Stealth Browser MCP (for protected sites)
    python import_website.py https://dribbble.com/shots --stealth
    python import_website.py https://awwwards.com my_template 600 --stealth

Features:
    ✓ Dual-mode: Local Playwright or Remote Stealth Browser
    ✓ Anti-bot detection bypass (stealth mode)
    ✓ 3x scroll passes for lazy-loaded content
    ✓ Typography detection (fonts, sizes, weights)
    ✓ Grid system detection (spacing units)
    ✓ Component standardization (800x1000px cards)
    ✓ Section deduplication & smart ordering
    ✓ Automatic image downloading with association
    ✓ PostgreSQL SQL generation with BYTEA images

Requirements:
    # For local Playwright mode:
    $ pip install -r requirements_playwright.txt

    # For Stealth Browser MCP mode:
    $ source ~/stealth_env.sh
""")
        sys.exit(1)

    # Parse arguments
    use_stealth = '--stealth' in sys.argv
    args = [arg for arg in sys.argv[1:] if arg != '--stealth']

    url = args[0]
    template_name = args[1] if len(args) > 1 and not args[1].isdigit() else None
    timeout_seconds = 300

    # Find timeout (could be 2nd or 3rd argument)
    for arg in args[1:]:
        if arg.isdigit():
            timeout_seconds = int(arg)
            break

    try:
        result = asyncio.run(import_website(url, template_name, timeout_seconds, use_stealth))
        sys.exit(0)
    except KeyboardInterrupt:
        print("\n\n  Import cancelled by user")
        sys.exit(1)
    except Exception as e:
        print(f"\n  Error: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)


if __name__ == '__main__':
    main()
