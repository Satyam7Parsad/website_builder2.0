#!/usr/bin/env python3
"""
Stealth Browser MCP Scraper for Website Template Import

This scraper uses the remote Stealth Browser MCP server to:
- Bypass anti-bot detection on protected websites
- Extract complete element styles, structures, and animations
- Download images and assets
- Generate templates for the Website Builder

Usage:
    from stealth_browser_scraper import StealthBrowserScraper

    scraper = StealthBrowserScraper(url="https://example.com", template_name="my_template")
    template_data = await scraper.scrape_website()
"""

import os
import sys
import json
import time
import base64
import asyncio
import hashlib
from urllib.parse import urljoin, urlparse
from datetime import datetime
from typing import List, Dict, Any, Optional, Tuple

# Add mcp-scripts to path
sys.path.insert(0, os.path.expanduser('~/mcp-scripts'))

from PIL import Image
import io


class StealthBrowserMCPClient:
    """Client for interacting with Stealth Browser MCP server"""

    def __init__(self):
        """Initialize with environment variables"""
        import requests

        self.server_ip = os.getenv('SERVER_IP', '10.20.14.193')
        self.server_port = os.getenv('SERVER_PORT', '8000')
        self.access_token = os.getenv('ACCESS_TOKEN')

        if not self.access_token:
            # Try to source from stealth_env.sh
            env_file = os.path.expanduser('~/stealth_env.sh')
            if os.path.exists(env_file):
                with open(env_file, 'r') as f:
                    for line in f:
                        if line.startswith('export ACCESS_TOKEN='):
                            self.access_token = line.split('=', 1)[1].strip().strip('"\'')
                            break

        if not self.access_token:
            raise ValueError("ACCESS_TOKEN not found. Run: source ~/stealth_env.sh")

        self.server_url = f"http://{self.server_ip}:{self.server_port}"
        self.mcp_endpoint = f"{self.server_url}/mcp/"
        self.session = requests.Session()
        self.session.headers.update({
            'Authorization': f'Bearer {self.access_token}',
            'Content-Type': 'application/json',
            'Accept': 'application/json, text/event-stream'
        })

    def call_tool(self, tool_name: str, arguments: Dict[str, Any], timeout: int = 120) -> Any:
        """Call an MCP tool"""
        payload = {
            "jsonrpc": "2.0",
            "id": 1,
            "method": "tools/call",
            "params": {
                "name": tool_name,
                "arguments": arguments
            }
        }

        try:
            response = self.session.post(
                self.mcp_endpoint,
                json=payload,
                timeout=timeout
            )
            response.raise_for_status()

            # Parse SSE format if needed
            response_text = response.text.strip()
            if response_text.startswith('event:'):
                lines = response_text.split('\n')
                for line in lines:
                    if line.startswith('data:'):
                        data_line = line[5:].strip()
                        result = json.loads(data_line)
                        break
            else:
                result = response.json()

            if "error" in result:
                raise Exception(f"MCP Error: {result['error'].get('message', 'Unknown error')}")

            return result.get('result', result)

        except Exception as e:
            raise Exception(f"MCP call failed for {tool_name}: {e}")


