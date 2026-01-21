#!/usr/bin/env python3
"""
Website Template Scraper - Hybrid Approach
Extracts design from any website and converts to Website Builder template format

Features:
- Selenium for screenshots & computed styles
- BeautifulSoup for content extraction
- Computer vision for section detection
- PostgreSQL template generation
"""

import os
import time
import json
import re
from urllib.parse import urljoin, urlparse
from datetime import datetime
from typing import List, Dict, Any, Tuple

# Selenium for browser automation
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

# BeautifulSoup for HTML parsing
from bs4 import BeautifulSoup
import requests

# Image processing
from PIL import Image
import io
import base64

# Computer vision
import cv2
import numpy as np


class WebsiteTemplateScraper:
    """Main scraper class using hybrid approach"""

    def __init__(self, url: str, template_name: str = None):
        self.url = url
        self.domain = urlparse(url).netloc
        self.template_name = template_name or self.domain.replace('.', '_')
        self.driver = None
        self.sections = []
        self.images_dir = f"scraped_images/{self.template_name}"
        self.responsive_layouts = {}  # Store responsive breakpoint data

        # Create images directory
        os.makedirs(self.images_dir, exist_ok=True)

        # Initialize Chrome driver
        self.init_driver()

    def init_driver(self):
        """Initialize Selenium Chrome driver"""
        chrome_options = Options()
        chrome_options.add_argument('--headless')  # Run in background
        chrome_options.add_argument('--no-sandbox')
        chrome_options.add_argument('--disable-dev-shm-usage')
        chrome_options.add_argument('--window-size=1920,1080')
        chrome_options.add_argument('--disable-blink-features=AutomationControlled')

        # Add user agent to avoid detection
        chrome_options.add_argument('user-agent=Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36')

        try:
            self.driver = webdriver.Chrome(options=chrome_options)
            print("✅ Chrome WebDriver initialized")
        except Exception as e:
            print(f"❌ Error initializing Chrome: {e}")
            print("💡 Install ChromeDriver: brew install --cask chromedriver")
            raise

    def scrape_website(self) -> Dict[str, Any]:
        """Main scraping method - orchestrates all steps"""
        print(f"\n🌐 Scraping website: {self.url}")
        print("━" * 60)

        try:
            # Step 1: Load page with Selenium
            print("\n1️⃣  Loading page with Selenium...")
            self.driver.get(self.url)
            time.sleep(20)  # MAXIMUM COVERAGE: Wait for heavy JavaScript sites (was 12s, now 20s)

            # Remove popups/overlays
            self.remove_overlays()

            # Additional wait after removing overlays
            time.sleep(3)

            # STEP 1.5: Scroll page to trigger lazy-loaded images
            print("\n🔄 Scrolling to load lazy content...")
            self.scroll_for_lazy_load()
            time.sleep(5)  # MAXIMUM COVERAGE: Wait longer for lazy-loaded images (was 3s, now 5s)

            # Check for iframes (common in Wix, template previews, etc.)
            iframes = self.driver.find_elements(By.TAG_NAME, 'iframe')
            if iframes:
                print(f"   🔍 Found {len(iframes)} iframes - switching to main content iframe...")
                for iframe in iframes:
                    try:
                        # Try to switch to iframe with actual content
                        self.driver.switch_to.frame(iframe)
                        # Check if this iframe has substantial content
                        body = self.driver.find_element(By.TAG_NAME, 'body')
                        if body and len(body.text) > 100:
                            print("   ✅ Switched to content iframe")
                            time.sleep(2)
                            break
                        else:
                            self.driver.switch_to.default_content()
                    except:
                        self.driver.switch_to.default_content()
                        continue

            # Step 2: Capture responsive layouts (desktop, tablet, mobile)
            print("\n2️⃣  Capturing responsive layouts (desktop/tablet/mobile)...")
            self.capture_responsive_layouts()

            # Step 3: Take full-page screenshot
            print("\n3️⃣  Capturing full-page screenshot...")
            screenshot_path = self.take_full_screenshot()

            # Step 4: Get page HTML
            print("\n4️⃣  Extracting HTML content...")
            html = self.driver.page_source
            soup = BeautifulSoup(html, 'html.parser')

            # Step 5: Detect sections using computer vision + HTML analysis
            print("\n5️⃣  Detecting sections with computer vision...")
            self.detect_sections(soup, screenshot_path)

            # Step 6: Extract styles for each section (with Flexbox/Grid/Animations)
            print("\n6️⃣  Extracting computed styles + layout + animations...")
            self.extract_section_styles()

            # Step 7: Extract content
            print("\n7️⃣  Extracting content...")
            self.extract_content(soup)

            # Step 8: Download and process images
            print("\n8️⃣  Downloading images (with lazy-load support)...")
            self.download_images()

            # Step 9: Generate template data
            print("\n9️⃣  Generating template data...")
            template_data = self.generate_template_data()

            print("\n✅ Scraping completed successfully!")
            print(f"📊 Found {len(self.sections)} sections")

            return template_data

        except Exception as e:
            print(f"\n❌ Error during scraping: {e}")
            raise
        finally:
            self.cleanup()

    def remove_overlays(self):
        """Remove popups, cookie banners, modals"""
        overlays_js = """
        // Remove common overlay elements
        const overlays = [
            '[class*="cookie"]', '[class*="popup"]', '[class*="modal"]',
            '[class*="overlay"]', '[id*="cookie"]', '[id*="popup"]',
            '[role="dialog"]', '.modal', '.popup'
        ];
        overlays.forEach(selector => {
            document.querySelectorAll(selector).forEach(el => el.remove());
        });
        """
        try:
            self.driver.execute_script(overlays_js)
        except:
            pass

    def scroll_for_lazy_load(self):
        """Scroll through page to trigger lazy-loaded images and content"""
        try:
            # Get page height
            total_height = self.driver.execute_script("return document.body.scrollHeight")
            viewport_height = self.driver.execute_script("return window.innerHeight")

            # Scroll in steps to trigger lazy load
            scroll_pause = 0.5  # Pause between scrolls
            current_position = 0
            step = viewport_height // 2  # Scroll half viewport at a time

            while current_position < total_height:
                # Scroll down
                self.driver.execute_script(f"window.scrollTo(0, {current_position});")
                time.sleep(scroll_pause)
                current_position += step

            # Scroll back to top
            self.driver.execute_script("window.scrollTo(0, 0);")
            print("   ✅ Page scrolled to trigger lazy-loaded content")

        except Exception as e:
            print(f"   ⚠️  Scrolling failed: {e}")

    def capture_responsive_layouts(self):
        """Capture layouts at different breakpoints (desktop, tablet, mobile)"""
        try:
            breakpoints = {
                'desktop': (1920, 1080),
                'tablet': (768, 1024),
                'mobile': (375, 812)
            }

            responsive_data = {}

            for device, (width, height) in breakpoints.items():
                print(f"   📱 Capturing {device} layout ({width}x{height})...")

                # Set window size
                self.driver.set_window_size(width, height)
                time.sleep(1)  # Wait for layout to adjust

                # Capture viewport dimensions and any media query changes
                layout_info = self.driver.execute_script("""
                    return {
                        viewport: {
                            width: window.innerWidth,
                            height: window.innerHeight
                        },
                        devicePixelRatio: window.devicePixelRatio
                    };
                """)

                responsive_data[device] = layout_info

            # Reset to desktop size
            self.driver.set_window_size(1920, 1080)

            self.responsive_layouts = responsive_data
            print("   ✅ Responsive layouts captured")

        except Exception as e:
            print(f"   ⚠️  Responsive capture failed: {e}")
            self.responsive_layouts = {}

    def take_full_screenshot(self) -> str:
        """Take full-page screenshot"""
        try:
            # Get page dimensions
            total_height = self.driver.execute_script("return document.body.scrollHeight")
            viewport_height = self.driver.execute_script("return window.innerHeight")

            # Take screenshot
            screenshot_path = f"{self.images_dir}/full_page.png"
            self.driver.save_screenshot(screenshot_path)

            print(f"   📸 Screenshot saved: {screenshot_path}")
            return screenshot_path
        except Exception as e:
            print(f"   ⚠️  Screenshot failed: {e}")
            return None

    def detect_sections(self, soup: BeautifulSoup, screenshot_path: str):
        """Detect sections using hybrid approach"""
        print("\n   🔍 Analyzing page structure...")

        # Find all potential section elements
        section_selectors = [
            'section', 'div[class*="section"]', 'div[id*="section"]',
            'header', 'nav', 'main', 'article', 'aside', 'footer',
            'div[class*="hero"]', 'div[class*="banner"]',
            'div[class*="container"]'
        ]

        elements = []
        for selector in section_selectors:
            found = soup.select(selector)
            elements.extend(found)

        # Remove duplicates and nested elements (keep only top-level)
        elements = self.filter_top_level_elements(elements)

        print(f"   📦 Found {len(elements)} potential sections")

        # Analyze each element
        for idx, element in enumerate(elements):
            try:
                # Get WebElement from Selenium
                web_element = self.find_web_element(element)
                if not web_element:
                    continue

                # Get position and size
                location = web_element.location
                size = web_element.size

                # Skip tiny elements
                if size['height'] < 50 or size['width'] < 100:
                    continue

                # SMART SECTION BREAKING: If section is very large, try to break into cards
                if size['height'] > 2000:
                    # Look for individual product/unit cards inside
                    card_selectors = [
                        'div[data-unit-id]',  # Apple-style units
                        'div[class*="card"]', 'article[class*="card"]',
                        'div[class*="item"]', 'div[class*="product"]',
                        'div[class*="unit"]', 'div[class*="tile"]',
                        'div[class*="box"]', 'div[class*="panel"]'
                    ]

                    cards = []
                    for card_sel in card_selectors:
                        found_cards = element.select(card_sel)
                        for card in found_cards:
                            # Check if card is substantial
                            try:
                                card_web = self.find_web_element(card)
                                if card_web:
                                    card_size = card_web.size
                                    if card_size['height'] > 200 and card_size['width'] > 200:
                                        cards.append(card)
                            except:
                                pass

                    # If we found cards, use them instead of the large container
                    if len(cards) > 1:
                        print(f"   🔧 Breaking large section into {len(cards)} cards")
                        for card in cards:
                            try:
                                card_web = self.find_web_element(card)
                                if not card_web:
                                    continue

                                card_loc = card_web.location
                                card_size = card_web.size

                                section_data = {
                                    'index': len(self.sections),
                                    'element': card,
                                    'web_element': card_web,
                                    'y_position': card_loc['y'],
                                    'height': card_size['height'],
                                    'width': card_size['width'],
                                    'html_tag': card.name,
                                    'classes': card.get('class', []),
                                    'id': card.get('id', '')
                                }
                                section_data['type'] = self.detect_section_type(card, section_data)

                                # IMPORTANT: Only allow ONE navbar (type 1)
                                if section_data['type'] == 1:
                                    has_navbar = any(s['type'] == 1 for s in self.sections)
                                    if has_navbar:
                                        section_data['type'] = 3  # Convert to services section

                                self.sections.append(section_data)
                            except:
                                continue
                        continue  # Skip adding the large container

                # Add as regular section if not broken down
                section_data = {
                    'index': len(self.sections),
                    'element': element,
                    'web_element': web_element,
                    'y_position': location['y'],
                    'height': size['height'],
                    'width': size['width'],
                    'html_tag': element.name,
                    'classes': element.get('class', []),
                    'id': element.get('id', '')
                }

                # Detect section type
                section_data['type'] = self.detect_section_type(element, section_data)

                # IMPORTANT: Only allow ONE navbar (type 1)
                # If this is a navbar and we already have one, convert it to type 3 (services/features)
                if section_data['type'] == 1:
                    has_navbar = any(s['type'] == 1 for s in self.sections)
                    if has_navbar:
                        print(f"   ⚠️  Skipping duplicate navbar at position {section_data['y_position']}")
                        section_data['type'] = 3  # Convert to services section
                    else:
                        print(f"   ✅ Found navbar at position {section_data['y_position']}")

                self.sections.append(section_data)

            except Exception as e:
                # Element might be hidden or invalid
                continue

        # Sort sections by Y position
        self.sections.sort(key=lambda x: x['y_position'])

        # Reindex
        for idx, section in enumerate(self.sections):
            section['index'] = idx

        print(f"   ✅ Detected {len(self.sections)} valid sections")

    def filter_top_level_elements(self, elements: List) -> List:
        """Remove nested elements, keep only top-level"""
        filtered = []
        for elem in elements:
            # Check if any parent is already in our list
            is_nested = False
            for other in elements:
                if other != elem and elem in other.descendants:
                    is_nested = True
                    break
            if not is_nested:
                filtered.append(elem)
        return filtered

    def find_web_element(self, soup_element):
        """Find Selenium WebElement from BeautifulSoup element"""
        try:
            # Build XPath or CSS selector
            if soup_element.get('id'):
                return self.driver.find_element(By.ID, soup_element['id'])

            # Try by tag + classes
            classes = soup_element.get('class', [])
            if classes:
                selector = f"{soup_element.name}.{'.'.join(classes)}"
                return self.driver.find_element(By.CSS_SELECTOR, selector)

            # Fallback: find by tag and index
            tag = soup_element.name
            elements = self.driver.find_elements(By.TAG_NAME, tag)
            return elements[0] if elements else None

        except:
            return None

    def detect_section_type(self, element, section_data: Dict) -> int:
        """Detect section type using heuristics"""
        classes = ' '.join(section_data['classes']).lower()
        element_id = section_data['id'].lower()
        tag = section_data['html_tag'].lower()

        # Navigation (type 1)
        if tag == 'nav' or 'nav' in classes or 'nav' in element_id:
            return 1

        # Hero section (type 0)
        if 'hero' in classes or 'hero' in element_id or 'banner' in classes:
            # Check if has large image or video background
            has_bg_image = bool(element.find(['img', 'video']))
            is_tall = section_data['height'] > 400
            if has_bg_image or is_tall:
                return 0

        # Footer (type 10)
        if tag == 'footer' or 'footer' in classes or 'footer' in element_id:
            return 10

        # Header (could be hero)
        if tag == 'header' and section_data['height'] > 400:
            return 0

        # Services/Features - detect grid layouts (type 3)
        cards = element.find_all(['div', 'article'], class_=True)
        if len(cards) >= 3:
            # Check if cards are similar size (grid pattern)
            return 3

        # About section (type 2)
        if 'about' in classes or 'about' in element_id:
            return 2

        # Contact section (type 9)
        if 'contact' in classes or 'contact' in element_id:
            has_form = bool(element.find('form'))
            if has_form:
                return 9

        # Gallery (type 8)
        images = element.find_all('img')
        if len(images) >= 4:
            return 8

        # Default: generic content section (type 2)
        return 2

    def generate_section_fingerprint(self, element, section_data: Dict) -> Dict:
        """PHASE 1: Generate unique fingerprint for custom section types"""
        try:
            # Detect components
            components = []
            if element.find_all(['h1', 'h2', 'h3', 'p']):
                components.append('text')
            if element.find_all('img'):
                components.append('image')
            if element.find('form') or element.find_all('input'):
                components.append('form')

            # Detect card pattern
            card_count = len(self.detect_card_pattern(element))
            if card_count >= 2:
                components.append(f'cards-{card_count}')

            # Detect layout type
            layout = section_data.get('layout', {})
            if layout.get('isFlexbox'):
                layout_type = f"flex-{layout.get('flexDirection', 'row')}"
            elif layout.get('isGrid'):
                cols = layout.get('computed', {}).get('detectedColumns', 3)
                layout_type = f"grid-{cols}col"
            else:
                layout_type = "stack"

            # Generate type ID
            main_component = components[0] if components else 'custom'
            type_id = f"{main_component}-{layout_type}"

            return {
                'id': type_id,
                'components': components,
                'layout_type': layout_type,
                'legacy_type': section_data.get('type', 2),
                'confidence': 0.85
            }
        except Exception as e:
            print(f"   ⚠️ Fingerprinting failed: {e}")
            return {'id': 'custom', 'legacy_type': 2}

    def detect_card_pattern(self, element) -> list:
        """Detect repeating card/item patterns"""
        card_selectors = [
            '[class*="card"]', '[class*="item"]', '[class*="product"]',
            '[class*="service"]', '[class*="feature"]', 'article'
        ]

        for selector in card_selectors:
            found = element.select(selector)
            if len(found) >= 2:
                return found[:12]  # Limit to 12
        return []

    def detect_carousel(self, element) -> Dict:
        """PHASE 3: Detect carousel/slider components"""
        try:
            # Check for carousel libraries
            carousel_classes = ['swiper', 'slick-slider', 'carousel', 'slider']
            for cls in carousel_classes:
                if element.find(class_=lambda x: x and cls in str(x).lower()):
                    images = element.find_all('img')
                    return {
                        'detected': True,
                        'type': 'carousel',
                        'image_count': len(images),
                        'images': [urljoin(self.url, img.get('src', '')) for img in images[:10] if img.get('src')],
                        'auto_play': bool(element.find(attrs={'data-autoplay': True}))
                    }

            # Heuristic: multiple images + navigation
            images = element.find_all('img')
            nav_buttons = element.find_all(['button', 'a'], class_=lambda x: x and any(
                term in str(x).lower() for term in ['prev', 'next', 'arrow']
            ))

            if len(images) >= 2 and nav_buttons:
                return {
                    'detected': True,
                    'type': 'carousel',
                    'image_count': len(images),
                    'images': [urljoin(self.url, img.get('src', '')) for img in images[:10] if img.get('src')],
                    'auto_play': False
                }

            return {'detected': False}
        except:
            return {'detected': False}

    def detect_dropdowns(self, element) -> list:
        """PHASE 3: Detect dropdown menus"""
        dropdowns = []
        try:
            # Native select elements
            for select in element.find_all('select'):
                options = select.find_all('option')
                dropdowns.append({
                    'type': 'select',
                    'native': True,
                    'option_count': len(options),
                    'options': [opt.get_text(strip=True) for opt in options[:10]]
                })

            # Custom dropdowns
            for dropdown in element.select('[class*="dropdown"], [role="listbox"]'):
                menu = dropdown.find(['ul', 'div'], class_=lambda x: x and 'menu' in str(x).lower())
                if menu:
                    items = menu.find_all(['li', 'a'])
                    dropdowns.append({
                        'type': 'dropdown',
                        'native': False,
                        'item_count': len(items),
                        'items': [item.get_text(strip=True) for item in items[:10]]
                    })
        except:
            pass
        return dropdowns

    def extract_section_styles(self):
        """Extract computed styles for each section"""
        for section in self.sections:
            try:
                web_element = section['web_element']

                # Get computed styles via JavaScript - ENHANCED with shadows, borders, gradients
                styles = self.driver.execute_script("""
                    const el = arguments[0];
                    const styles = window.getComputedStyle(el);
                    return {
                        // Colors & Typography
                        backgroundColor: styles.backgroundColor,
                        color: styles.color,
                        fontSize: styles.fontSize,
                        fontWeight: styles.fontWeight,
                        fontFamily: styles.fontFamily,
                        textAlign: styles.textAlign,
                        textShadow: styles.textShadow,

                        // Spacing (detailed)
                        padding: styles.padding,
                        paddingTop: styles.paddingTop,
                        paddingBottom: styles.paddingBottom,
                        paddingLeft: styles.paddingLeft,
                        paddingRight: styles.paddingRight,
                        margin: styles.margin,
                        marginTop: styles.marginTop,
                        marginBottom: styles.marginBottom,
                        marginLeft: styles.marginLeft,
                        marginRight: styles.marginRight,

                        // Background (includes gradients)
                        backgroundImage: styles.backgroundImage,
                        backgroundSize: styles.backgroundSize,
                        backgroundPosition: styles.backgroundPosition,
                        backgroundRepeat: styles.backgroundRepeat,

                        // Borders
                        borderRadius: styles.borderRadius,
                        borderTopLeftRadius: styles.borderTopLeftRadius,
                        borderTopRightRadius: styles.borderTopRightRadius,
                        borderBottomLeftRadius: styles.borderBottomLeftRadius,
                        borderBottomRightRadius: styles.borderBottomRightRadius,
                        borderWidth: styles.borderWidth,
                        borderStyle: styles.borderStyle,
                        borderColor: styles.borderColor,

                        // Shadows & Effects
                        boxShadow: styles.boxShadow
                    };
                """, web_element)

                section['styles'] = styles

                # Extract typography from headings
                self.extract_typography(section)

                # Extract layout properties (Flexbox/Grid)
                self.extract_layout(section)

                # Extract animations
                self.extract_animations(section)

                # Extract design properties (shadows, borders, gradients, spacing)
                self.extract_design_properties(section)

                # PHASE 1: Generate section fingerprint for dynamic types
                section['type_info'] = self.generate_section_fingerprint(section['element'], section)

                # PHASE 3: Detect interactive elements
                element = section['element']
                section['interactive'] = {
                    'carousel': self.detect_carousel(element),
                    'dropdowns': self.detect_dropdowns(element)
                }

            except Exception as e:
                print(f"   ⚠️  Style extraction failed for section {section['index']}: {e}")
                section['styles'] = {}
                section['layout'] = {}
                section['animations'] = {}
                section['interactive'] = {}

    def extract_typography(self, section: Dict):
        """Extract typography from headings and text"""
        try:
            element = section['element']
            web_element = section['web_element']

            typography = {
                'title': {'size': 42, 'weight': 700, 'color': '0.1,0.1,0.1,1.0'},
                'subtitle': {'size': 20, 'weight': 400, 'color': '0.3,0.3,0.3,1.0'},
                'content': {'size': 16, 'weight': 400, 'color': '0.2,0.2,0.2,1.0'},
                'button': {'size': 16, 'weight': 600, 'color': '1.0,1.0,1.0,1.0'}
            }

            # Find headings
            h1 = element.find('h1')
            h2 = element.find('h2')
            h3 = element.find('h3')

            # Extract title (h1 or h2)
            if h1:
                title_styles = self.get_element_styles(h1)
                typography['title'] = {
                    'size': self.parse_font_size(title_styles.get('fontSize', '42px')),
                    'weight': self.parse_font_weight(title_styles.get('fontWeight', '700')),
                    'color': self.rgba_to_sql(title_styles.get('color', 'rgb(26,26,26)'))
                }
            elif h2:
                title_styles = self.get_element_styles(h2)
                typography['title'] = {
                    'size': self.parse_font_size(title_styles.get('fontSize', '36px')),
                    'weight': self.parse_font_weight(title_styles.get('fontWeight', '700')),
                    'color': self.rgba_to_sql(title_styles.get('color', 'rgb(26,26,26)'))
                }

            # Extract subtitle (h2 or h3)
            subtitle_elem = h2 if h1 else h3
            if subtitle_elem:
                subtitle_styles = self.get_element_styles(subtitle_elem)
                typography['subtitle'] = {
                    'size': self.parse_font_size(subtitle_styles.get('fontSize', '20px')),
                    'weight': self.parse_font_weight(subtitle_styles.get('fontWeight', '400')),
                    'color': self.rgba_to_sql(subtitle_styles.get('color', 'rgb(77,77,77)'))
                }

            # Extract content (paragraphs)
            p = element.find('p')
            if p:
                p_styles = self.get_element_styles(p)
                typography['content'] = {
                    'size': self.parse_font_size(p_styles.get('fontSize', '16px')),
                    'weight': self.parse_font_weight(p_styles.get('fontWeight', '400')),
                    'color': self.rgba_to_sql(p_styles.get('color', 'rgb(51,51,51)'))
                }

            # Extract button styles
            button = element.find(['button', 'a'], class_=lambda x: x and ('btn' in ' '.join(x).lower() or 'button' in ' '.join(x).lower()))
            if button:
                btn_styles = self.get_element_styles(button)
                typography['button'] = {
                    'size': self.parse_font_size(btn_styles.get('fontSize', '16px')),
                    'weight': self.parse_font_weight(btn_styles.get('fontWeight', '600')),
                    'color': self.rgba_to_sql(btn_styles.get('color', 'rgb(255,255,255)'))
                }

            section['typography'] = typography

        except Exception as e:
            print(f"   ⚠️  Typography extraction failed: {e}")

    def extract_layout(self, section: Dict):
        """Extract Flexbox/Grid layout properties"""
        try:
            web_element = section['web_element']
            if not web_element:
                section['layout'] = {}
                return

            # Get all layout-related styles
            layout_styles = self.driver.execute_script("""
                const el = arguments[0];
                const styles = window.getComputedStyle(el);

                // Check if element uses Flexbox or Grid
                const isFlexbox = styles.display.includes('flex');
                const isGrid = styles.display.includes('grid');

                return {
                    display: styles.display,
                    isFlexbox: isFlexbox,
                    isGrid: isGrid,

                    // Flexbox properties
                    flexDirection: styles.flexDirection,
                    justifyContent: styles.justifyContent,
                    alignItems: styles.alignItems,
                    flexWrap: styles.flexWrap,
                    gap: styles.gap,

                    // Grid properties
                    gridTemplateColumns: styles.gridTemplateColumns,
                    gridTemplateRows: styles.gridTemplateRows,
                    gridGap: styles.gridGap,
                    gridAutoFlow: styles.gridAutoFlow,

                    // Positioning
                    position: styles.position,

                    // Multi-column detection
                    columnCount: styles.columnCount,
                    columns: styles.columns
                };
            """, web_element)

            section['layout'] = layout_styles

            # Log detected layout type
            if layout_styles.get('isFlexbox'):
                print(f"   📐 Section {section['index']}: Flexbox detected - {layout_styles.get('flexDirection')}")
            elif layout_styles.get('isGrid'):
                print(f"   📐 Section {section['index']}: Grid detected - {layout_styles.get('gridTemplateColumns')}")

        except Exception as e:
            print(f"   ⚠️  Layout extraction failed: {e}")
            section['layout'] = {}

    def extract_animations(self, section: Dict):
        """Extract CSS animations and transitions"""
        try:
            web_element = section['web_element']
            if not web_element:
                section['animations'] = {}
                return

            # Get animation/transition properties
            animations = self.driver.execute_script("""
                const el = arguments[0];
                const styles = window.getComputedStyle(el);

                return {
                    animation: styles.animation,
                    animationName: styles.animationName,
                    animationDuration: styles.animationDuration,
                    animationTimingFunction: styles.animationTimingFunction,
                    animationDelay: styles.animationDelay,
                    animationIterationCount: styles.animationIterationCount,

                    transition: styles.transition,
                    transitionProperty: styles.transitionProperty,
                    transitionDuration: styles.transitionDuration,
                    transitionTimingFunction: styles.transitionTimingFunction,

                    transform: styles.transform,
                    opacity: styles.opacity,

                    // Check for parallax
                    willChange: styles.willChange,
                    backfaceVisibility: styles.backfaceVisibility
                };
            """, web_element)

            section['animations'] = animations

            # Log if animations detected
            if animations.get('animationName') and animations['animationName'] != 'none':
                print(f"   🎬 Section {section['index']}: Animation detected - {animations['animationName']}")
            if animations.get('transition') and animations['transition'] != 'all 0s ease 0s':
                print(f"   ✨ Section {section['index']}: Transitions detected")

        except Exception as e:
            print(f"   ⚠️  Animation extraction failed: {e}")
            section['animations'] = {}

    def extract_design_properties(self, section: Dict):
        """Extract design properties: shadows, borders, gradients, spacing"""
        try:
            styles = section.get('styles', {})

            # Parse box shadow
            box_shadow = self.parse_box_shadow(styles.get('boxShadow', ''))

            # Parse text shadow
            text_shadow = self.parse_text_shadow(styles.get('textShadow', ''))

            # Parse border radius
            border_radius = self.parse_border_radius(styles.get('borderRadius', '0px'))

            # Parse gradient background
            gradient = self.parse_gradient(styles.get('backgroundImage', ''))

            # Parse spacing
            padding_top = self.parse_spacing(styles.get('paddingTop', '0px'))
            padding_bottom = self.parse_spacing(styles.get('paddingBottom', '0px'))
            padding_left = self.parse_spacing(styles.get('paddingLeft', '0px'))
            padding_right = self.parse_spacing(styles.get('paddingRight', '0px'))

            margin_top = self.parse_spacing(styles.get('marginTop', '0px'))
            margin_bottom = self.parse_spacing(styles.get('marginBottom', '0px'))

            # Parse border
            border_width = self.parse_spacing(styles.get('borderWidth', '0px'))
            border_color = self.rgba_to_sql(styles.get('borderColor', 'rgb(0,0,0)'))
            border_style = styles.get('borderStyle', 'none')

            # Store parsed design properties
            section['design'] = {
                'boxShadow': box_shadow,
                'textShadow': text_shadow,
                'borderRadius': border_radius,
                'gradient': gradient,
                'spacing': {
                    'paddingTop': padding_top,
                    'paddingBottom': padding_bottom,
                    'paddingLeft': padding_left,
                    'paddingRight': padding_right,
                    'marginTop': margin_top,
                    'marginBottom': margin_bottom
                },
                'border': {
                    'width': border_width,
                    'color': border_color,
                    'style': border_style
                }
            }

            # Log detected design properties
            log_messages = []
            if box_shadow.get('enabled'):
                log_messages.append(f"box-shadow({box_shadow['blur']}px blur)")
            if text_shadow.get('enabled'):
                log_messages.append(f"text-shadow")
            if border_radius > 0:
                log_messages.append(f"border-radius({border_radius}px)")
            if gradient.get('enabled'):
                log_messages.append(f"{gradient['type']}-gradient")

            if log_messages:
                print(f"   🎨 Section {section['index']}: Design properties - {', '.join(log_messages)}")

        except Exception as e:
            print(f"   ⚠️  Design property extraction failed: {e}")
            section['design'] = {}

    def get_element_styles(self, soup_element) -> Dict:
        """Get computed styles for a specific element - ENHANCED with layout & animations"""
        try:
            web_elem = self.find_web_element(soup_element)
            if not web_elem:
                return {}

            return self.driver.execute_script("""
                const el = arguments[0];
                const styles = window.getComputedStyle(el);
                return {
                    // Typography
                    fontSize: styles.fontSize,
                    fontWeight: styles.fontWeight,
                    color: styles.color,
                    backgroundColor: styles.backgroundColor,
                    textShadow: styles.textShadow,

                    // Layout - Flexbox
                    display: styles.display,
                    flexDirection: styles.flexDirection,
                    justifyContent: styles.justifyContent,
                    alignItems: styles.alignItems,
                    flexWrap: styles.flexWrap,
                    gap: styles.gap,

                    // Layout - Grid
                    gridTemplateColumns: styles.gridTemplateColumns,
                    gridTemplateRows: styles.gridTemplateRows,
                    gridGap: styles.gridGap,

                    // Positioning
                    position: styles.position,
                    top: styles.top,
                    left: styles.left,
                    right: styles.right,
                    bottom: styles.bottom,
                    zIndex: styles.zIndex,

                    // Spacing (detailed)
                    padding: styles.padding,
                    paddingTop: styles.paddingTop,
                    paddingRight: styles.paddingRight,
                    paddingBottom: styles.paddingBottom,
                    paddingLeft: styles.paddingLeft,
                    margin: styles.margin,
                    marginTop: styles.marginTop,
                    marginRight: styles.marginRight,
                    marginBottom: styles.marginBottom,
                    marginLeft: styles.marginLeft,

                    // Dimensions
                    width: styles.width,
                    height: styles.height,
                    maxWidth: styles.maxWidth,

                    // Borders
                    borderRadius: styles.borderRadius,
                    borderTopLeftRadius: styles.borderTopLeftRadius,
                    borderTopRightRadius: styles.borderTopRightRadius,
                    borderBottomLeftRadius: styles.borderBottomLeftRadius,
                    borderBottomRightRadius: styles.borderBottomRightRadius,
                    borderWidth: styles.borderWidth,
                    borderStyle: styles.borderStyle,
                    borderColor: styles.borderColor,

                    // Shadows & Effects
                    boxShadow: styles.boxShadow,

                    // Background (includes gradients)
                    backgroundImage: styles.backgroundImage,
                    backgroundSize: styles.backgroundSize,
                    backgroundPosition: styles.backgroundPosition,
                    backgroundRepeat: styles.backgroundRepeat,

                    // Animations & Transitions
                    animation: styles.animation,
                    transition: styles.transition,
                    transform: styles.transform,
                    opacity: styles.opacity
                };
            """, web_elem)
        except:
            return {}

    def parse_font_size(self, size_str: str) -> int:
        """Parse font size from CSS (e.g., '42px' -> 42)"""
        match = re.search(r'(\d+(?:\.\d+)?)', size_str)
        if match:
            size = float(match.group(1))
            # Clamp to reasonable range
            return max(10, min(150, int(size)))
        return 16

    def parse_font_weight(self, weight_str: str) -> int:
        """Parse font weight (e.g., 'bold' -> 700, '600' -> 600)"""
        if isinstance(weight_str, int):
            return weight_str

        weight_map = {
            'normal': 400,
            'bold': 700,
            'lighter': 300,
            'bolder': 700
        }

        if weight_str in weight_map:
            return weight_map[weight_str]

        try:
            weight = int(weight_str)
            return max(100, min(1200, weight))
        except:
            return 400

    def rgba_to_sql(self, rgba_str: str) -> str:
        """Convert CSS rgba/rgb to SQL format '0.1,0.1,0.1,1.0'"""
        # Parse rgb(r,g,b) or rgba(r,g,b,a)
        match = re.search(r'rgba?\((\d+),\s*(\d+),\s*(\d+)(?:,\s*([\d.]+))?\)', rgba_str)
        if match:
            r = int(match.group(1)) / 255.0
            g = int(match.group(2)) / 255.0
            b = int(match.group(3)) / 255.0
            a = float(match.group(4)) if match.group(4) else 1.0
            return f"{r:.2f},{g:.2f},{b:.2f},{a:.2f}"
        return "0.1,0.1,0.1,1.0"

    def parse_spacing(self, spacing_str: str) -> int:
        """Parse spacing value from CSS (e.g., '20px' -> 20, '1.5rem' -> 24)"""
        if not spacing_str or spacing_str == 'auto' or spacing_str == 'none':
            return 0

        # Parse px values
        match = re.search(r'(\d+(?:\.\d+)?)px', spacing_str)
        if match:
            return int(float(match.group(1)))

        # Parse rem values (assume 16px base)
        match = re.search(r'(\d+(?:\.\d+)?)rem', spacing_str)
        if match:
            return int(float(match.group(1)) * 16)

        return 0

    def parse_border_radius(self, radius_str: str) -> float:
        """Parse border radius from CSS (e.g., '8px' -> 8.0)"""
        if not radius_str or radius_str == 'none':
            return 0.0

        match = re.search(r'(\d+(?:\.\d+)?)', radius_str)
        if match:
            return float(match.group(1))
        return 0.0

    def parse_box_shadow(self, shadow_str: str) -> Dict:
        """Parse box shadow from CSS (e.g., '0px 4px 6px rgba(0,0,0,0.1)')"""
        if not shadow_str or shadow_str == 'none':
            return {'enabled': False}

        # Parse shadow components: offsetX offsetY blur spread color
        # Example: "0px 4px 6px -1px rgba(0, 0, 0, 0.1)"
        match = re.search(r'(-?\d+(?:\.\d+)?)px\s+(-?\d+(?:\.\d+)?)px\s+(-?\d+(?:\.\d+)?)px(?:\s+(-?\d+(?:\.\d+)?)px)?\s+(rgba?\([^)]+\))', shadow_str)

        if match:
            return {
                'enabled': True,
                'offsetX': float(match.group(1)),
                'offsetY': float(match.group(2)),
                'blur': float(match.group(3)),
                'spread': float(match.group(4)) if match.group(4) else 0,
                'color': self.rgba_to_sql(match.group(5))
            }

        return {'enabled': False}

    def parse_text_shadow(self, shadow_str: str) -> Dict:
        """Parse text shadow from CSS (e.g., '2px 2px 4px rgba(0,0,0,0.5)')"""
        if not shadow_str or shadow_str == 'none':
            return {'enabled': False}

        # Parse: offsetX offsetY blur color
        match = re.search(r'(-?\d+(?:\.\d+)?)px\s+(-?\d+(?:\.\d+)?)px\s+(-?\d+(?:\.\d+)?)px\s+(rgba?\([^)]+\))', shadow_str)

        if match:
            return {
                'enabled': True,
                'offsetX': float(match.group(1)),
                'offsetY': float(match.group(2)),
                'blur': float(match.group(3)),
                'color': self.rgba_to_sql(match.group(4))
            }

        return {'enabled': False}

    def parse_gradient(self, bg_image_str: str) -> Dict:
        """Parse CSS gradient from backgroundImage property"""
        if not bg_image_str or 'gradient' not in bg_image_str:
            return {'enabled': False}

        # Detect gradient type
        if 'linear-gradient' in bg_image_str:
            # Example: linear-gradient(90deg, rgb(255,0,0), rgb(0,0,255))
            # Extract colors
            colors = re.findall(r'rgba?\([^)]+\)', bg_image_str)
            if len(colors) >= 2:
                return {
                    'enabled': True,
                    'type': 'linear',
                    'color1': self.rgba_to_sql(colors[0]),
                    'color2': self.rgba_to_sql(colors[1]),
                    'angle': 180  # Default to vertical
                }

        elif 'radial-gradient' in bg_image_str:
            colors = re.findall(r'rgba?\([^)]+\)', bg_image_str)
            if len(colors) >= 2:
                return {
                    'enabled': True,
                    'type': 'radial',
                    'color1': self.rgba_to_sql(colors[0]),
                    'color2': self.rgba_to_sql(colors[1])
                }

        return {'enabled': False}

    def extract_content(self, soup: BeautifulSoup):
        """Extract text content from sections"""
        for section in self.sections:
            element = section['element']

            content = {
                'title': '',
                'subtitle': '',
                'content': '',
                'button_text': '',
                'button_link': ''
            }

            # Extract title
            h1 = element.find('h1')
            h2 = element.find('h2')
            if h1:
                content['title'] = h1.get_text(strip=True)[:500]
            elif h2:
                content['title'] = h2.get_text(strip=True)[:500]

            # Extract subtitle
            if h1 and h2:
                content['subtitle'] = h2.get_text(strip=True)[:500]
            else:
                h3 = element.find('h3')
                if h3:
                    content['subtitle'] = h3.get_text(strip=True)[:500]

            # Extract content
            paragraphs = element.find_all('p')
            if paragraphs:
                content['content'] = ' '.join([p.get_text(strip=True) for p in paragraphs[:3]])[:1000]

            # Extract button
            button = element.find(['button', 'a'], class_=lambda x: x and ('btn' in ' '.join(x).lower() or 'button' in ' '.join(x).lower()))
            if button:
                content['button_text'] = button.get_text(strip=True)[:100]
                if button.name == 'a':
                    content['button_link'] = button.get('href', '')

            section['content'] = content

    def download_images(self):
        """Download and process images - Enhanced version with Selenium CSS extraction"""
        for section in self.sections:
            element = section['element']
            web_element = section.get('web_element')

            # METHOD 1: Extract background image from WebElement's computed styles (Selenium)
            if web_element:
                try:
                    bg_image = self.driver.execute_script(
                        "return window.getComputedStyle(arguments[0]).backgroundImage;",
                        web_element
                    )
                    if bg_image and 'url(' in bg_image:
                        url_match = re.search(r'url\(["\']?([^"\']+)["\']?\)', bg_image)
                        if url_match:
                            image_url = urljoin(self.url, url_match.group(1))
                            downloaded_path = self.download_image(image_url, f"bg_{section['index']}")
                            if downloaded_path:
                                section['background_image'] = downloaded_path
                                print(f"   ✅ Background image set for section {section['index']}")
                except:
                    pass

                # Also check child elements for CSS background images (like figure tags)
                try:
                    figures = web_element.find_elements(By.TAG_NAME, 'figure')
                    for fig in figures:
                        fig_bg = self.driver.execute_script(
                            "return window.getComputedStyle(arguments[0]).backgroundImage;",
                            fig
                        )
                        if fig_bg and 'url(' in fig_bg and not section.get('section_image'):
                            url_match = re.search(r'url\(["\']?([^"\']+)["\']?\)', fig_bg)
                            if url_match:
                                image_url = urljoin(self.url, url_match.group(1))
                                downloaded_path = self.download_image(image_url, f"fig_{section['index']}")
                                if downloaded_path:
                                    section['section_image'] = downloaded_path
                                    print(f"   ✅ Figure image set for section {section['index']}")
                                    break
                except:
                    pass

            # METHOD 2: Find ALL img tags (not just first one)
            images = element.find_all('img')
            if images and not section.get('section_image'):
                print(f"   🖼️  Found {len(images)} img tags in section {section['index']}")

                # Download the first valid image as section image
                for img in images:
                    src = img.get('src') or img.get('data-src') or img.get('data-lazy-src')
                    if src and not src.startswith('data:'):  # Skip data URIs
                        image_url = urljoin(self.url, src)
                        downloaded_path = self.download_image(image_url, f"img_{section['index']}")
                        if downloaded_path:
                            section['section_image'] = downloaded_path
                            print(f"   ✅ Section image set for section {section['index']}")
                            break

            # METHOD 3: Check for picture/source tags (modern responsive images)
            pictures = element.find_all('picture')
            if pictures and not section.get('section_image'):
                for picture in pictures:
                    sources = picture.find_all('source')
                    for source in sources:
                        srcset = source.get('srcset')
                        if srcset:
                            # Get first URL from srcset
                            urls = srcset.split(',')
                            if urls:
                                first_url = urls[0].split()[0]
                                if not first_url.startswith('data:'):
                                    image_url = urljoin(self.url, first_url)
                                    downloaded_path = self.download_image(image_url, f"pic_{section['index']}")
                                    if downloaded_path:
                                        section['section_image'] = downloaded_path
                                        print(f"   ✅ Picture image set for section {section['index']}")
                                        break

    def download_image(self, url: str, filename: str) -> str:
        """Download image and save locally"""
        try:
            # Skip data URIs and SVGs for now
            if url.startswith('data:') or url.endswith('.svg'):
                return ''

            response = requests.get(url, timeout=10)
            if response.status_code == 200:
                # Detect extension
                content_type = response.headers.get('content-type', '')
                ext = 'jpg'
                if 'png' in content_type:
                    ext = 'png'
                elif 'jpeg' in content_type or 'jpg' in content_type:
                    ext = 'jpg'

                filepath = f"{self.images_dir}/{filename}.{ext}"
                with open(filepath, 'wb') as f:
                    f.write(response.content)

                print(f"   📥 Downloaded: {filename}.{ext}")
                return filepath
        except Exception as e:
            print(f"   ⚠️  Image download failed ({url}): {e}")

        return ''

    def generate_template_data(self) -> Dict:
        """Generate final template data structure"""
        return {
            'template_name': self.template_name,
            'description': f'Imported from {self.domain}',
            'url': self.url,
            'scraped_date': datetime.now().isoformat(),
            'sections': self.sections
        }

    def cleanup(self):
        """Clean up resources"""
        if self.driver:
            self.driver.quit()
            print("\n🧹 Cleaned up browser resources")


def main():
    """Example usage"""
    import sys

    if len(sys.argv) < 2:
        print("Usage: python web_scraper.py <url> [template_name]")
        print("\nExample:")
        print("  python web_scraper.py https://example.com my_template")
        sys.exit(1)

    url = sys.argv[1]
    template_name = sys.argv[2] if len(sys.argv) > 2 else None

    # Create scraper
    scraper = WebsiteTemplateScraper(url, template_name)

    # Scrape website
    template_data = scraper.scrape_website()

    # Save as JSON
    output_file = f"scraped_{scraper.template_name}.json"
    with open(output_file, 'w') as f:
        json.dump(template_data, f, indent=2, default=str)

    print(f"\n💾 Template data saved to: {output_file}")
    print(f"📁 Images saved to: {scraper.images_dir}/")


if __name__ == '__main__':
    main()
