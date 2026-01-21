#!/usr/bin/env python3
"""
Complete Website Import Tool - Playwright Version
Scrapes a website using advanced Playwright automation and generates PostgreSQL import script

Usage:
    python3 import_website_playwright.py <url> [template_name]

Example:
    python3 import_website_playwright.py https://nike.com nike_template
"""

import sys
import os
import json
from web_scraper_playwright import PlaywrightWebsiteScraper
from sql_generator import SQLGenerator


def import_website(url: str, template_name: str = None):
    """Complete import pipeline with Playwright"""

    print("╔" + "═" * 58 + "╗")
    print("║" + " Website Template Importer - Playwright Version ".center(58) + "║")
    print("╚" + "═" * 58 + "╝")

    # Step 1: Scrape website with Playwright
    print("\n" + "┌" + "─" * 58 + "┐")
    print("│ STEP 1: Advanced Web Scraping with Playwright         │")
    print("└" + "─" * 58 + "┘")

    scraper = PlaywrightWebsiteScraper(url, template_name)
    template_data = scraper.scrape_website()

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
   • Scraper: Playwright (Advanced)

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
║     Website Template Importer v2.0 - Playwright           ║
║     Advanced Browser Automation for Better Accuracy       ║
╚════════════════════════════════════════════════════════════╝

Usage:
    python3 import_website_playwright.py <url> [template_name]

Arguments:
    url             The website URL to scrape
    template_name   Optional custom name for the template

Examples:
    python3 import_website_playwright.py https://nike.com
    python3 import_website_playwright.py https://studio.com pilates_template

Features:
    ✓ Playwright for advanced browser automation
    ✓ Better JavaScript execution and waiting
    ✓ Network idle detection
    ✓ Improved lazy loading handling
    ✓ Responsive layout capture
    ✓ Better interaction detection
    ✓ PostgreSQL SQL generation
    ✓ BYTEA image embedding

Requirements:
    Install first:
    $ chmod +x setup_playwright.sh
    $ ./setup_playwright.sh
""")
        sys.exit(1)

    url = sys.argv[1]
    template_name = sys.argv[2] if len(sys.argv) > 2 else None

    try:
        result = import_website(url, template_name)
        sys.exit(0)
    except KeyboardInterrupt:
        print("\n\n⚠️  Import cancelled by user")
        sys.exit(1)
    except Exception as e:
        print(f"\n❌ Error: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)


if __name__ == '__main__':
    main()