class StealthBrowserScraper:
    """
    Website scraper using Stealth Browser MCP

    Advantages over local Playwright:
    - Remote browser avoids local fingerprinting
    - Stealth features bypass anti-bot detection
    - Advanced element cloning with complete styles
    - Better for JavaScript-heavy sites
    """

    def __init__(self, url: str, template_name: str = None, timeout_seconds: int = 300):
        """
        Initialize the scraper

        Args:
            url: Website URL to scrape
            template_name: Name for the template (default: domain name)
            timeout_seconds: Maximum time for scraping
        """
        self.url = url
        self.domain = urlparse(url).netloc
        self.template_name = template_name or self.domain.replace('.', '_').replace('-', '_')
        self.timeout_seconds = timeout_seconds

        # Results storage
        self.sections = []
        self.images_dir = f"scraped_images/{self.template_name}"
        self.downloaded_images = {}
        self.typography_system = {}
        self.grid_system = {}
        self.custom_fonts = []

        # Browser state
        self.mcp = None
        self.instance_id = None

        # Create images directory
        os.makedirs(self.images_dir, exist_ok=True)

    async def scrape_website(self) -> Dict[str, Any]:
        """Main scraping method using Stealth Browser MCP"""
        print(f"\n{'='*60}")
        print("  STEALTH BROWSER MCP - Website Template Scraper")
        print(f"{'='*60}")
        print(f"\n  Target: {self.url}")
        print(f"  Template: {self.template_name}")
        print(f"{'='*60}\n")

        try:
            # Initialize MCP client
            print("1. Connecting to Stealth Browser MCP server...")
            self.mcp = StealthBrowserMCPClient()
            print(f"   Server: {self.mcp.server_url}")
            print("   Connected!")

            # Spawn browser
            print("\n2. Spawning stealth browser instance...")
            spawn_result = self.mcp.call_tool('spawn_browser', {
                'headless': True,
                'viewport_width': 1920,
                'viewport_height': 1080
            })

            # Extract instance_id from result
            if isinstance(spawn_result, dict):
                if 'content' in spawn_result:
                    content = spawn_result['content']
                    if isinstance(content, list) and len(content) > 0:
                        text = content[0].get('text', '{}')
                        data = json.loads(text)
                        self.instance_id = data.get('instance_id')
                elif 'instance_id' in spawn_result:
                    self.instance_id = spawn_result['instance_id']

            if not self.instance_id:
                raise Exception(f"Failed to get instance_id from spawn_browser: {spawn_result}")

            print(f"   Browser Instance: {self.instance_id}")

            # Navigate to URL
            print(f"\n3. Navigating to {self.url}...")
            nav_result = self.mcp.call_tool('navigate', {
                'instance_id': self.instance_id,
                'url': self.url,
                'wait_until': 'networkidle'
            }, timeout=self.timeout_seconds)
            print("   Page loaded!")

            # Wait for JavaScript to execute
            print("\n4. Waiting for JavaScript execution...")
            await asyncio.sleep(3)

            # Scroll to load lazy content
            print("\n5. Scrolling to load lazy content...")
            await self._scroll_for_lazy_load()

            # Take screenshot
            print("\n6. Capturing full-page screenshot...")
            screenshot_path = await self._take_screenshot()
            print(f"   Saved: {screenshot_path}")

            # Get page content
            print("\n7. Extracting page content...")
            page_content = await self._get_page_content()

            # Extract sections using advanced MCP tools
            print("\n8. Detecting and extracting sections...")
            await self._extract_sections(page_content)

            # Use advanced CDP extraction for better accuracy
            print("\n8b. Enhancing sections with CDP extraction...")
            await self._enhance_sections_with_cdp()

            # Download images
            print(f"\n9. Downloading images to {self.images_dir}/...")
            await self._download_images(page_content)

            # Extract typography
            print("\n10. Analyzing typography system...")
            await self._extract_typography()

            # Build template data
            template_data = self._build_template_data(page_content)

            print(f"\n{'='*60}")
            print("  SCRAPING COMPLETE!")
            print(f"{'='*60}")
            print(f"  Sections found: {len(self.sections)}")
            print(f"  Images downloaded: {len(self.downloaded_images)}")
            print(f"{'='*60}\n")

            return template_data

        except Exception as e:
            print(f"\n  ERROR: {e}")
            import traceback
            traceback.print_exc()
            raise

        finally:
            # Cleanup: close browser
            if self.instance_id:
                print("\n  Closing browser instance...")
                try:
                    self.mcp.call_tool('close_instance', {
                        'instance_id': self.instance_id
                    })
                    print("  Browser closed.")
                except:
                    pass

    async def _scroll_for_lazy_load(self):
        """Scroll the page to trigger lazy loading"""
        # Get page height
        scroll_result = self.mcp.call_tool('execute_script', {
            'instance_id': self.instance_id,
            'script': 'document.body.scrollHeight'
        })

        # Parse result
        page_height = 5000  # Default
        if isinstance(scroll_result, dict) and 'content' in scroll_result:
            try:
                content = scroll_result['content']
                if isinstance(content, list) and content:
                    text = content[0].get('text', '5000')
                    result_data = json.loads(text)
                    page_height = result_data.get('result', 5000)
            except:
                pass

        # Scroll in steps
        viewport_height = 1080
        current_position = 0
        scroll_count = 0

        while current_position < page_height and scroll_count < 20:
            self.mcp.call_tool('scroll_page', {
                'instance_id': self.instance_id,
                'direction': 'down',
                'amount': viewport_height
            })
            current_position += viewport_height
            scroll_count += 1
            await asyncio.sleep(0.5)
            print(f"   Scrolled: {current_position}px / ~{page_height}px")

        # Scroll back to top
        self.mcp.call_tool('execute_script', {
            'instance_id': self.instance_id,
            'script': 'window.scrollTo(0, 0)'
        })
        await asyncio.sleep(1)

    async def _take_screenshot(self) -> str:
        """Take a full-page screenshot"""
        screenshot_result = self.mcp.call_tool('take_screenshot', {
            'instance_id': self.instance_id,
            'full_page': True
        })

        screenshot_path = os.path.join(self.images_dir, 'full_page_screenshot.png')

        # Extract base64 data
        if isinstance(screenshot_result, dict) and 'content' in screenshot_result:
            content = screenshot_result['content']
            if isinstance(content, list):
                for item in content:
                    if item.get('type') == 'image':
                        base64_data = item.get('data', '')
                        if base64_data:
                            image_data = base64.b64decode(base64_data)
                            with open(screenshot_path, 'wb') as f:
                                f.write(image_data)
                            return screenshot_path

        # Alternative: check for file path in result
        return screenshot_path

    async def _get_page_content(self) -> Dict[str, Any]:
        """Get the full page HTML and text content"""
        content_result = self.mcp.call_tool('get_page_content', {
            'instance_id': self.instance_id
        })

        html = ''
        text = ''

        if isinstance(content_result, dict) and 'content' in content_result:
            content = content_result['content']
            if isinstance(content, list) and content:
                text_content = content[0].get('text', '{}')
                try:
                    data = json.loads(text_content)
                    html = data.get('html', '')
                    text = data.get('text', '')
                except:
                    html = text_content

        return {
            'html': html,
            'text': text,
            'url': self.url
        }

    async def _extract_sections_via_mcp(self) -> List[Dict]:
        """Use MCP query_elements for better section extraction on React sites"""

        sections = []

        # Priority selectors for modern sites - order matters for y-position sorting
        selector_groups = [
            ('header', 'header'),
            ('nav', 'navigation'),
            ('section', 'content'),
            ('main', 'content'),
            ('main > div', 'content'),
            ('main > div > div', 'content'),  # Deeper nested content
            ('[class*="hero"]', 'hero'),
            ('[class*="banner"]', 'hero'),
            ('[class*="carousel"]', 'gallery'),
            ('article', 'content'),
            ('footer', 'footer'),
        ]

        y_positions_seen = set()

        for selector, default_type in selector_groups:
            try:
                result = self.mcp.call_tool('query_elements', {
                    'instance_id': self.instance_id,
                    'selector': selector
                })

                if isinstance(result, dict) and 'content' in result:
                    content = result['content']
                    if isinstance(content, list) and content:
                        elements = json.loads(content[0].get('text', '[]'))

                        for idx, elem in enumerate(elements[:5]):  # Limit per selector
                            if not elem:
                                continue

                            # Get element bounds - MCP uses bounding_box with x, y, width, height
                            bbox = elem.get('bounding_box') or {}
                            if not bbox:
                                continue

                            y_pos = int(bbox.get('y', 0) or 0)
                            height = int(bbox.get('height', 0) or 0)
                            width = int(bbox.get('width', 0) or 0)

                            # Skip tiny elements - but allow smaller heights for nav/header
                            min_height = 40 if selector in ['header', 'nav', 'footer'] else 100
                            if height < min_height or width < 200:
                                continue

                            # Check if we already have a section at this position
                            y_key = y_pos // 100  # Group by 100px
                            if y_key in y_positions_seen:
                                continue
                            y_positions_seen.add(y_key)

                            # Extract text content - MCP uses 'text' field
                            raw_text = elem.get('text') or ''
                            text_content = raw_text[:500] if raw_text else ''

                            # Get computed styles via element state
                            bg_color = 'rgba(30, 30, 40, 1)' if idx % 2 == 0 else 'rgba(45, 45, 55, 1)'
                            text_color = 'rgba(255, 255, 255, 1)'

                            try:
                                state_result = self.mcp.call_tool('get_element_state', {
                                    'instance_id': self.instance_id,
                                    'selector': f'{selector}:nth-of-type({idx + 1})' if idx > 0 else selector
                                })

                                if isinstance(state_result, dict) and 'content' in state_result:
                                    state_content = state_result['content']
                                    if isinstance(state_content, list) and state_content:
                                        state_data = json.loads(state_content[0].get('text', '{}'))
                                        styles = state_data.get('computed_styles', {}) or state_data.get('styles', {})
                                        if styles.get('backgroundColor') and styles.get('backgroundColor') not in ['rgba(0, 0, 0, 0)', 'transparent']:
                                            bg_color = styles.get('backgroundColor')
                                        if styles.get('color') and styles.get('color') not in ['rgba(0, 0, 0, 0)', 'transparent']:
                                            text_color = styles.get('color')
                            except:
                                pass

                            # Detect section type from element info
                            # MCP uses attributes.class_ for class name
                            attrs = elem.get('attributes', {})
                            class_name = attrs.get('class_', '') or attrs.get('class', '') or ''
                            tag_name = elem.get('tag_name', '').lower() or selector.split('[')[0]
                            section_type = self._detect_section_type(tag_name, {'className': class_name, 'tagName': tag_name})

                            # Extract title from text
                            lines = text_content.split('\n')
                            title = lines[0][:100] if lines else ''
                            subtitle = lines[1][:200] if len(lines) > 1 else ''

                            section = {
                                'type': section_type,
                                'name': title[:50] if title else f'{section_type.title()} Section',
                                'index': len(sections),
                                'html_tag': tag_name,
                                'classes': class_name.split() if class_name else [],
                                'id': attrs.get('id', ''),
                                'bounds': bbox,
                                'height': max(height, 300),
                                'width': max(width, 1920),
                                'y_position': y_pos,
                                'title': title,
                                'subtitle': subtitle,
                                'bg_color': bg_color,
                                'text_color': text_color,
                                'title_color': text_color,
                                'content_color': text_color,
                                'content': {
                                    'title': title,
                                    'subtitle': subtitle,
                                    'text': text_content,
                                },
                                'styles': {'backgroundColor': bg_color, 'color': text_color},
                                'images': [],
                                'buttons': [],
                            }
                            sections.append(section)
                            print(f"      MCP: Found {section_type} at y={y_pos}, height={height}")

            except Exception as e:
                print(f"      MCP query failed for {selector}: {e}")
                continue

        # Sort by y position
        sections.sort(key=lambda s: s['y_position'])

        # Re-index
        for idx, section in enumerate(sections):
            section['index'] = idx

        return sections

    async def _extract_sections(self, page_content: Dict):
        """Extract page sections using comprehensive JavaScript - handles React/modern frameworks"""

        # First try using MCP query_elements for major sections
        print("   Trying MCP query_elements for major sections...")
        mcp_sections = await self._extract_sections_via_mcp()

        if mcp_sections and len(mcp_sections) > 1:
            print(f"   MCP found {len(mcp_sections)} sections")
            self.sections = mcp_sections
            return

        # Fallback to comprehensive JavaScript extraction
        print("   Using JavaScript extraction...")
        script = """
        (() => {
            const sections = [];
            const bodyRect = document.body.getBoundingClientRect();
            const pageHeight = Math.max(
                document.body.scrollHeight,
                document.body.offsetHeight,
                document.documentElement.clientHeight,
                document.documentElement.scrollHeight,
                document.documentElement.offsetHeight
            );
            const viewportWidth = window.innerWidth;

            // STEP 1: Find all major container elements
            const allContainers = [];

            // Enhanced selectors for React/modern frameworks
            const containerSelectors = [
                'body > *',
                'main > *',
                'main > div > div',  // React nested structure
                '[data-testid]',     // React testing attributes
                '[class*="section"]', '[id*="section"]',
                '[class*="container"]', '[class*="wrapper"]',
                '[class*="block"]', '[class*="panel"]',
                'section', 'article', 'header', 'footer', 'nav',
                '[class*="hero"]', '[class*="banner"]',
                '[class*="content"]', '[class*="area"]',
                '[class*="card"]', '[class*="grid"]',
                '[role="main"]', '[role="region"]', '[role="contentinfo"]',
                'div[class*="css-"]',  // CSS-in-JS (styled-components, emotion)
                'div[class^="sc-"]'    // styled-components
            ];

            containerSelectors.forEach(selector => {
                try {
                    document.querySelectorAll(selector).forEach(el => {
                        const rect = el.getBoundingClientRect();
                        const style = window.getComputedStyle(el);

                        if (style.display === 'none' ||
                            style.visibility === 'hidden' ||
                            rect.height < 50 ||
                            rect.width < viewportWidth * 0.3 ||
                            style.display === 'inline') {
                            return;
                        }

                        const hasText = el.textContent.trim().length > 20;
                        const hasImages = el.querySelectorAll('img').length > 0;
                        const hasButtons = el.querySelectorAll('button, a.btn, .button, [class*="btn"]').length > 0;

                        if (hasText || hasImages || hasButtons) {
                            allContainers.push({
                                element: el,
                                rect: rect,
                                style: style,
                                y: rect.top + window.scrollY,
                                height: rect.height,
                                width: rect.width
                            });
                        }
                    });
                } catch (e) {}
            });

            // STEP 2: Filter out nested containers
            const parentContainers = [];
            allContainers.forEach(candidate => {
                let isNested = false;
                allContainers.forEach(other => {
                    if (other.element !== candidate.element &&
                        other.element.contains(candidate.element)) {
                        if (other.height > candidate.height * 1.3 &&
                            other.width >= candidate.width) {
                            isNested = true;
                        }
                    }
                });
                if (!isNested) {
                    parentContainers.push(candidate);
                }
            });

            // STEP 3: Group containers
            parentContainers.sort((a, b) => a.y - b.y);
            const groupedSections = [];
            let currentGroup = null;
            const groupingThreshold = 100;

            parentContainers.forEach(container => {
                if (!currentGroup) {
                    currentGroup = {
                        start: container.y,
                        end: container.y + container.height,
                        containers: [container]
                    };
                } else {
                    const gap = container.y - currentGroup.end;
                    if (gap < groupingThreshold) {
                        currentGroup.containers.push(container);
                        currentGroup.end = Math.max(currentGroup.end, container.y + container.height);
                    } else {
                        groupedSections.push(currentGroup);
                        currentGroup = {
                            start: container.y,
                            end: container.y + container.height,
                            containers: [container]
                        };
                    }
                }
            });
            if (currentGroup) {
                groupedSections.push(currentGroup);
            }

            // STEP 4: Extract comprehensive data for each section
            groupedSections.forEach((group, idx) => {
                let representative = group.containers[0];
                group.containers.forEach(container => {
                    if (container.width > representative.width ||
                        (container.width === representative.width &&
                         container.height > representative.height)) {
                        representative = container;
                    }
                });

                const el = representative.element;
                const rect = representative.rect;
                const style = representative.style;
                const sectionTop = group.start;
                const sectionBottom = group.end;

                // Extract headings with full styling
                const headings = [];
                el.querySelectorAll('h1, h2, h3, h4, h5, h6').forEach(h => {
                    const hStyle = window.getComputedStyle(h);
                    headings.push({
                        text: h.textContent.trim().substring(0, 200),
                        tag: h.tagName.toLowerCase(),
                        fontSize: parseFloat(hStyle.fontSize),
                        fontWeight: parseInt(hStyle.fontWeight),
                        color: hStyle.color,
                        fontFamily: hStyle.fontFamily
                    });
                });

                // Extract paragraphs with styling
                const paragraphs = [];
                el.querySelectorAll('p').forEach(p => {
                    if (p.textContent.trim().length > 0) {
                        const pStyle = window.getComputedStyle(p);
                        paragraphs.push({
                            text: p.textContent.trim().substring(0, 500),
                            fontSize: parseFloat(pStyle.fontSize),
                            fontWeight: parseInt(pStyle.fontWeight),
                            color: pStyle.color,
                            fontFamily: pStyle.fontFamily
                        });
                    }
                });

                // Extract buttons with complete CSS
                const buttons = [];
                el.querySelectorAll('button, a[class*="btn"], a[class*="button"], [class*="btn"], [role="button"]').forEach(btn => {
                    const text = btn.textContent.trim();
                    if (text.length > 0 && text.length < 100) {
                        const btnStyle = window.getComputedStyle(btn);
                        const btnRect = btn.getBoundingClientRect();
                        buttons.push({
                            text: text,
                            href: btn.href || '',
                            bgColor: btnStyle.backgroundColor,
                            textColor: btnStyle.color,
                            borderColor: btnStyle.borderColor,
                            fontSize: parseFloat(btnStyle.fontSize),
                            fontWeight: parseInt(btnStyle.fontWeight),
                            borderRadius: btnStyle.borderRadius,
                            padding: btnStyle.padding,
                            width: btnRect.width,
                            height: btnRect.height
                        });
                    }
                });

                // Extract images in this section
                const images = [];
                el.querySelectorAll('img').forEach(img => {
                    const imgRect = img.getBoundingClientRect();
                    const src = img.src || img.dataset.src || '';
                    if (src && !src.includes('data:image') && imgRect.width > 50 && imgRect.height > 50) {
                        images.push({
                            src: src,
                            alt: img.alt || '',
                            width: imgRect.width,
                            height: imgRect.height,
                            y: imgRect.top + window.scrollY
                        });
                    }
                });

                // Check for background images
                const bgImage = style.backgroundImage;
                let backgroundImageUrl = '';
                if (bgImage && bgImage !== 'none') {
                    const urlMatch = bgImage.match(/url\\(['"]?([^'"]+)['"]?\\)/);
                    if (urlMatch && urlMatch[1] && !urlMatch[1].includes('data:image')) {
                        backgroundImageUrl = urlMatch[1];
                    }
                }

                // Extract complete section CSS
                const sectionCSS = {
                    backgroundColor: style.backgroundColor,
                    backgroundImage: style.backgroundImage,
                    backgroundSize: style.backgroundSize,
                    backgroundPosition: style.backgroundPosition,
                    color: style.color,
                    padding: style.padding,
                    display: style.display,
                    flexDirection: style.flexDirection,
                    justifyContent: style.justifyContent,
                    alignItems: style.alignItems,
                    gap: style.gap,
                    gridTemplateColumns: style.gridTemplateColumns,
                    fontFamily: style.fontFamily,
                    fontSize: style.fontSize
                };

                sections.push({
                    tagName: el.tagName.toLowerCase(),
                    className: el.className || '',
                    id: el.id || '',
                    bounds: {
                        top: group.start,
                        left: rect.left,
                        width: representative.width,
                        height: group.end - group.start
                    },
                    styles: sectionCSS,
                    headings: headings,
                    paragraphs: paragraphs,
                    buttons: buttons,
                    images: images,
                    backgroundImageUrl: backgroundImageUrl,
                    colors: {
                        background: style.backgroundColor,
                        text: style.color,
                        gradient: bgImage && bgImage.includes('gradient') ? bgImage : ''
                    },
                    typography: {
                        titleSize: headings[0]?.fontSize || 42,
                        titleWeight: headings[0]?.fontWeight || 700,
                        titleColor: headings[0]?.color || style.color,
                        contentSize: paragraphs[0]?.fontSize || 16,
                        contentWeight: paragraphs[0]?.fontWeight || 400,
                        contentColor: paragraphs[0]?.color || style.color,
                        fontFamily: headings[0]?.fontFamily || paragraphs[0]?.fontFamily || style.fontFamily
                    }
                });
            });

            return sections;
        })()
        """

        try:
            result = self.mcp.call_tool('execute_script', {
                'instance_id': self.instance_id,
                'script': script
            })

            if isinstance(result, dict) and 'content' in result:
                content = result['content']
                if isinstance(content, list) and content:
                    data = json.loads(content[0].get('text', '{}'))
                    raw_sections = data.get('result', [])

                    # Convert to our section format with comprehensive data
                    for idx, raw in enumerate(raw_sections):
                        section_type = self._detect_section_type(
                            raw.get('tagName', ''),
                            {'className': raw.get('className', ''), 'tagName': raw.get('tagName', '')}
                        )

                        # Extract headings, paragraphs, buttons (new comprehensive format)
                        headings = raw.get('headings', [])
                        paragraphs = raw.get('paragraphs', [])
                        buttons = raw.get('buttons', [])
                        images = raw.get('images', [])
                        typography = raw.get('typography', {})
                        colors = raw.get('colors', {})

                        # Get title from first heading
                        title = headings[0]['text'] if headings else ''

                        # Get subtitle from second heading or first paragraph
                        subtitle = ''
                        if len(headings) > 1:
                            subtitle = headings[1]['text']
                        elif paragraphs:
                            subtitle = paragraphs[0]['text'][:200]

                        # Get content text from paragraphs
                        content_text = ' '.join([p['text'] for p in paragraphs[:3]])

                        # Generate meaningful name
                        name = title[:50] if title else f"{section_type.title()} Section {idx + 1}"

                        # Handle background color - use extracted or fallback to visible colors
                        bg_color = colors.get('background', '') or raw.get('styles', {}).get('backgroundColor', '')
                        if not bg_color or bg_color in ['rgba(0, 0, 0, 0)', 'rgba(0,0,0,0)', 'transparent', '']:
                            bg_color = 'rgba(30, 30, 40, 1)' if idx % 2 == 0 else 'rgba(45, 45, 55, 1)'

                        # Handle text color from typography or colors
                        text_color = typography.get('contentColor', '') or colors.get('text', '') or raw.get('styles', {}).get('color', '')
                        if not text_color or text_color in ['rgba(0, 0, 0, 0)', 'transparent', '']:
                            text_color = 'rgba(255, 255, 255, 1)'

                        # Handle title color from typography
                        title_color = typography.get('titleColor', '') or text_color

                        # Build content object matching Playwright format
                        content_obj = {
                            'title': title,
                            'subtitle': subtitle,
                            'content': content_text,
                            'headings': headings,
                            'paragraphs': paragraphs,
                            'buttons': buttons,
                            'colors': colors,
                            'typography': typography,
                            'css': raw.get('styles', {})
                        }

                        # Store images for this section
                        section_images = []
                        for img in images:
                            section_images.append({
                                'src': img.get('src', ''),
                                'alt': img.get('alt', ''),
                                'width': img.get('width', 0),
                                'height': img.get('height', 0)
                            })

                        # Extract button data for SQLGenerator
                        button_text = buttons[0]['text'] if buttons else ''
                        button_link = buttons[0].get('href', '') if buttons else ''
                        button_bg_color = buttons[0].get('bgColor', 'rgb(200, 100, 125)') if buttons else 'rgb(200, 100, 125)'
                        button_text_color = buttons[0].get('textColor', 'rgb(255, 255, 255)') if buttons else 'rgb(255, 255, 255)'

                        # Set section image (first large image in section)
                        section_image = ''
                        hero_animation_images = []
                        gallery_images = []

                        if section_images:
                            # Use first image as section image
                            section_image = section_images[0].get('src', '')

                            # For hero sections, collect multiple images for animation
                            if section_type in ['hero', 'header'] and len(section_images) > 1:
                                hero_animation_images = [img.get('src', '') for img in section_images[:5]]

                            # For gallery/portfolio sections, collect gallery images
                            if section_type in ['gallery', 'portfolio', 'services', 'features']:
                                gallery_images = [
                                    {'src': img.get('src', ''), 'alt': img.get('alt', ''), 'width': img.get('width', 0), 'height': img.get('height', 0)}
                                    for img in section_images[:12]
                                ]

                        section_data = {
                            'type': section_type,
                            'name': name,
                            'index': idx,
                            'html_tag': raw.get('tagName', 'section'),
                            'classes': raw.get('className', '').split() if raw.get('className') else [],
                            'id': raw.get('id', ''),
                            'bounds': raw.get('bounds', {}),
                            'styles': raw.get('styles', {}),
                            'content': content_obj,
                            'height': max(int(raw.get('bounds', {}).get('height', 500)), 300),
                            'width': int(raw.get('bounds', {}).get('width', 1920)),
                            'y_position': int(raw.get('bounds', {}).get('top', 0)),
                            # Direct fields for SQLGenerator
                            'title': title[:200] if title else name,
                            'subtitle': subtitle[:200] if subtitle else '',
                            'bg_color': bg_color,
                            'text_color': text_color,
                            'title_color': title_color,
                            'content_color': text_color,
                            # Typography from extracted data
                            'title_font_size': int(typography.get('titleSize', 42)),
                            'title_font_weight': int(typography.get('titleWeight', 700)),
                            'content_font_size': int(typography.get('contentSize', 16)),
                            'content_font_weight': int(typography.get('contentWeight', 400)),
                            # Button data
                            'button_text': button_text,
                            'button_link': button_link,
                            'button_bg_color': button_bg_color,
                            'button_text_color': button_text_color,
                            'buttons': buttons,
                            # Images
                            'images': section_images,
                            'section_image': section_image,
                            'background_image': raw.get('backgroundImageUrl', '') or (section_image if section_type in ['hero', 'header'] else ''),
                            # Hero animation
                            'hero_animation_images': hero_animation_images,
                            'enable_hero_animation': len(hero_animation_images) > 1,
                            'hero_animation_speed': 2.0,
                            # Gallery
                            'gallery_images': gallery_images,
                        }
                        self.sections.append(section_data)

                        # Log extraction details
                        img_count = len(section_images)
                        btn_count = len(buttons)
                        print(f"      Section {idx+1}: {name[:30]}... | Type: {section_type} | {img_count} images, {btn_count} buttons")

                    print(f"   Found {len(self.sections)} sections via JavaScript extraction")

        except Exception as e:
            print(f"   Warning: JavaScript section extraction failed: {e}")
            import traceback
            traceback.print_exc()

        # If still no sections, create basic ones from HTML structure
        if len(self.sections) == 0:
            print("   Fallback: Creating basic sections from page structure...")
            self.sections = self._create_fallback_sections(page_content)

    def _create_fallback_sections(self, page_content: Dict) -> List[Dict]:
        """Create basic sections when extraction fails"""
        from bs4 import BeautifulSoup

        sections = []
        html = page_content.get('html', '')

        if not html:
            # Create at least one hero section as minimum
            return [{
                'type': 'hero',
                'name': 'Hero Section',
                'title': 'Welcome',
                'subtitle': 'Imported from ' + self.domain,
                'height': 600,
                'y_position': 0,
                'bg_color': 'rgba(30,30,30,1)',
                'text_color': '#ffffff',
                'styles': {},
                'content': {'text': '', 'images': []}
            }]

        try:
            soup = BeautifulSoup(html, 'html.parser')

            # Find major structural elements
            y_pos = 0
            for tag in ['header', 'nav', 'main', 'section', 'article', 'footer']:
                elements = soup.find_all(tag)
                for i, el in enumerate(elements[:3]):
                    text = el.get_text(strip=True)[:200] if el.get_text() else ''
                    h_tag = el.find(['h1', 'h2', 'h3'])
                    title = h_tag.get_text(strip=True)[:100] if h_tag else tag.title()

                    section_type = 'hero' if tag == 'header' else \
                                   'navigation' if tag == 'nav' else \
                                   'footer' if tag == 'footer' else 'content'

                    sections.append({
                        'type': section_type,
                        'name': title or f'{tag.title()} {i+1}',
                        'title': title,
                        'subtitle': '',
                        'height': 500,
                        'y_position': y_pos,
                        'bg_color': 'rgba(40,40,40,1)',
                        'text_color': '#ffffff',
                        'styles': {},
                        'content': {'text': text, 'images': []}
                    })
                    y_pos += 500

                    if len(sections) >= 10:
                        break
                if len(sections) >= 10:
                    break

        except Exception as e:
            print(f"   Fallback parsing failed: {e}")

        # Ensure at least one section
        if not sections:
            sections.append({
                'type': 'hero',
                'name': 'Hero Section',
                'title': 'Welcome',
                'subtitle': 'Imported from ' + self.domain,
                'height': 600,
                'y_position': 0,
                'bg_color': 'rgba(30,30,30,1)',
                'text_color': '#ffffff',
                'styles': {},
                'content': {'text': '', 'images': []}
            })

        return sections

    async def _enhance_sections_with_cdp(self):
        """Use advanced CDP extraction tools for better accuracy"""

        for idx, section in enumerate(self.sections):
            try:
                # Build selector for this section
                section_id = section.get('id', '')
                section_classes = section.get('classes', [])
                html_tag = section.get('html_tag', 'section')

                # Try to build a reliable selector
                selector = None
                if section_id:
                    selector = f'#{section_id}'
                elif section_classes:
                    # Use first meaningful class
                    for cls in section_classes:
                        if cls and len(cls) > 2 and not cls.startswith('_'):
                            selector = f'{html_tag}.{cls}'
                            break

                if not selector:
                    # Fall back to nth-of-type
                    selector = f'{html_tag}:nth-of-type({idx + 1})'

                # Use extract_element_styles_cdp for accurate styles
                try:
                    style_result = self.mcp.call_tool('extract_element_styles_cdp', {
                        'instance_id': self.instance_id,
                        'selector': selector
                    })

                    if isinstance(style_result, dict) and 'content' in style_result:
                        content = style_result['content']
                        if isinstance(content, list) and content:
                            cdp_styles = json.loads(content[0].get('text', '{}'))

                            # Update section with CDP-extracted styles
                            if cdp_styles:
                                computed = cdp_styles.get('computed', {})

                                # Extract accurate colors
                                bg_color = computed.get('background-color') or computed.get('backgroundColor')
                                text_color = computed.get('color')

                                if bg_color and bg_color not in ['rgba(0, 0, 0, 0)', 'transparent']:
                                    section['bg_color'] = bg_color
                                    section['styles']['backgroundColor'] = bg_color

                                if text_color and text_color not in ['rgba(0, 0, 0, 0)', 'transparent']:
                                    section['text_color'] = text_color
                                    section['title_color'] = text_color
                                    section['content_color'] = text_color

                                # Extract font info
                                font_size = computed.get('font-size')
                                font_family = computed.get('font-family')
                                if font_size:
                                    section['content_font_size'] = int(float(font_size.replace('px', '')))
                                if font_family:
                                    section['styles']['fontFamily'] = font_family

                                print(f"      CDP enhanced section {idx+1}: bg={bg_color[:30] if bg_color else 'N/A'}")

                except Exception as e:
                    print(f"      Warning: CDP style extraction failed for section {idx+1}: {e}")

                # Use clone_element_complete for full element data (hero sections only due to size)
                if section.get('type') in ['hero', 'header'] and idx == 0:
                    try:
                        clone_result = self.mcp.call_tool('clone_element_complete', {
                            'instance_id': self.instance_id,
                            'selector': selector
                        })

                        if isinstance(clone_result, dict) and 'content' in clone_result:
                            content = clone_result['content']
                            if isinstance(content, list) and content:
                                clone_data = json.loads(content[0].get('text', '{}'))

                                # Extract additional data from clone
                                if clone_data.get('images'):
                                    existing_images = [img.get('src', '') for img in section.get('images', [])]
                                    for img in clone_data.get('images', []):
                                        if img.get('src') and img.get('src') not in existing_images:
                                            section['images'].append(img)

                                    # Update section_image if not set
                                    if not section.get('section_image') and section.get('images'):
                                        section['section_image'] = section['images'][0].get('src', '')

                                print(f"      Clone enhanced hero section: found {len(clone_data.get('images', []))} additional images")

                    except Exception as e:
                        print(f"      Warning: Clone extraction failed for hero: {e}")

            except Exception as e:
                print(f"      Warning: CDP enhancement failed for section {idx+1}: {e}")
                continue

        # Now extract images for each section using MCP query
        await self._extract_images_for_sections()

    async def _extract_images_for_sections(self):
        """Query images and associate them with sections based on y-position"""

        try:
            img_result = self.mcp.call_tool('query_elements', {
                'instance_id': self.instance_id,
                'selector': 'img'
            })

            all_images = []
            if isinstance(img_result, dict) and 'content' in img_result:
                content = img_result['content']
                if isinstance(content, list) and content:
                    all_images = json.loads(content[0].get('text', '[]'))

            print(f"      Found {len(all_images)} images to associate with sections")

            for img in all_images:
                if not img:
                    continue

                bbox = img.get('bounding_box') or {}
                if not bbox:
                    continue

                img_y = bbox.get('y', 0)
                img_height = bbox.get('height', 0)
                img_width = bbox.get('width', 0)

                # Skip tiny images
                if img_height < 50 or img_width < 50:
                    continue

                # Get image source
                attrs = img.get('attributes', {})
                src = attrs.get('src', '') or attrs.get('data-src', '') or ''

                if not src or src.startswith('data:'):
                    continue

                # Find which section this image belongs to
                for section in self.sections:
                    section_y = section.get('y_position', 0)
                    section_height = section.get('height', 0)

                    # Check if image is within section bounds (with some tolerance)
                    if section_y - 100 <= img_y <= section_y + section_height + 100:
                        # Add image to this section
                        if 'images' not in section:
                            section['images'] = []

                        img_data = {
                            'src': src,
                            'alt': attrs.get('alt', ''),
                            'width': img_width,
                            'height': img_height,
                            'y': img_y
                        }

                        # Avoid duplicates
                        existing_srcs = [i.get('src', '') for i in section['images']]
                        if src not in existing_srcs:
                            section['images'].append(img_data)

                            # Set section_image if not set
                            if not section.get('section_image'):
                                section['section_image'] = src

                        break  # Image belongs to one section only

            # Log image associations
            for idx, section in enumerate(self.sections):
                img_count = len(section.get('images', []))
                if img_count > 0:
                    print(f"      Section {idx+1}: {img_count} images associated")

        except Exception as e:
            print(f"      Warning: Image association failed: {e}")

    async def _extract_element_data(self, element: Dict, selector_type: str) -> Optional[Dict]:
        """Extract detailed data for a single element (legacy method)"""

        element_id = element.get('elementId') or element.get('backendNodeId')
        if not element_id:
            return None

        try:
            # Get element state for position and styles
            state_result = self.mcp.call_tool('get_element_state', {
                'instance_id': self.instance_id,
                'selector': f'[data-element-id="{element_id}"]' if isinstance(element_id, str) else f':nth-child({element_id})'
            })

            # Extract styles using CDP for accuracy
            style_result = self.mcp.call_tool('extract_element_styles', {
                'instance_id': self.instance_id,
                'selector': element.get('selector', selector_type)
            })

            # Parse results
            styles = {}
            if isinstance(style_result, dict) and 'content' in style_result:
                content = style_result['content']
                if isinstance(content, list) and content:
                    styles = json.loads(content[0].get('text', '{}'))

            # Build section data
            section_data = {
                'type': self._detect_section_type(selector_type, element),
                'selector': element.get('selector', selector_type),
                'bounds': element.get('bounds', {}),
                'styles': {
                    'backgroundColor': styles.get('backgroundColor', 'transparent'),
                    'color': styles.get('color', '#000000'),
                    'fontSize': styles.get('fontSize', '16px'),
                    'fontFamily': styles.get('fontFamily', 'inherit'),
                    'padding': styles.get('padding', '0'),
                    'margin': styles.get('margin', '0'),
                    'display': styles.get('display', 'block'),
                    'flexDirection': styles.get('flexDirection', 'row'),
                    'justifyContent': styles.get('justifyContent', 'flex-start'),
                    'alignItems': styles.get('alignItems', 'stretch'),
                    'gap': styles.get('gap', '0'),
                },
                'content': {
                    'text': element.get('textContent', '')[:500],
                    'tagName': element.get('tagName', 'div'),
                    'className': element.get('className', ''),
                },
                'children': element.get('childCount', 0)
            }

            return section_data

        except Exception as e:
            print(f"   Warning: Failed to extract element data: {e}")
            return None

    def _detect_section_type(self, selector: str, element: Dict) -> str:
        """Detect the semantic type of a section"""
        selector_lower = selector.lower()
        class_name = element.get('className', '').lower()
        tag_name = element.get('tagName', '').lower()

        type_mappings = [
            (['nav', 'navbar', 'navigation', 'menu'], 'navigation'),
            (['header', 'masthead'], 'header'),
            (['hero', 'banner', 'jumbotron', 'splash'], 'hero'),
            (['about', 'intro', 'overview'], 'about'),
            (['feature', 'benefit', 'highlight'], 'features'),
            (['service', 'offering', 'solution'], 'services'),
            (['testimonial', 'review', 'quote'], 'testimonials'),
            (['team', 'staff', 'people'], 'team'),
            (['pricing', 'plan', 'package'], 'pricing'),
            (['portfolio', 'gallery', 'showcase', 'work'], 'portfolio'),
            (['contact', 'reach', 'connect'], 'contact'),
            (['cta', 'call-to-action', 'action'], 'cta'),
            (['footer', 'bottom'], 'footer'),
            (['faq', 'question'], 'faq'),
            (['blog', 'article', 'post', 'news'], 'blog'),
        ]

        for keywords, section_type in type_mappings:
            for keyword in keywords:
                if keyword in selector_lower or keyword in class_name or keyword in tag_name:
                    return section_type

        return 'content'

    async def _download_images(self, page_content: Dict):
        """Download all images from the page and associate with sections"""

        # Collect all image URLs from sections
        all_image_urls = set()

        for section in self.sections:
            section_images = section.get('images', [])
            for img in section_images:
                src = img.get('src', '')
                if src and not src.startswith('data:'):
                    if not src.startswith('http'):
                        src = urljoin(self.url, src)
                    all_image_urls.add(src)

            # Also check background images
            bg_img = section.get('background_image', '')
            if bg_img and not bg_img.startswith('data:'):
                if not bg_img.startswith('http'):
                    bg_img = urljoin(self.url, bg_img)
                all_image_urls.add(bg_img)

        # Also query for any additional images not yet found
        try:
            img_result = self.mcp.call_tool('query_elements', {
                'instance_id': self.instance_id,
                'selector': 'img'
            })

            if isinstance(img_result, dict) and 'content' in img_result:
                content = img_result['content']
                if isinstance(content, list) and content:
                    images = json.loads(content[0].get('text', '[]'))
                    for img in images:
                        src = img.get('src', '') or img.get('attributes', {}).get('src', '')
                        if src and not src.startswith('data:'):
                            if not src.startswith('http'):
                                src = urljoin(self.url, src)
                            all_image_urls.add(src)
        except Exception as e:
            print(f"   Warning: Additional image query failed: {e}")

        # Download all images
        for i, src in enumerate(list(all_image_urls)[:50]):  # Limit to 50 images
            try:
                image_path = await self._download_single_image(src, i)
                if image_path:
                    self.downloaded_images[src] = image_path
            except Exception as e:
                print(f"   Failed to download {src}: {e}")

        # Update sections with local image paths
        for section in self.sections:
            section_images = section.get('images', [])
            for img in section_images:
                src = img.get('src', '')
                if not src.startswith('http'):
                    src = urljoin(self.url, src)
                if src in self.downloaded_images:
                    img['local_path'] = self.downloaded_images[src]

            # Update background image
            bg_img = section.get('background_image', '')
            if bg_img:
                if not bg_img.startswith('http'):
                    bg_img = urljoin(self.url, bg_img)
                if bg_img in self.downloaded_images:
                    section['background_image_local'] = self.downloaded_images[bg_img]

        print(f"   Downloaded {len(self.downloaded_images)} images")

    async def _download_single_image(self, url: str, index: int) -> Optional[str]:
        """Download a single image"""
        import requests

        try:
            response = requests.get(url, timeout=10, stream=True)
            response.raise_for_status()

            # Determine file extension
            content_type = response.headers.get('content-type', '')
            ext = '.jpg'
            if 'png' in content_type:
                ext = '.png'
            elif 'gif' in content_type:
                ext = '.gif'
            elif 'webp' in content_type:
                ext = '.webp'
            elif 'svg' in content_type:
                ext = '.svg'

            # Generate filename
            filename = f"image_{index:03d}{ext}"
            filepath = os.path.join(self.images_dir, filename)

            # Save image
            with open(filepath, 'wb') as f:
                for chunk in response.iter_content(chunk_size=8192):
                    f.write(chunk)

            return filepath

        except Exception as e:
            return None

    async def _extract_typography(self):
        """Extract typography information from the page"""
        try:
            # Execute JavaScript to get computed styles
            script = """
            (() => {
                const elements = document.querySelectorAll('h1, h2, h3, h4, h5, h6, p, a, span, li');
                const typography = {};

                elements.forEach(el => {
                    const style = window.getComputedStyle(el);
                    const key = el.tagName.toLowerCase();

                    if (!typography[key]) {
                        typography[key] = {
                            fontFamily: style.fontFamily,
                            fontSize: style.fontSize,
                            fontWeight: style.fontWeight,
                            lineHeight: style.lineHeight,
                            color: style.color,
                            letterSpacing: style.letterSpacing
                        };
                    }
                });

                return typography;
            })()
            """

            result = self.mcp.call_tool('execute_script', {
                'instance_id': self.instance_id,
                'script': script
            })

            if isinstance(result, dict) and 'content' in result:
                content = result['content']
                if isinstance(content, list) and content:
                    data = json.loads(content[0].get('text', '{}'))
                    self.typography_system = data.get('result', {})

            print(f"   Extracted typography for {len(self.typography_system)} elements")

        except Exception as e:
            print(f"   Warning: Typography extraction failed: {e}")

    def _build_template_data(self, page_content: Dict) -> Dict[str, Any]:
        """Build the final template data structure - matches SQLGenerator expected format"""

        return {
            # Required fields for SQLGenerator
            'template_name': self.template_name,
            'source_url': self.url,
            'sections': self.sections,
            # Additional metadata
            'metadata': {
                'name': self.template_name,
                'source_url': self.url,
                'domain': self.domain,
                'scraped_at': datetime.now().isoformat(),
                'scraper': 'StealthBrowserMCP',
                'version': '1.0'
            },
            'typography': self.typography_system,
            'grid_system': self.grid_system,
            'images': {
                'directory': self.images_dir,
                'count': len(self.downloaded_images),
                'mapping': self.downloaded_images
            },
            'custom_fonts': self.custom_fonts,
            'raw_html': page_content.get('html', '')[:50000]  # Limit HTML size
        }


async def import_from_url(url: str, template_name: str = None, timeout: int = 300) -> Dict[str, Any]:
    """
    Convenience function to import a website template

    Args:
        url: Website URL to import
        template_name: Name for the template
        timeout: Timeout in seconds

    Returns:
        Template data dictionary
    """
    # Ensure environment is set
    env_file = os.path.expanduser('~/stealth_env.sh')
    if os.path.exists(env_file):
        with open(env_file, 'r') as f:
            for line in f:
                if line.startswith('export '):
                    parts = line[7:].split('=', 1)
                    if len(parts) == 2:
                        key = parts[0].strip()
                        value = parts[1].strip().strip('"\'')
                        os.environ[key] = value

    os.environ.setdefault('SERVER_IP', '10.20.14.193')
    os.environ.setdefault('SERVER_PORT', '8000')

    scraper = StealthBrowserScraper(url, template_name, timeout)
    return await scraper.scrape_website()


# Command-line interface
if __name__ == '__main__':
    import sys

    if len(sys.argv) < 2:
        print("""
Stealth Browser MCP - Website Template Scraper

Usage:
    python stealth_browser_scraper.py <url> [template_name] [timeout_seconds]

Examples:
    python stealth_browser_scraper.py https://example.com
    python stealth_browser_scraper.py https://dribbble.com/shots dribbble_shots 600

Requirements:
    - Stealth Browser MCP server running
    - Environment variables set: source ~/stealth_env.sh
        """)
        sys.exit(1)

    url = sys.argv[1]
    template_name = sys.argv[2] if len(sys.argv) > 2 else None
    timeout = int(sys.argv[3]) if len(sys.argv) > 3 else 300

    try:
        result = asyncio.run(import_from_url(url, template_name, timeout))

        # Save result
        output_file = f"scraped_{result['metadata']['name']}.json"
        with open(output_file, 'w') as f:
            json.dump(result, f, indent=2, default=str)

        print(f"\nTemplate saved to: {output_file}")

    except KeyboardInterrupt:
        print("\n\nCancelled by user")
        sys.exit(1)
    except Exception as e:
        print(f"\nError: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)
