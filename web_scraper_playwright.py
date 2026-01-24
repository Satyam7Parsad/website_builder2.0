#!/usr/bin/env python3
"""
Advanced Website Template Scraper - Playwright Implementation
Extracts design from any website with better accuracy

Features:
- Playwright for advanced browser automation
- Better JavaScript execution and waiting
- Improved lazy loading handling
- Network idle detection
- Better interaction capture
"""

import os
import time
import json
import re
import asyncio
from urllib.parse import urljoin, urlparse
from datetime import datetime
from typing import List, Dict, Any, Tuple

# Playwright for advanced browser automation
from playwright.async_api import async_playwright, Page, Browser
from playwright.sync_api import sync_playwright

# Stealth mode for bypassing bot detection
from playwright_stealth import Stealth

# BeautifulSoup for HTML parsing
from bs4 import BeautifulSoup

# Image processing
from PIL import Image
import io
import base64

# Computer vision
import cv2
import numpy as np


class PlaywrightWebsiteScraper:
    """Advanced scraper using Playwright for better accuracy"""

    def __init__(self, url: str, template_name: str = None, timeout_seconds: int = 300):
        self.url = url
        self.domain = urlparse(url).netloc
        self.template_name = template_name or self.domain.replace('.', '_')
        self.timeout_ms = timeout_seconds * 1000  # Convert to milliseconds
        self.sections = []
        self.images_dir = f"scraped_images/{self.template_name}"
        self.responsive_layouts = {}
        self.downloaded_images = {}  # Mapping of image URL to local path
        self.typography_system = {}  # Typography detection results
        self.grid_system = {}  # Grid system detection results
        self.forms = []  # Extracted forms
        self.social_links = []  # Social media links
        self.seo_data = {}  # SEO metadata
        self.custom_fonts = []  # Custom font URLs
        self.advanced_css = {}  # Hover effects, animations, transitions

        # Create images directory
        os.makedirs(self.images_dir, exist_ok=True)

    async def scrape_website_async(self) -> Dict[str, Any]:
        """Main async scraping method with Playwright"""
        print(f"\n🌐 Scraping website: {self.url}")
        print("━" * 60)

        async with async_playwright() as p:
            # Launch browser
            print("\n1️⃣  Launching Chromium browser...")
            browser = await p.chromium.launch(
                headless=True,
                args=[
                    '--no-sandbox',
                    '--disable-dev-shm-usage',
                    '--disable-blink-features=AutomationControlled'
                ]
            )

            # Create context with viewport
            context = await browser.new_context(
                viewport={'width': 1920, 'height': 1080},
                user_agent='Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36'
            )

            page = await context.new_page()

            # Apply stealth mode to bypass bot detection
            print("   🥷 Applying stealth mode...")
            stealth = Stealth()
            await stealth.apply_stealth_async(page)

            try:
                # Step 1: Navigate and wait for page load
                print("\n2️⃣  Loading page and waiting for JavaScript execution...")

                # IMPROVED: Multi-stage loading strategy for JavaScript-heavy sites
                try:
                    # Stage 1: Wait for networkidle (all network requests complete)
                    await page.goto(self.url, wait_until='networkidle', timeout=self.timeout_ms)
                    print("   ✓ Network idle reached")
                except Exception as e:
                    # Fallback: Just wait for load event
                    print(f"   ⚠️  Network idle timeout, using 'load' strategy...")
                    await page.goto(self.url, wait_until='load', timeout=self.timeout_ms)

                # Stage 2: Handle Wix template preview pages (they use iframes)
                if 'wix.com/website-template/view' in self.url:
                    print("   🔄 Wix template preview detected, looking for iframe...")
                    await page.wait_for_timeout(3000)

                    try:
                        # Store reference to iframe if found
                        wix_frame = None

                        # Wix patterns for iframe URLs and elements
                        wix_patterns = [
                            'wixsite.com', 'editorx.io', 'wix.com/site',
                            'wixstatic.com', 'editor.wix.com'
                        ]

                        # Check all iframes on the page
                        frames = page.frames
                        print(f"   📋 Found {len(frames)} frames on page")

                        for frame in frames:
                            frame_url = frame.url
                            if frame_url and frame_url != self.url:
                                # Check if this frame has Wix content
                                for pattern in wix_patterns:
                                    if pattern in frame_url:
                                        print(f"   ✓ Found Wix frame: {frame_url[:80]}...")
                                        wix_frame = frame
                                        break

                                # Also check if frame has substantial content (not just blank)
                                if not wix_frame:
                                    try:
                                        # Check if frame has actual content
                                        frame_content = await frame.evaluate("document.body.innerHTML.length")
                                        if frame_content > 5000:  # Has substantial content
                                            print(f"   ✓ Found content frame ({frame_content} chars): {frame_url[:60]}...")
                                            wix_frame = frame
                                            break
                                    except:
                                        continue
                            if wix_frame:
                                break

                        # If we found a frame with the template content, extract from it
                        if wix_frame:
                            print("   🎯 Using iframe content directly...")
                            # Store frame reference for later use
                            self._wix_frame = wix_frame
                        else:
                            # Look for demo URL in links
                            demo_url = None
                            link_selectors = [
                                'a[href*="wixsite.com"]',
                                'a[href*="editorx.io"]',
                                '[data-testid="view-button"]',
                                'a:has-text("View Live Site")',
                                'a:has-text("View Site")'
                            ]

                            for selector in link_selectors:
                                try:
                                    element = await page.query_selector(selector)
                                    if element:
                                        href = await element.get_attribute('href')
                                        if href:
                                            demo_url = href
                                            print(f"   ✓ Found demo URL: {demo_url[:60]}...")
                                            break
                                except:
                                    continue

                            if demo_url:
                                print("   🔄 Navigating to actual template...")
                                await page.goto(demo_url, wait_until='networkidle', timeout=self.timeout_ms)
                                print("   ✓ Loaded template content")
                            else:
                                print("   ⚠️  Could not find template demo URL, scraping preview page...")

                    except Exception as e:
                        print(f"   ⚠️  Could not access Wix template: {e}")

                # Wait for React/Vue/Angular hydration
                await page.wait_for_timeout(3000)

                # Stage 3: Wait for common content selectors to appear
                print("   ⏳ Waiting for content to render...")
                content_appeared = False
                content_selectors = [
                    'section', 'article', 'main',
                    '[class*="section"]', '[class*="content"]',
                    '[class*="container"]', '[id*="content"]',
                    'div[class]:not([class=""])',  # Any div with classes
                    'p', 'h1', 'h2'  # Text content
                ]

                for selector in content_selectors:
                    try:
                        await page.wait_for_selector(selector, timeout=3000, state='visible')
                        content_appeared = True
                        print(f"   ✓ Content detected: {selector}")
                        break
                    except:
                        continue

                if not content_appeared:
                    print("   ⚠️  No standard content selectors found, proceeding anyway...")

                # Stage 4: Extra wait for JavaScript frameworks to finish rendering
                print("   ⏳ Waiting for JavaScript frameworks...")
                await page.evaluate("""
                    () => {
                        return new Promise((resolve) => {
                            // Wait for React
                            if (window.React || document.querySelector('[data-reactroot]') ||
                                document.querySelector('[data-react-helmet]')) {
                                console.log('React app detected');
                            }

                            // Wait for Vue
                            if (window.Vue || document.querySelector('[data-v-]')) {
                                console.log('Vue app detected');
                            }

                            // Wait for Angular
                            if (window.angular || document.querySelector('[ng-version]')) {
                                console.log('Angular app detected');
                            }

                            // Wait for requestAnimationFrame (animations complete)
                            requestAnimationFrame(() => {
                                requestAnimationFrame(() => {
                                    setTimeout(resolve, 2000);
                                });
                            });
                        });
                    }
                """)

                print("   ✓ JavaScript execution complete")

                # Stage 5: Additional wait for lazy-loaded content
                await page.wait_for_timeout(3000)

                # Step 2: Remove overlays and popups
                print("\n3️⃣  Removing popups and overlays...")
                await self.remove_overlays(page)
                await page.wait_for_timeout(2000)

                # Step 3: Scroll to trigger lazy loading
                print("\n4️⃣  Scrolling to load lazy content...")
                await self.scroll_for_lazy_load(page)
                await page.wait_for_timeout(5000)  # Wait longer for images to load

                # Step 4: Capture responsive layouts
                print("\n5️⃣  Capturing responsive layouts...")
                await self.capture_responsive_layouts(page, context)

                # Step 5: Take full-page screenshot
                print("\n6️⃣  Capturing full-page screenshot...")
                screenshot_path = await self.take_full_screenshot(page)

                # Step 6: Computer Vision Analysis
                print("\n7️⃣  Computer Vision Analysis...")
                cv_data = self.analyze_screenshot_with_cv(screenshot_path)

                # Step 7: Get page HTML
                print("\n8️⃣  Extracting HTML content...")

                # Check if we have a Wix frame with content - use that instead
                if hasattr(self, '_wix_frame') and self._wix_frame:
                    print("   🎯 Extracting from Wix iframe...")
                    try:
                        html = await self._wix_frame.content()
                        print(f"   ✓ Got {len(html)} chars from iframe")
                        # Also take a screenshot of the iframe content
                        frame_element = await page.query_selector('iframe')
                        if frame_element:
                            try:
                                await frame_element.screenshot(path=screenshot_path)
                                print(f"   📸 Screenshot updated from iframe")
                            except:
                                pass
                    except Exception as e:
                        print(f"   ⚠️  Failed to get iframe content: {e}, using main page")
                        html = await page.content()
                else:
                    html = await page.content()

                soup = BeautifulSoup(html, 'html.parser')

                # Use the Wix frame if available, otherwise use the main page
                working_context = self._wix_frame if hasattr(self, '_wix_frame') and self._wix_frame else page

                # Step 8: Detect sections (DOM + CV)
                print("\n9️⃣  Detecting sections with DOM + Computer Vision...")
                await self.detect_sections(working_context, soup, screenshot_path)

                # Step 9: Extract styles for each section
                print("\n🔟  Extracting computed styles + layout...")
                await self.extract_section_styles(working_context)

                # Step 10: Extract content
                print("\n1️⃣1️⃣  Extracting content...")
                await self.extract_content(working_context, soup)

                # Step 10b: Extract navigation and galleries
                print("\n1️⃣1️⃣b Extracting navigation items and gallery images...")
                await self.extract_navigation_and_galleries(working_context)

                # Step 10c: Extract hero animation images
                print("\n1️⃣1️⃣c Extracting hero animation images...")
                await self.extract_hero_animation_images(working_context)

                # Step 11: Detect Typography
                print("\n1️⃣2️⃣  Design Analysis: Typography Detection...")
                await self.detect_typography(working_context)

                # Step 12: Detect Grid System
                print("\n1️⃣3️⃣  Design Analysis: Grid & Spacing Detection...")
                await self.detect_grid_system(working_context)

                # Step 13: Refine section types and apply extracted data
                print("\n1️⃣4️⃣  Refining Section Types & Applying Colors...")
                await self.refine_section_types_and_apply_data()

                # Step 14: Enhance sections with Computer Vision data
                print("\n1️⃣5️⃣  Enhancing sections with Computer Vision...")
                self.enhance_sections_with_cv(cv_data)

                # Step 15: Standardize Component Sizes
                print("\n1️⃣6️⃣  Design Analysis: Component Standardization...")
                await self.standardize_component_sizes()

                # Step 16: Extract additional metadata (footer, forms, social, SEO)
                print("\n1️⃣7️⃣  Extracting Footer, Forms, Social Links & SEO...")
                await self.extract_footer_and_metadata(working_context)

                # Step 17: Download images
                print("\n1️⃣8️⃣  Downloading images...")
                await self.download_images(page, working_context)

                # Step 18: Download fonts
                print("\n1️⃣9️⃣  Downloading custom fonts...")
                await self.download_fonts(working_context)

                # Step 19: Extract advanced CSS
                print("\n2️⃣0️⃣  Extracting advanced CSS (hover, animations)...")
                await self.extract_advanced_css(working_context)

                # Step 20: Associate images with sections
                print("\n1️⃣8️⃣  Associating images with sections...")
                await self.associate_images_with_sections(working_context)

                # Step 18b: Split Wix sections into more granular sections
                if hasattr(self, '_wix_frame') and self._wix_frame:
                    print("\n1️⃣8️⃣b  Splitting Wix content into sections...")
                    self.split_wix_sections()

                # Step 18: Generate template data
                print("\n1️⃣9️⃣  Generating template data...")
                template_data = self.generate_template_data()

                print("\n✅ Scraping completed successfully!")
                print(f"📊 Found {len(self.sections)} sections")

                return template_data

            except Exception as e:
                print(f"\n❌ Error during scraping: {e}")
                import traceback
                traceback.print_exc()
                raise
            finally:
                await browser.close()

    def scrape_website(self) -> Dict[str, Any]:
        """Synchronous wrapper for async scraping"""
        return asyncio.run(self.scrape_website_async())

    async def remove_overlays(self, page: Page):
        """Remove popups, cookie banners, modals"""
        await page.evaluate("""
            () => {
                // Remove common overlay elements
                const selectors = [
                    '[class*="cookie"]', '[class*="popup"]', '[class*="modal"]',
                    '[class*="overlay"]', '[id*="cookie"]', '[id*="popup"]',
                    '[role="dialog"]', '.modal', '.popup', '[class*="banner"]'
                ];

                selectors.forEach(selector => {
                    document.querySelectorAll(selector).forEach(el => {
                        // Check if it's actually an overlay (high z-index)
                        const style = window.getComputedStyle(el);
                        if (parseInt(style.zIndex) > 100 ||
                            style.position === 'fixed' ||
                            style.position === 'absolute') {
                            el.remove();
                        }
                    });
                });

                // Remove backdrop overlays
                document.querySelectorAll('.backdrop, .overlay-backdrop, [class*="backdrop"]').forEach(el => el.remove());
            }
        """)

    async def scroll_for_lazy_load(self, page: Page):
        """Scroll page multiple times (2-3 passes) to trigger lazy-loaded images and content"""
        await page.evaluate("""
            async () => {
                const distance = 100;
                const delay = 100;

                // PASS 1: Scroll down
                console.log('Scroll Pass 1: Scrolling down...');
                let totalHeight = document.body.scrollHeight;
                for (let scrolled = 0; scrolled < totalHeight; scrolled += distance) {
                    window.scrollTo(0, scrolled);
                    await new Promise(resolve => setTimeout(resolve, delay));
                }

                // Wait for new content to load
                await new Promise(resolve => setTimeout(resolve, 2000));

                // PASS 2: Scroll down again (page height may have increased)
                console.log('Scroll Pass 2: Scrolling down again...');
                totalHeight = document.body.scrollHeight;
                for (let scrolled = 0; scrolled < totalHeight; scrolled += distance) {
                    window.scrollTo(0, scrolled);
                    await new Promise(resolve => setTimeout(resolve, delay));
                }

                // Wait for more content
                await new Promise(resolve => setTimeout(resolve, 2000));

                // PASS 3: Final scroll (catch any remaining lazy content)
                console.log('Scroll Pass 3: Final pass...');
                totalHeight = document.body.scrollHeight;
                for (let scrolled = 0; scrolled < totalHeight; scrolled += distance) {
                    window.scrollTo(0, scrolled);
                    await new Promise(resolve => setTimeout(resolve, delay));
                }

                // Scroll back to top
                window.scrollTo(0, 0);

                // Force load all lazy images
                document.querySelectorAll('img[loading="lazy"]').forEach(img => {
                    img.loading = 'eager';
                    // Trigger load
                    img.src = img.src;
                });

                // Trigger intersection observers
                document.querySelectorAll('[data-src], [data-lazy]').forEach(el => {
                    if (el.dataset.src) el.src = el.dataset.src;
                    if (el.dataset.lazy) el.src = el.dataset.lazy;
                });
            }
        """)

    async def capture_responsive_layouts(self, page: Page, context):
        """Capture layouts at different viewport sizes"""
        breakpoints = {
            'mobile': {'width': 375, 'height': 812},
            'tablet': {'width': 768, 'height': 1024},
            'desktop': {'width': 1920, 'height': 1080}
        }

        for name, viewport in breakpoints.items():
            await page.set_viewport_size(viewport)
            await page.wait_for_timeout(3000)  # Increased to 3 seconds per viewport

            # Capture layout info
            layout_info = await page.evaluate("""
                () => {
                    return {
                        width: window.innerWidth,
                        height: window.innerHeight,
                        sections: Array.from(document.querySelectorAll('section, [class*="section"]')).map(el => ({
                            visible: el.offsetHeight > 0,
                            display: window.getComputedStyle(el).display
                        }))
                    };
                }
            """)

            self.responsive_layouts[name] = layout_info
            print(f"   ✓ Captured {name} layout: {viewport['width']}×{viewport['height']}")

        # Reset to desktop
        await page.set_viewport_size({'width': 1920, 'height': 1080})

    async def take_full_screenshot(self, page: Page) -> str:
        """Take full-page screenshot"""
        screenshot_path = f"{self.images_dir}/fullpage_screenshot.png"
        await page.screenshot(path=screenshot_path, full_page=True)
        print(f"   📸 Screenshot saved: {screenshot_path}")
        return screenshot_path

    async def detect_sections(self, page: Page, soup: BeautifulSoup, screenshot_path: str):
        """Detect sections using VISUAL LAYOUT ANALYSIS - Complete Rewrite"""
        print("\n   🔍 Analyzing page structure with visual layout detection...")

        # Check if this is a Wix site
        is_wix = 'wix' in self.url.lower() or hasattr(self, '_wix_frame')

        # NEW APPROACH: Divide page into visual sections based on layout breaks
        elements_data = await page.evaluate("""
            (isWix) => {
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

                // Look for ANY large container (not just semantic tags)
                let containerSelectors = [
                    'body > *',  // Direct children of body
                    'main > *',  // Direct children of main
                    '[class*="section"]', '[id*="section"]',
                    '[class*="container"]', '[class*="wrapper"]',
                    '[class*="block"]', '[class*="panel"]',
                    'section', 'article', 'header', 'footer', 'nav',
                    '[class*="hero"]', '[class*="banner"]',
                    '[class*="content"]', '[class*="area"]',
                    '[role="main"]', '[role="region"]', '[role="contentinfo"]'
                ];

                // Wix-specific selectors for better section detection
                if (isWix) {
                    containerSelectors = containerSelectors.concat([
                        '[data-mesh-id]',  // Wix mesh containers
                        '[id*="comp-"]',   // Wix components
                        '[class*="StylableButton"]',
                        '[class*="WRichText"]',
                        '[class*="wixui-"]',
                        '[data-hook]',
                        '[class*="gallery"]',
                        '[class*="strip"]',
                        '[class*="column"]',
                        '[class*="repeater"]'
                    ]);
                }

                containerSelectors.forEach(selector => {
                    try {
                        document.querySelectorAll(selector).forEach(el => {
                            const rect = el.getBoundingClientRect();
                            const style = window.getComputedStyle(el);

                            // Skip if hidden, tiny, or inline
                            if (style.display === 'none' ||
                                style.visibility === 'hidden' ||
                                rect.height < 50 ||
                                rect.width < viewportWidth * 0.3 ||
                                style.display === 'inline') {
                                return;
                            }

                            // Check if this element contains significant content
                            const hasText = el.textContent.trim().length > 20;
                            const hasImages = el.querySelectorAll('img').length > 0;
                            const hasButtons = el.querySelectorAll('button, a.btn, .button').length > 0;

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
                    } catch (e) {
                        // Skip invalid selectors
                    }
                });

                // STEP 2: Filter out nested containers (keep only parents)
                const parentContainers = [];
                allContainers.forEach(candidate => {
                    let isNested = false;

                    allContainers.forEach(other => {
                        if (other.element !== candidate.element &&
                            other.element.contains(candidate.element)) {
                            // If parent is significantly larger, candidate is nested
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

                // STEP 3: Group containers that are close together (same section)
                parentContainers.sort((a, b) => a.y - b.y);

                const groupedSections = [];
                let currentGroup = null;
                // For Wix sites, use smaller threshold to capture individual content blocks
                const groupingThreshold = isWix ? 30 : 100;

                parentContainers.forEach(container => {
                    if (!currentGroup) {
                        currentGroup = {
                            start: container.y,
                            end: container.y + container.height,
                            containers: [container]
                        };
                    } else {
                        // Check if this container is close to current group
                        const gap = container.y - currentGroup.end;

                        if (gap < groupingThreshold) {
                            // Add to current group
                            currentGroup.containers.push(container);
                            currentGroup.end = Math.max(currentGroup.end, container.y + container.height);
                        } else {
                            // Start new group
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

                // STEP 4: Convert groups to section data
                groupedSections.forEach((group, idx) => {
                    // Find the most representative container (largest full-width one)
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

                    sections.push({
                        tag: el.tagName.toLowerCase(),
                        classes: Array.from(el.classList),
                        id: el.id || '',
                        x: Math.round(rect.left),
                        y: Math.round(group.start),
                        width: Math.round(representative.width),
                        height: Math.round(group.end - group.start),
                        html: el.outerHTML.substring(0, 500),
                        hasBackground: style.backgroundColor !== 'rgba(0, 0, 0, 0)',
                        backgroundColor: style.backgroundColor,
                        zIndex: parseInt(style.zIndex) || 0,
                        isFullWidth: representative.width > viewportWidth * 0.8,
                        groupSize: group.containers.length
                    });
                });

                return sections;
            }
        """, is_wix)

        print(f"   📦 Found {len(elements_data)} potential sections")

        # Convert to section objects with deduplication
        temp_sections = []
        for idx, elem_data in enumerate(elements_data):
            # Detect section type
            section_type = self.detect_section_type_from_data(elem_data)

            section_data = {
                'index': idx,
                'type': section_type,
                'y_position': elem_data['y'],
                'height': elem_data['height'],
                'width': elem_data['width'],
                'html_tag': elem_data['tag'],
                'classes': elem_data['classes'],
                'id': elem_data['id']
            }

            temp_sections.append(section_data)

        # Deduplicate overlapping sections
        print(f"   🔄 Deduplicating overlapping sections...")
        deduplicated = self.deduplicate_sections(temp_sections)
        print(f"   ✅ Kept {len(deduplicated)} unique sections (removed {len(temp_sections) - len(deduplicated)} duplicates)")

        # Add deduplicated sections and handle navbar
        for section_data in deduplicated:
            # IMPORTANT: Only allow ONE navbar
            if section_data['type'] == 1:
                has_navbar = any(s['type'] == 1 for s in self.sections)
                if has_navbar:
                    print(f"   ⚠️  Skipping duplicate navbar at position {section_data['y_position']}")
                    section_data['type'] = 3  # Convert to services section
                else:
                    print(f"   ✅ Found navbar at position {section_data['y_position']}")

            self.sections.append(section_data)

        # IMPROVED: If too few sections found, try visual break detection
        if len(self.sections) < 3:
            print(f"   ⚠️  Only {len(self.sections)} sections found, trying visual break detection...")
            await self.detect_sections_by_visual_breaks(page)

        print(f"   ✅ Final section count: {len(self.sections)} sections")

    async def detect_sections_by_visual_breaks(self, page: Page):
        """IMPROVED: Detect sections by finding visual breaks (background color changes, large gaps)"""
        # Get all full-width elements with their background colors
        visual_data = await page.evaluate("""
            () => {
                const viewportWidth = window.innerWidth;
                const pageHeight = Math.max(
                    document.body.scrollHeight,
                    document.documentElement.scrollHeight
                );

                // Sample every 100px vertically
                const samples = [];
                for (let y = 0; y < pageHeight; y += 100) {
                    const el = document.elementFromPoint(viewportWidth / 2, Math.min(y, window.innerHeight - 1));
                    if (!el) continue;

                    const style = window.getComputedStyle(el);
                    const bgColor = style.backgroundColor;
                    const bgImage = style.backgroundImage;

                    // Walk up to find the section-level parent
                    let parent = el;
                    while (parent && parent !== document.body) {
                        const parentRect = parent.getBoundingClientRect();
                        if (parentRect.width >= viewportWidth * 0.8) {
                            break;  // Found full-width parent
                        }
                        parent = parent.parentElement;
                    }

                    if (parent && parent !== document.body) {
                        const parentStyle = window.getComputedStyle(parent);
                        const parentRect = parent.getBoundingClientRect();
                        samples.push({
                            y: y,
                            element: parent.tagName,
                            classes: Array.from(parent.classList),
                            bgColor: parentStyle.backgroundColor || bgColor,
                            bgImage: parentStyle.backgroundImage || bgImage,
                            height: parentRect.height,
                            width: parentRect.width
                        });
                    }
                }

                // Find color change points
                const breakPoints = [];
                let lastBg = null;
                let lastY = 0;

                for (const sample of samples) {
                    const currentBg = sample.bgColor;
                    if (lastBg !== null && currentBg !== lastBg) {
                        // Color changed - this is a section break
                        breakPoints.push({
                            y: sample.y,
                            bgColor: currentBg,
                            prevBgColor: lastBg,
                            element: sample.element,
                            classes: sample.classes,
                            height: 0  // Will calculate later
                        });
                    }
                    lastBg = currentBg;
                    lastY = sample.y;
                }

                // Calculate heights between breaks
                for (let i = 0; i < breakPoints.length; i++) {
                    if (i < breakPoints.length - 1) {
                        breakPoints[i].height = breakPoints[i + 1].y - breakPoints[i].y;
                    } else {
                        breakPoints[i].height = pageHeight - breakPoints[i].y;
                    }
                }

                return {
                    pageHeight: pageHeight,
                    breakPoints: breakPoints
                };
            }
        """)

        break_points = visual_data.get('breakPoints', [])
        if len(break_points) < 2:
            print(f"   ⚠️  No visual breaks detected")
            return

        print(f"   🔍 Found {len(break_points)} visual break points")

        # Create sections from break points
        existing_types = [s['type'] for s in self.sections]
        for idx, bp in enumerate(break_points):
            # Skip if height is too small (likely a separator)
            if bp['height'] < 150:
                continue

            # Determine section type based on position and characteristics
            if idx == 0 and bp['height'] > 400:
                section_type = 0  # Hero
            elif idx == len(break_points) - 1:
                section_type = 10  # Footer
            elif bp['height'] < 300 and idx < 2:
                section_type = 1 if 1 not in existing_types else 8  # Navbar or CTA
            else:
                section_type = 3  # Services

            # Only add if not overlapping with existing sections
            overlaps = False
            for s in self.sections:
                s_start = s['y_position']
                s_end = s_start + s['height']
                bp_start = bp['y']
                bp_end = bp_start + bp['height']

                overlap = max(0, min(s_end, bp_end) - max(s_start, bp_start))
                if overlap > min(s['height'], bp['height']) * 0.5:
                    overlaps = True
                    break

            if not overlaps:
                new_section = {
                    'index': len(self.sections),
                    'type': section_type,
                    'y_position': bp['y'],
                    'height': bp['height'],
                    'width': 1920,
                    'html_tag': bp['element'].lower(),
                    'classes': bp['classes'],
                    'id': '',
                    'bg_color': bp['bgColor']
                }
                self.sections.append(new_section)
                print(f"      → Added visual section at y={bp['y']}, height={bp['height']}, type={section_type}")
                existing_types.append(section_type)

        # Re-sort sections by y position
        self.sections.sort(key=lambda s: s['y_position'])

        # Re-index
        for idx, section in enumerate(self.sections):
            section['index'] = idx

    def detect_section_type_from_data(self, elem_data: Dict) -> int:
        """Detect section type from element data and content analysis"""
        classes = ' '.join(elem_data['classes']).lower()
        elem_id = elem_data['id'].lower()
        tag = elem_data['tag']
        y_pos = elem_data.get('y', 0)
        height = elem_data.get('height', 0)

        # Navigation (type 1) - PRIORITY CHECK FIRST
        # Expanded detection: top section, reasonable height, or has nav keywords
        is_nav_tag = tag == 'nav'
        has_nav_keywords = 'nav' in classes or 'nav' in elem_id or 'menu' in classes or 'header' in classes
        is_sticky = 'sticky' in classes or 'fixed' in classes

        # More lenient position and height checks
        is_top_position = y_pos < 300  # Increased from 150 to 300 to catch navbars below banners
        is_navbar_height = 40 < height < 200  # Navbars are typically 40-200px tall

        # Navbar if: nav tag OR (top position AND navbar height) OR (nav keywords AND reasonable height)
        if is_nav_tag or (is_top_position and is_navbar_height) or (has_nav_keywords and height < 200) or is_sticky:
            elem_data['_likely_navbar'] = True
            return 1

        # Hero section (type 0) - large sections at top with big images
        # Expanded detection for various hero patterns
        has_hero_keywords = 'hero' in classes or 'hero' in elem_id or 'banner' in classes or 'jumbotron' in classes
        is_large_top_section = y_pos < 500 and height > 500  # Large section near top

        if has_hero_keywords and height > 300:
            return 0
        if is_large_top_section:
            return 0

        # Header (could be hero) - first large section
        if tag == 'header' and height > 400:
            return 0

        # Footer (type 10)
        if tag == 'footer' or 'footer' in classes or 'footer' in elem_id:
            return 10

        # Gallery (type 4) - multiple images
        if 'gallery' in classes or 'gallery' in elem_id or 'carousel' in classes or 'slider' in classes:
            return 4

        # Team section (type 5)
        if 'team' in classes or 'team' in elem_id or 'people' in classes or 'staff' in classes:
            return 5

        # Testimonials (type 7)
        if 'testimonial' in classes or 'testimonial' in elem_id or 'review' in classes or 'quote' in classes:
            return 7

        # Pricing (type 6)
        if 'pricing' in classes or 'pricing' in elem_id or 'price' in classes or 'plan' in classes:
            return 6

        # Services/Cards - detect grid patterns (type 3)
        if 'grid' in classes or 'cards' in classes or 'services' in classes or 'features' in classes or 'benefits' in classes:
            return 3

        # CTA section (type 8) - call to action
        if 'cta' in classes or 'call-to-action' in classes or 'action' in elem_id:
            return 8

        # Contact section (type 9)
        if 'contact' in classes or 'contact' in elem_id or 'form' in classes and elem_data['height'] > 300:
            return 9

        # About section (type 2)
        if 'about' in classes or 'about' in elem_id or 'intro' in classes or 'story' in classes:
            return 2

        # Default: generic content section (type 2)
        return 2

    def improve_section_type_with_content(self, section: Dict) -> int:
        """Further refine section type based on extracted content"""
        content = section.get('content', {})
        buttons = content.get('buttons', [])
        headings = content.get('headings', [])
        paragraphs = content.get('paragraphs', [])

        current_type = section.get('type', 2)
        y_pos = section.get('y_position', 0)
        height = section.get('height', 0)

        # PRIORITY 1: Navbar detection with content
        # If already marked as navbar OR has navbar characteristics
        if current_type == 1 or section.get('_likely_navbar', False):
            # Confirm it's a navbar if it has navigation-like buttons
            if len(buttons) >= 3 and height < 200 and y_pos < 300:
                # Multiple links in a short top section = navbar
                return 1

        # Check if misclassified CTA is actually a navbar
        # Navbar: top position, short height, many small text links
        if current_type == 8 and y_pos < 300 and height < 200 and len(buttons) >= 4:
            # Many buttons at top = likely navbar, not CTA
            # Check if buttons have short text (navigation links vs action buttons)
            avg_button_text_length = sum(len(b.get('text', '')) for b in buttons) / max(len(buttons), 1)
            if avg_button_text_length < 20:  # Short text = navigation links
                return 1  # Change to navbar

        # PRIORITY 2: Hero section detection
        # If section has large heading and big image at top, it's a hero
        if current_type != 1 and y_pos < 200 and height > 500:
            if len(headings) > 0 and headings[0].get('fontSize', 0) > 40:
                return 0  # Hero

        # Large section at top with minimal content = hero
        if y_pos < 100 and height > 600 and len(paragraphs) < 3:
            return 0  # Hero

        # PRIORITY 3: CTA vs other sections
        # If section has multiple buttons but is NOT at top, it's likely a CTA
        if current_type != 1 and len(buttons) >= 2 and height < 400 and y_pos > 300:
            return 8  # CTA

        # PRIORITY 4: Cards/Services sections
        # If section has many similar small cards with images, it's cards/services
        if section.get('has_grid', False) or len(buttons) > 5:
            return 3  # Services/Cards

        return current_type

    def deduplicate_sections(self, sections: List[Dict]) -> List[Dict]:
        """Remove overlapping and duplicate sections - IMPROVED ALGORITHM"""
        if not sections:
            return []

        # Already sorted by y_position from JavaScript
        deduplicated = []

        for current in sections:
            is_duplicate = False
            should_replace = None

            # Check if this section overlaps with any already accepted section
            for existing in deduplicated:
                # Calculate actual overlap (not just Y position difference)
                current_start = current['y_position']
                current_end = current['y_position'] + current['height']
                existing_start = existing['y_position']
                existing_end = existing['y_position'] + existing['height']

                # Check for overlap
                overlap_start = max(current_start, existing_start)
                overlap_end = min(current_end, existing_end)
                overlap_height = max(0, overlap_end - overlap_start)

                # Calculate overlap percentage for both sections
                current_overlap_pct = (overlap_height / current['height']) * 100 if current['height'] > 0 else 0
                existing_overlap_pct = (overlap_height / existing['height']) * 100 if existing['height'] > 0 else 0

                # If significant overlap (>60%), they're duplicates
                if current_overlap_pct > 60 or existing_overlap_pct > 60:
                    current_type = current['type']
                    existing_type = existing['type']

                    # PRIORITY SYSTEM:
                    # 1. Always prefer nav (type 1), hero (type 0), footer (type 10)
                    if current_type in [0, 1, 10] and existing_type not in [0, 1, 10]:
                        should_replace = existing
                        print(f"      → Replacing generic section at y={existing['y_position']} with {current['html_tag']} (type {current_type})")
                        break
                    elif existing_type in [0, 1, 10] and current_type not in [0, 1, 10]:
                        print(f"      → Skipping {current['html_tag']} at y={current['y_position']} (duplicate of special section)")
                        is_duplicate = True
                        break

                    # 2. Keep the one that's full-width
                    current_full_width = current.get('width', 0) > 1000
                    existing_full_width = existing.get('width', 0) > 1000

                    if current_full_width and not existing_full_width:
                        should_replace = existing
                        print(f"      → Replacing narrow section with full-width section at y={current['y_position']}")
                        break
                    elif existing_full_width and not current_full_width:
                        print(f"      → Skipping narrow section (keeping full-width)")
                        is_duplicate = True
                        break

                    # 3. Keep the larger section (parent container)
                    if current['height'] > existing['height'] * 1.2:  # Current is 20% larger
                        should_replace = existing
                        print(f"      → Replacing smaller ({existing['height']}px) with larger ({current['height']}px)")
                        break
                    else:
                        print(f"      → Skipping duplicate at y={current['y_position']}")
                        is_duplicate = True
                        break

            # Replace if needed
            if should_replace:
                deduplicated.remove(should_replace)
                deduplicated.append(current)
            elif not is_duplicate:
                deduplicated.append(current)

        # Sort by y_position to maintain order
        deduplicated.sort(key=lambda s: s['y_position'])

        # Fix any remaining overlaps by adjusting heights
        for i in range(len(deduplicated) - 1):
            current = deduplicated[i]
            next_section = deduplicated[i + 1]

            current_end = current['y_position'] + current['height']
            next_start = next_section['y_position']

            # If current section extends into next section
            if current_end > next_start:
                # Trim current section to end just before next section
                new_height = next_start - current['y_position'] - 10  # 10px gap
                if new_height > 100:  # Keep minimum height
                    print(f"      → Trimming section at y={current['y_position']} from {current['height']}px to {new_height}px")
                    current['height'] = new_height

        # Re-index the deduplicated sections
        for idx, section in enumerate(deduplicated):
            section['index'] = idx

        return deduplicated

    async def extract_section_styles(self, page: Page):
        """Extract computed styles for each section using Playwright"""
        for section in self.sections:
            # Get styles using page.evaluate
            styles = await page.evaluate("""
                (yPos) => {
                    const elements = document.elementsFromPoint(window.innerWidth / 2, yPos + 100);
                    const section = elements.find(el =>
                        el.tagName === 'SECTION' ||
                        (typeof el.className === 'string' && el.className.includes('section')) ||
                        el.offsetHeight > 50
                    );

                    if (!section) return {};

                    const style = window.getComputedStyle(section);

                    return {
                        backgroundColor: style.backgroundColor,
                        backgroundImage: style.backgroundImage,
                        color: style.color,
                        padding: style.padding,
                        display: style.display,
                        flexDirection: style.flexDirection,
                        justifyContent: style.justifyContent,
                        alignItems: style.alignItems,
                        gap: style.gap,
                        gridTemplateColumns: style.gridTemplateColumns,
                        gridTemplateRows: style.gridTemplateRows,
                        position: style.position,
                        top: style.top,
                        left: style.left,
                        right: style.right,
                        bottom: style.bottom,
                        zIndex: style.zIndex,
                        fontFamily: style.fontFamily,
                        backgroundPosition: style.backgroundPosition,
                        backgroundSize: style.backgroundSize,
                        backgroundRepeat: style.backgroundRepeat
                    };
                }
            """, section['y_position'])

            section['styles'] = styles

    async def extract_content(self, page: Page, soup: BeautifulSoup):
        """Extract ALL content from sections with colors, typography, and buttons"""
        print("\n   📝 Extracting content with colors and styling...")

        for idx, section in enumerate(self.sections):
            # Extract comprehensive content for this section
            content_data = await page.evaluate("""
                (args) => {
                    const sectionTop = args.yPos;
                    const sectionBottom = args.yPos + args.height;

                    // Find all elements in this section
                    const allElements = document.querySelectorAll('*');
                    const sectionElements = Array.from(allElements).filter(el => {
                        const rect = el.getBoundingClientRect();
                        const elTop = rect.top + window.scrollY;
                        return elTop >= sectionTop && elTop < sectionBottom;
                    });

                    // IMPROVED: Extract headings with styling - include styled divs/spans
                    const headings = [];
                    const seenHeadingTexts = new Set();
                    sectionElements.forEach(el => {
                        let isHeading = ['H1', 'H2', 'H3', 'H4', 'H5', 'H6'].includes(el.tagName);

                        // Also check for styled elements that look like headings
                        if (!isHeading) {
                            const style = window.getComputedStyle(el);
                            const fontSize = parseFloat(style.fontSize);
                            const fontWeight = parseInt(style.fontWeight);
                            // Large text (>24px) or bold text (>500 weight) could be a heading
                            if ((fontSize > 24 || fontWeight >= 600) && el.textContent.trim().length > 0 && el.textContent.trim().length < 200) {
                                // Check if it's a block element or styled like a heading
                                if (style.display === 'block' || el.className.includes('title') || el.className.includes('heading')) {
                                    isHeading = true;
                                }
                            }
                        }

                        if (isHeading) {
                            const text = el.textContent.trim();
                            // Skip duplicates
                            if (seenHeadingTexts.has(text) || text.length === 0) return;
                            seenHeadingTexts.add(text);

                            const style = window.getComputedStyle(el);
                            headings.push({
                                text: text,
                                tag: el.tagName.toLowerCase(),
                                fontSize: parseFloat(style.fontSize),
                                fontWeight: parseInt(style.fontWeight),
                                color: style.color,
                                fontFamily: style.fontFamily
                            });
                        }
                    });

                    // Sort headings by font size (largest first) to get proper hierarchy
                    headings.sort((a, b) => b.fontSize - a.fontSize);

                    // IMPROVED: Extract paragraphs and text content
                    const paragraphs = [];
                    const seenParaTexts = new Set();
                    sectionElements.forEach(el => {
                        // Include P, DIV with text content, and spans with substantial text
                        let isTextBlock = el.tagName === 'P';
                        const text = el.textContent.trim();

                        // Check for div/span with text content
                        if (!isTextBlock && (el.tagName === 'DIV' || el.tagName === 'SPAN')) {
                            const style = window.getComputedStyle(el);
                            const fontSize = parseFloat(style.fontSize);
                            // Text blocks typically have readable font size (12-24px)
                            if (fontSize >= 12 && fontSize <= 24 && text.length > 20 && text.length < 1000) {
                                // Check it's not a container with many children
                                const childCount = el.children.length;
                                if (childCount <= 2) {
                                    isTextBlock = true;
                                }
                            }
                        }

                        // Also check for Wix-specific text elements
                        if (el.className && (el.className.includes('WRichText') || el.className.includes('font_'))) {
                            isTextBlock = true;
                        }

                        if (isTextBlock && text.length > 0) {
                            // Skip duplicates and heading-like text
                            if (seenParaTexts.has(text) || seenHeadingTexts.has(text)) return;
                            seenParaTexts.add(text);

                            const style = window.getComputedStyle(el);
                            paragraphs.push({
                                text: text,
                                fontSize: parseFloat(style.fontSize),
                                fontWeight: parseInt(style.fontWeight),
                                color: style.color,
                                fontFamily: style.fontFamily
                            });
                        }
                    });

                    // IMPROVED: Extract buttons with better color detection
                    const buttons = [];
                    sectionElements.forEach(el => {
                        // Check if this is a button or button-like element
                        const isButton = el.tagName === 'BUTTON';
                        const isLink = el.tagName === 'A' && el.textContent.trim().length > 0 && el.textContent.trim().length < 50;
                        const hasButtonClass = el.className && (
                            el.className.includes('btn') ||
                            el.className.includes('button') ||
                            el.className.includes('cta') ||
                            el.className.includes('action')
                        );

                        if (isButton || isLink || hasButtonClass) {
                            const style = window.getComputedStyle(el);
                            const rect = el.getBoundingClientRect();

                            // Skip if too small or invisible
                            if (rect.width < 20 || rect.height < 10) return;
                            if (style.display === 'none' || style.visibility === 'hidden') return;

                            // IMPROVED: Get actual button background color
                            let btnBgColor = style.backgroundColor;
                            if (isTransparent(btnBgColor)) {
                                // Check for gradient
                                if (style.backgroundImage && style.backgroundImage.includes('gradient')) {
                                    // Extract first color from gradient
                                    const gradientMatch = style.backgroundImage.match(/rgba?\\([^)]+\\)/);
                                    if (gradientMatch) btnBgColor = gradientMatch[0];
                                }
                                // If still transparent, this might be a text link, not a button
                                if (isTransparent(btnBgColor) && !hasButtonClass) {
                                    // Use accent color or default
                                    btnBgColor = style.borderColor || 'rgb(79, 172, 159)';
                                }
                            }

                            // Classify button type based on styling and context
                            let buttonType = 'link';  // Default
                            const hasVisibleBg = !isTransparent(btnBgColor) && btnBgColor !== 'rgb(255, 255, 255)';
                            const hasBorder = style.borderWidth && parseFloat(style.borderWidth) > 0;
                            const hasShadow = style.boxShadow && style.boxShadow !== 'none';
                            const hasRoundedCorners = parseFloat(style.borderRadius) > 4;
                            const hasPadding = parseFloat(style.paddingLeft) > 10 || parseFloat(style.paddingRight) > 10;

                            if (hasVisibleBg || (hasBorder && hasPadding) || hasShadow || hasRoundedCorners) {
                                buttonType = 'cta';  // Styled button - call to action
                            } else if (el.textContent.trim().length < 20) {
                                buttonType = 'nav';  // Short text link - likely navigation
                            }

                            // Extract onclick action
                            let onclickAction = el.getAttribute('onclick') || '';
                            let actionType = 'none';

                            // Determine action type
                            if (el.href && el.href.startsWith('http')) {
                                actionType = 'link';
                            } else if (el.href && el.href.startsWith('#')) {
                                actionType = 'scroll';
                            } else if (el.href && el.href.startsWith('mailto:')) {
                                actionType = 'email';
                            } else if (el.href && el.href.startsWith('tel:')) {
                                actionType = 'phone';
                            } else if (onclickAction) {
                                if (onclickAction.includes('submit') || onclickAction.includes('form')) {
                                    actionType = 'submit';
                                } else if (onclickAction.includes('popup') || onclickAction.includes('modal') || onclickAction.includes('open')) {
                                    actionType = 'popup';
                                } else {
                                    actionType = 'script';
                                }
                            } else if (el.type === 'submit') {
                                actionType = 'submit';
                            } else if (el.tagName === 'BUTTON' || hasButtonClass) {
                                actionType = 'button';
                            }

                            buttons.push({
                                text: el.textContent.trim(),
                                href: el.href || '',
                                onclick: onclickAction,
                                actionType: actionType,
                                buttonType: buttonType,
                                // Position (absolute on page)
                                x: rect.left + window.scrollX,
                                y: rect.top + window.scrollY,
                                // Colors
                                bgColor: btnBgColor,
                                textColor: style.color,
                                borderColor: style.borderColor,
                                // Typography
                                fontSize: parseFloat(style.fontSize),
                                fontWeight: parseInt(style.fontWeight),
                                fontFamily: style.fontFamily,
                                textDecoration: style.textDecoration,
                                textTransform: style.textTransform,
                                letterSpacing: style.letterSpacing,
                                lineHeight: style.lineHeight,
                                // Box model
                                padding: style.padding,
                                margin: style.margin,
                                width: rect.width,
                                height: rect.height,
                                // Visual effects
                                borderRadius: style.borderRadius,
                                borderWidth: style.borderWidth,
                                borderStyle: style.borderStyle,
                                boxShadow: style.boxShadow,
                                opacity: parseFloat(style.opacity),
                                // Transform & effects
                                transform: style.transform,
                                transition: style.transition,
                                backgroundImage: style.backgroundImage
                            });
                        }
                    });

                    // IMPROVED: Extract section background by walking up DOM tree
                    const sectionElement = document.elementFromPoint(window.innerWidth / 2, sectionTop + 50);
                    let bgColor = 'rgb(255, 255, 255)';
                    let bgGradient = '';
                    let textColor = 'rgb(0, 0, 0)';
                    let sectionCSS = {};

                    // Helper to check if color is transparent
                    function isTransparent(color) {
                        if (!color) return true;
                        return color === 'rgba(0, 0, 0, 0)' ||
                               color === 'transparent' ||
                               color.includes('rgba') && color.match(/,\\s*0\\s*\\)$/);
                    }

                    // Find actual background color by walking up DOM tree
                    function findBackgroundColor(el) {
                        let current = el;
                        while (current && current !== document.body) {
                            const style = window.getComputedStyle(current);
                            const bg = style.backgroundColor;

                            // Check for gradient first
                            const bgImage = style.backgroundImage;
                            if (bgImage && bgImage !== 'none' && bgImage.includes('gradient')) {
                                return { color: bg, gradient: bgImage };
                            }

                            // Check for solid background
                            if (bg && !isTransparent(bg)) {
                                return { color: bg, gradient: '' };
                            }

                            current = current.parentElement;
                        }

                        // Check body as last resort
                        const bodyStyle = window.getComputedStyle(document.body);
                        return {
                            color: bodyStyle.backgroundColor || 'rgb(255, 255, 255)',
                            gradient: ''
                        };
                    }

                    if (sectionElement) {
                        const style = window.getComputedStyle(sectionElement);

                        // Get background color by walking up DOM tree
                        const bgResult = findBackgroundColor(sectionElement);
                        bgColor = bgResult.color;
                        bgGradient = bgResult.gradient;

                        // Get text color from content elements
                        const textEl = sectionElement.querySelector('p, span, h1, h2, h3, h4, h5, h6');
                        if (textEl) {
                            textColor = window.getComputedStyle(textEl).color;
                        } else {
                            textColor = style.color;
                        }

                        // Also check for background image (non-gradient)
                        const bgImage = style.backgroundImage;
                        if (bgImage && bgImage !== 'none' && bgImage.includes('gradient')) {
                            bgGradient = bgImage;
                        }

                        // Capture ALL important CSS properties
                        sectionCSS = {
                            // Colors & backgrounds
                            backgroundColor: style.backgroundColor,
                            backgroundImage: style.backgroundImage,
                            backgroundSize: style.backgroundSize,
                            backgroundPosition: style.backgroundPosition,
                            backgroundRepeat: style.backgroundRepeat,
                            color: style.color,

                            // Box model
                            padding: style.padding,
                            paddingTop: style.paddingTop,
                            paddingRight: style.paddingRight,
                            paddingBottom: style.paddingBottom,
                            paddingLeft: style.paddingLeft,
                            margin: style.margin,

                            // Borders
                            border: style.border,
                            borderRadius: style.borderRadius,
                            borderWidth: style.borderWidth,
                            borderStyle: style.borderStyle,
                            borderColor: style.borderColor,

                            // Visual effects
                            boxShadow: style.boxShadow,
                            opacity: style.opacity,
                            filter: style.filter,

                            // Layout
                            display: style.display,
                            position: style.position,
                            zIndex: style.zIndex,
                            overflow: style.overflow,

                            // Flexbox
                            flexDirection: style.flexDirection,
                            justifyContent: style.justifyContent,
                            alignItems: style.alignItems,
                            gap: style.gap,

                            // Grid
                            gridTemplateColumns: style.gridTemplateColumns,
                            gridTemplateRows: style.gridTemplateRows,
                            gridGap: style.gridGap,

                            // Typography
                            fontFamily: style.fontFamily,
                            fontSize: style.fontSize,
                            fontWeight: style.fontWeight,
                            lineHeight: style.lineHeight,
                            letterSpacing: style.letterSpacing,
                            textAlign: style.textAlign,
                            textTransform: style.textTransform,
                            textDecoration: style.textDecoration,

                            // Effects & animations
                            transform: style.transform,
                            transition: style.transition,
                            animation: style.animation
                        };
                    }

                    // Extract all text colors in section
                    const allColors = new Set();
                    sectionElements.forEach(el => {
                        const style = window.getComputedStyle(el);
                        if (style.color) allColors.add(style.color);
                        if (style.backgroundColor !== 'rgba(0, 0, 0, 0)') {
                            allColors.add(style.backgroundColor);
                        }
                    });

                    return {
                        title: headings[0]?.text || '',
                        subtitle: headings[1]?.text || headings.length > 2 ? headings[2]?.text : '',
                        content: paragraphs.slice(0, 3).map(p => p.text).join(' '),
                        headings: headings,
                        paragraphs: paragraphs,
                        buttons: buttons,
                        colors: {
                            background: bgColor,
                            text: textColor,
                            gradient: bgGradient,
                            palette: Array.from(allColors)
                        },
                        typography: {
                            titleSize: headings[0]?.fontSize || 42,
                            titleWeight: headings[0]?.fontWeight || 700,
                            titleColor: headings[0]?.color || textColor,
                            contentSize: paragraphs[0]?.fontSize || 16,
                            contentWeight: paragraphs[0]?.fontWeight || 400,
                            contentColor: paragraphs[0]?.color || textColor,
                            fontFamily: headings[0]?.fontFamily || paragraphs[0]?.fontFamily || 'Arial'
                        },
                        // NEW: Complete section CSS
                        css: sectionCSS
                    };
                }
            """, {'yPos': section['y_position'], 'height': section['height']})

            section['content'] = content_data
            print(f"      ✓ Section {idx+1}: Title='{content_data['title'][:40]}...', {len(content_data['buttons'])} buttons, {len(content_data['colors']['palette'])} colors")

    async def extract_navigation_and_galleries(self, page: Page):
        """Extract navigation items and gallery images for each section"""
        print("\n   🧭 Extracting navigation items and gallery images...")

        # Debug: Show section types
        navbar_count = sum(1 for s in self.sections if s['type'] == 1)
        hero_count = sum(1 for s in self.sections if s['type'] == 0)
        gallery_count = sum(1 for s in self.sections if s['type'] in [4, 8])
        print(f"      📊 Section types: {navbar_count} navbars, {hero_count} heroes, {gallery_count} galleries/CTAs")

        for idx, section in enumerate(self.sections):
            # Extract navigation items if this is a navbar section (type 1)
            if section['type'] == 1:
                nav_data = await page.evaluate("""
                    (args) => {
                        const yPos = args.yPos;
                        const height = args.height;

                        // Find all links in this section
                        const allLinks = document.querySelectorAll('a');
                        const navLinks = [];

                        Array.from(allLinks).forEach(link => {
                            const rect = link.getBoundingClientRect();
                            const linkY = rect.top + window.scrollY;

                            // Check if link is within this section
                            if (linkY >= yPos && linkY < yPos + height) {
                                const style = window.getComputedStyle(link);
                                const text = link.textContent.trim();

                                // Only include if has visible text and not too long
                                if (text.length > 0 && text.length < 50) {
                                    navLinks.push({
                                        text: text,
                                        href: link.href || '',
                                        fontSize: parseFloat(style.fontSize) || 16,
                                        fontWeight: parseInt(style.fontWeight) || 400,
                                        color: style.color || 'rgb(0, 0, 0)'
                                    });
                                }
                            }
                        });

                        return navLinks.slice(0, 10);  // Limit to 10 nav items
                    }
                """, {'yPos': section['y_position'], 'height': section['height']})

                section['nav_items'] = nav_data

                # Extract logo from navbar
                logo_data = await page.evaluate("""
                    (args) => {
                        const yPos = args.yPos;
                        const height = args.height;

                        // Find logo image in navbar
                        const allImages = document.querySelectorAll('img, svg');
                        let logo = null;
                        let maxLogoArea = 0;

                        Array.from(allImages).forEach(img => {
                            const rect = img.getBoundingClientRect();
                            const imgY = rect.top + window.scrollY;

                            // Check if image is within navbar
                            if (imgY >= yPos && imgY < yPos + height) {
                                const area = rect.width * rect.height;
                                // Logo is typically the largest image in navbar (but not too big)
                                if (area > maxLogoArea && rect.width < 300 && rect.height < 120) {
                                    if (img.tagName === 'IMG') {
                                        logo = {
                                            src: img.src || img.dataset.src || '',
                                            alt: img.alt || 'Logo',
                                            width: rect.width,
                                            height: rect.height,
                                            type: 'img'
                                        };
                                    } else if (img.tagName === 'svg') {
                                        // For SVG logos, get the outerHTML
                                        logo = {
                                            src: 'data:image/svg+xml,' + encodeURIComponent(img.outerHTML),
                                            alt: 'Logo',
                                            width: rect.width,
                                            height: rect.height,
                                            type: 'svg'
                                        };
                                    }
                                    maxLogoArea = area;
                                }
                            }
                        });

                        return logo;
                    }
                """, {'yPos': section['y_position'], 'height': section['height']})

                if logo_data:
                    section['logo'] = logo_data
                    print(f"      ✓ Logo extracted: {logo_data.get('alt', 'Logo')}")

                # Extract nested/dropdown menus
                dropdown_data = await page.evaluate("""
                    (args) => {
                        const yPos = args.yPos;
                        const height = args.height;

                        const dropdowns = [];
                        const navElements = document.querySelectorAll('nav li, nav div[class*="menu"], nav div[class*="dropdown"]');

                        Array.from(navElements).forEach(el => {
                            const rect = el.getBoundingClientRect();
                            const elY = rect.top + window.scrollY;

                            if (elY >= yPos && elY < yPos + height) {
                                // Check for nested links
                                const nestedLinks = el.querySelectorAll('ul a, div[class*="dropdown"] a, div[class*="submenu"] a');
                                if (nestedLinks.length > 0) {
                                    const parentLink = el.querySelector(':scope > a');
                                    if (parentLink) {
                                        const children = [];
                                        Array.from(nestedLinks).slice(0, 20).forEach(link => {
                                            children.push({
                                                text: link.textContent.trim(),
                                                href: link.href || ''
                                            });
                                        });

                                        if (children.length > 0) {
                                            dropdowns.push({
                                                parent: parentLink.textContent.trim(),
                                                children: children
                                            });
                                        }
                                    }
                                }
                            }
                        });

                        return dropdowns.slice(0, 5);  // Limit to 5 dropdowns
                    }
                """, {'yPos': section['y_position'], 'height': section['height']})

                if dropdown_data and len(dropdown_data) > 0:
                    section['dropdown_menus'] = dropdown_data
                    print(f"      ✓ Dropdown menus: Found {len(dropdown_data)} menus with sublinks")

                print(f"      ✓ Navbar (section {idx+1}): Found {len(nav_data)} navigation links")

            # Extract gallery images if this is a gallery section (type 8 or 4)
            if section['type'] in [4, 8]:  # Gallery or CTA
                gallery_data = await page.evaluate("""
                    (args) => {
                        const yPos = args.yPos;
                        const height = args.height;

                        // Find all images in this section
                        const allImages = document.querySelectorAll('img');
                        const galleryImages = [];

                        Array.from(allImages).forEach(img => {
                            const rect = img.getBoundingClientRect();
                            const imgY = rect.top + window.scrollY;

                            // Check if image is within this section
                            if (imgY >= yPos && imgY < yPos + height) {
                                const src = img.src || img.dataset.src || '';
                                if (src && !src.includes('data:image')) {
                                    galleryImages.push({
                                        src: src,
                                        alt: img.alt || '',
                                        width: rect.width,
                                        height: rect.height
                                    });
                                }
                            }
                        });

                        return galleryImages.slice(0, 12);  // Limit to 12 gallery images
                    }
                """, {'yPos': section['y_position'], 'height': section['height']})

                section['gallery_images'] = gallery_data
                print(f"      ✓ Gallery (section {idx+1}): Found {len(gallery_data)} images")

    async def extract_hero_animation_images(self, page: Page):
        """Extract multiple images for hero section animations"""
        print("\n   🎬 Extracting hero animation images...")

        hero_sections = [s for s in self.sections if s['type'] == 0]
        print(f"      📊 Found {len(hero_sections)} hero sections to process")

        for idx, section in enumerate(self.sections):
            # Extract hero animation images if this is a hero section (type 0)
            if section['type'] == 0:
                hero_data = await page.evaluate("""
                    (args) => {
                        const yPos = args.yPos;
                        const height = args.height;

                        // Find all large images in this section
                        const allImages = document.querySelectorAll('img');
                        const heroImages = [];

                        Array.from(allImages).forEach(img => {
                            const rect = img.getBoundingClientRect();
                            const imgY = rect.top + window.scrollY;

                            // Check if image is within this section
                            if (imgY >= yPos && imgY < yPos + height) {
                                const src = img.src || img.dataset.src || '';
                                // Lowered thresholds: 200x150 instead of 400x300
                                // Hero images can be smaller on responsive sites
                                if (src && !src.includes('data:image') && rect.width > 200 && rect.height > 150) {
                                    heroImages.push({
                                        src: src,
                                        alt: img.alt || '',
                                        width: rect.width,
                                        height: rect.height
                                    });
                                }
                            }
                        });

                        // Also check background images from CSS
                        const sectionElements = document.querySelectorAll('*');
                        Array.from(sectionElements).forEach(el => {
                            const rect = el.getBoundingClientRect();
                            const elY = rect.top + window.scrollY;

                            // Check if element is within this section
                            // Lowered thresholds: 200x150 instead of 400x300
                            if (elY >= yPos && elY < yPos + height && rect.width > 200 && rect.height > 150) {
                                const style = window.getComputedStyle(el);
                                const bgImage = style.backgroundImage;

                                if (bgImage && bgImage !== 'none') {
                                    // Extract URL from "url(...)"
                                    const urlMatch = bgImage.match(/url\\(['"]?([^'"]+)['"]?\\)/);
                                    if (urlMatch && urlMatch[1]) {
                                        const url = urlMatch[1];
                                        if (!url.includes('data:image')) {
                                            heroImages.push({
                                                src: url,
                                                alt: 'Hero background',
                                                width: rect.width,
                                                height: rect.height
                                            });
                                        }
                                    }
                                }
                            }
                        });

                        // Remove duplicates and limit to 5 images
                        const uniqueImages = [];
                        const seenSrcs = new Set();
                        heroImages.forEach(img => {
                            if (!seenSrcs.has(img.src)) {
                                seenSrcs.add(img.src);
                                uniqueImages.push(img);
                            }
                        });

                        return uniqueImages.slice(0, 5);  // Limit to 5 hero animation images
                    }
                """, {'yPos': section['y_position'], 'height': section['height']})

                if len(hero_data) > 1:
                    # Multiple images found - enable hero animation
                    section['hero_animation_images'] = [img['src'] for img in hero_data]
                    section['enable_hero_animation'] = True
                    section['hero_animation_speed'] = 2.0  # 2 seconds per image as requested
                    print(f"      ✓ Hero (section {idx+1}): Found {len(hero_data)} images for slideshow animation")
                elif len(hero_data) == 1:
                    # Single image - set as section image
                    print(f"      ✓ Hero (section {idx+1}): Found 1 static image")

    async def extract_footer_and_metadata(self, page: Page):
        """Extract footer, forms, social links, and SEO metadata"""

        # 1. Extract Footer Content
        print("\n   👣 Extracting footer content...")
        footer_data = await page.evaluate("""
            () => {
                const footer = document.querySelector('footer, div[class*="footer"], div[id*="footer"]');
                if (!footer) return null;

                const rect = footer.getBoundingClientRect();
                const footerY = rect.top + window.scrollY;

                // Extract footer links
                const links = [];
                footer.querySelectorAll('a').forEach(link => {
                    const text = link.textContent.trim();
                    if (text.length > 0 && text.length < 100) {
                        links.push({
                            text: text,
                            href: link.href || '',
                            category: link.closest('div[class*="column"], ul, nav')?.querySelector('h1, h2, h3, h4, h5, h6')?.textContent.trim() || 'General'
                        });
                    }
                });

                // Extract social media links
                const socialLinks = [];
                const socialPatterns = ['facebook', 'twitter', 'instagram', 'linkedin', 'youtube', 'pinterest', 'tiktok', 'snapchat'];
                footer.querySelectorAll('a').forEach(link => {
                    const href = link.href.toLowerCase();
                    socialPatterns.forEach(platform => {
                        if (href.includes(platform)) {
                            socialLinks.push({
                                platform: platform.charAt(0).toUpperCase() + platform.slice(1),
                                href: link.href,
                                icon: link.querySelector('svg, img')?.outerHTML || ''
                            });
                        }
                    });
                });

                // Extract copyright text
                const copyright = footer.textContent.match(/©.*?\\d{4}.*?(?=\\n|$)/)?.[0] || '';

                return {
                    y_position: footerY,
                    height: rect.height,
                    links: links.slice(0, 50),
                    social_links: socialLinks,
                    copyright: copyright
                };
            }
        """)

        if footer_data:
            # Create footer section if it doesn't exist
            footer_section = {
                'index': len(self.sections),
                'type': 10,  # Footer type
                'y_position': footer_data['y_position'],
                'height': footer_data['height'],
                'width': 1920,  # Full width
                'html_tag': 'footer',
                'classes': ['footer'],
                'id': 'footer',
                'footer_links': footer_data['links'],
                'social_links': footer_data['social_links'],
                'copyright': footer_data['copyright']
            }
            self.sections.append(footer_section)
            print(f"      ✓ Footer: {len(footer_data['links'])} links, {len(footer_data['social_links'])} social links")
        else:
            print(f"      ⚠️  No footer detected")

        # 2. Extract Forms
        print("\n   📝 Extracting forms...")
        forms_data = await page.evaluate("""
            () => {
                const forms = [];
                document.querySelectorAll('form, div[class*="form"], div[id*="form"]').forEach(form => {
                    const rect = form.getBoundingClientRect();
                    if (rect.height < 20 || rect.width < 100) return;

                    const inputs = [];
                    form.querySelectorAll('input, textarea, select').forEach(input => {
                        inputs.push({
                            type: input.type || input.tagName.toLowerCase(),
                            name: input.name || input.id || '',
                            placeholder: input.placeholder || input.getAttribute('aria-label') || '',
                            required: input.required
                        });
                    });

                    if (inputs.length > 0) {
                        forms.push({
                            y_position: rect.top + window.scrollY,
                            height: rect.height,
                            width: rect.width,
                            inputs: inputs,
                            action: form.action || '',
                            method: form.method || 'POST'
                        });
                    }
                });
                return forms.slice(0, 10);
            }
        """)

        # Add forms to template data
        self.forms = forms_data
        print(f"      ✓ Found {len(forms_data)} forms ({sum(len(f['inputs']) for f in forms_data)} total inputs)")

        # 3. Extract Social Media Links (from entire page)
        print("\n   🔗 Extracting social media links...")
        social_data = await page.evaluate("""
            () => {
                const socialLinks = [];
                const socialPatterns = {
                    'facebook': /facebook\\.com/i,
                    'twitter': /twitter\\.com|x\\.com/i,
                    'instagram': /instagram\\.com/i,
                    'linkedin': /linkedin\\.com/i,
                    'youtube': /youtube\\.com/i,
                    'pinterest': /pinterest\\.com/i,
                    'tiktok': /tiktok\\.com/i,
                    'whatsapp': /whatsapp\\.com|wa\\.me/i,
                    'telegram': /t\\.me|telegram\\.me/i
                };

                document.querySelectorAll('a[href*="facebook"], a[href*="twitter"], a[href*="instagram"], a[href*="linkedin"], a[href*="youtube"], a[href*="pinterest"], a[href*="tiktok"], a[href*="whatsapp"], a[href*="telegram"]').forEach(link => {
                    for (const [platform, pattern] of Object.entries(socialPatterns)) {
                        if (pattern.test(link.href)) {
                            const rect = link.getBoundingClientRect();
                            socialLinks.push({
                                platform: platform.charAt(0).toUpperCase() + platform.slice(1),
                                href: link.href,
                                position: {
                                    x: rect.left,
                                    y: rect.top + window.scrollY
                                },
                                icon: link.querySelector('svg, img, i')?.outerHTML || link.textContent.trim()
                            });
                            break;
                        }
                    }
                });

                return socialLinks;
            }
        """)

        self.social_links = social_data
        print(f"      ✓ Found {len(social_data)} social media links")

        # 4. Extract SEO/Meta Data
        print("\n   🔍 Extracting SEO metadata...")
        seo_data = await page.evaluate("""
            () => {
                const meta = {};

                // Page title
                meta.title = document.title || '';

                // Meta description
                const descMeta = document.querySelector('meta[name="description"]');
                meta.description = descMeta?.content || '';

                // Keywords
                const keywordsMeta = document.querySelector('meta[name="keywords"]');
                meta.keywords = keywordsMeta?.content || '';

                // Open Graph tags
                meta.og = {
                    title: document.querySelector('meta[property="og:title"]')?.content || '',
                    description: document.querySelector('meta[property="og:description"]')?.content || '',
                    image: document.querySelector('meta[property="og:image"]')?.content || '',
                    url: document.querySelector('meta[property="og:url"]')?.content || ''
                };

                // Twitter Card
                meta.twitter = {
                    card: document.querySelector('meta[name="twitter:card"]')?.content || '',
                    title: document.querySelector('meta[name="twitter:title"]')?.content || '',
                    description: document.querySelector('meta[name="twitter:description"]')?.content || '',
                    image: document.querySelector('meta[name="twitter:image"]')?.content || ''
                };

                // Favicon
                const favicon = document.querySelector('link[rel="icon"], link[rel="shortcut icon"], link[rel="apple-touch-icon"]');
                meta.favicon = favicon?.href || '';

                // Canonical URL
                const canonical = document.querySelector('link[rel="canonical"]');
                meta.canonical = canonical?.href || '';

                // Language
                meta.lang = document.documentElement.lang || '';

                return meta;
            }
        """)

        self.seo_data = seo_data
        print(f"      ✓ SEO: Title='{seo_data['title'][:50]}...', Description={len(seo_data['description'])} chars")
        if seo_data['favicon']:
            print(f"      ✓ Favicon: {seo_data['favicon']}")

    async def download_fonts(self, page: Page):
        """Download custom web fonts"""
        print("\n   🔤 Downloading custom fonts...")

        try:
            # Get all font URLs
            font_data = await page.evaluate("""
                () => {
                    const fonts = new Set();

                    // Check all stylesheets
                    Array.from(document.styleSheets).forEach(sheet => {
                        try {
                            Array.from(sheet.cssRules).forEach(rule => {
                                if (rule.cssText.includes('@font-face')) {
                                    const urlMatch = rule.cssText.match(/url\\(['"]?([^'"]+\\.(?:woff2?|ttf|otf|eot))['"]?\\)/gi);
                                    if (urlMatch) {
                                        urlMatch.forEach(match => {
                                            const url = match.match(/url\\(['"]?([^'"]+)['"]?\\)/)[1];
                                            if (url) fonts.add(url);
                                        });
                                    }
                                }
                            });
                        } catch (e) {
                            // Skip cross-origin stylesheets
                        }
                    });

                    return Array.from(fonts);
                }
            """)

            if font_data and len(font_data) > 0:
                self.custom_fonts = font_data[:20]  # Limit to 20 fonts
                print(f"      ✓ Found {len(font_data)} custom font files")
            else:
                print(f"      ℹ️  No custom fonts found")
        except Exception as e:
            print(f"      ⚠️  Error extracting fonts: {str(e)}")

    async def extract_advanced_css(self, page: Page):
        """Extract advanced CSS like hover effects, transitions, animations"""
        print("\n   ✨ Extracting advanced CSS...")

        advanced_css = await page.evaluate("""
            () => {
                const advancedStyles = {
                    hoverEffects: [],
                    animations: [],
                    transitions: []
                };

                // Sample elements for hover effects
                const interactiveElements = document.querySelectorAll('button, a, .card, [class*="card"], [class*="item"]');
                Array.from(interactiveElements).slice(0, 50).forEach(el => {
                    const style = window.getComputedStyle(el);

                    // Check for transitions
                    if (style.transition && style.transition !== 'all 0s ease 0s') {
                        advancedStyles.transitions.push({
                            selector: el.className || el.tagName.toLowerCase(),
                            transition: style.transition
                        });
                    }

                    // Check for animations
                    if (style.animation && style.animation !== 'none') {
                        advancedStyles.animations.push({
                            selector: el.className || el.tagName.toLowerCase(),
                            animation: style.animation
                        });
                    }
                });

                // Try to detect hover effects from stylesheets
                try {
                    Array.from(document.styleSheets).forEach(sheet => {
                        try {
                            Array.from(sheet.cssRules).forEach(rule => {
                                if (rule.selectorText && rule.selectorText.includes(':hover')) {
                                    advancedStyles.hoverEffects.push({
                                        selector: rule.selectorText,
                                        css: rule.style.cssText
                                    });
                                }
                            });
                        } catch (e) {
                            // Skip cross-origin stylesheets
                        }
                    });
                } catch (e) {
                    // Error accessing stylesheets
                }

                return {
                    hoverEffects: advancedStyles.hoverEffects.slice(0, 30),
                    animations: advancedStyles.animations.slice(0, 20),
                    transitions: advancedStyles.transitions.slice(0, 20)
                };
            }
        """)

        self.advanced_css = advanced_css
        print(f"      ✓ Hover effects: {len(advanced_css['hoverEffects'])}, Animations: {len(advanced_css['animations'])}, Transitions: {len(advanced_css['transitions'])}")

    async def detect_typography(self, page: Page):
        """Extract typography system from the page"""
        print("\n   🔤 Detecting typography (fonts, sizes, weights)...")

        typography = await page.evaluate("""
            () => {
                const fontFamilies = new Set();
                const fontSizes = [];
                const fontWeights = [];

                // Extract from headings
                ['h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'p', 'button', 'a'].forEach(tag => {
                    const elements = document.querySelectorAll(tag);
                    elements.forEach(el => {
                        const style = window.getComputedStyle(el);

                        // Collect font families
                        fontFamilies.add(style.fontFamily);

                        // Collect font sizes (convert to px)
                        const fontSize = parseFloat(style.fontSize);
                        if (fontSize && fontSize > 0) {
                            fontSizes.push({tag, size: Math.round(fontSize)});
                        }

                        // Collect font weights
                        const weight = parseInt(style.fontWeight);
                        if (weight && weight > 0) {
                            fontWeights.push(weight);
                        }
                    });
                });

                // Get most common values
                const fontSizesByTag = {};
                fontSizes.forEach(({tag, size}) => {
                    if (!fontSizesByTag[tag]) fontSizesByTag[tag] = [];
                    fontSizesByTag[tag].push(size);
                });

                // Calculate average for each tag
                const avgSizes = {};
                Object.keys(fontSizesByTag).forEach(tag => {
                    const sizes = fontSizesByTag[tag];
                    avgSizes[tag] = Math.round(sizes.reduce((a, b) => a + b, 0) / sizes.length);
                });

                // Get unique weights
                const uniqueWeights = [...new Set(fontWeights)].sort((a, b) => a - b);

                return {
                    fonts: Array.from(fontFamilies),
                    sizes: avgSizes,
                    weights: uniqueWeights
                };
            }
        """)

        self.typography_system = typography
        print(f"      ✓ Fonts detected: {len(typography['fonts'])}")
        print(f"      ✓ Font sizes: H1={typography['sizes'].get('h1', 48)}px, Body={typography['sizes'].get('p', 16)}px")
        print(f"      ✓ Font weights: {typography['weights']}")

        return typography

    async def refine_section_types_and_apply_data(self):
        """Refine section types based on content and apply extracted colors/typography"""
        print("\n   🎨 Refining section types and applying extracted data...")

        changes_count = 0
        for idx, section in enumerate(self.sections):
            # Refine section type based on content
            original_type = section['type']
            refined_type = self.improve_section_type_with_content(section)
            section['type'] = refined_type

            if refined_type != original_type:
                changes_count += 1
                type_names = {0: 'Hero', 1: 'Navbar', 2: 'About', 3: 'Services', 4: 'Gallery', 8: 'CTA', 10: 'Footer'}
                old_name = type_names.get(original_type, f'Type{original_type}')
                new_name = type_names.get(refined_type, f'Type{refined_type}')
                print(f"      ✓ Section {idx+1}: {old_name} → {new_name}")

        # Summary of final section types
        type_counts = {}
        for section in self.sections:
            t = section['type']
            type_counts[t] = type_counts.get(t, 0) + 1

        type_names = {0: 'Hero', 1: 'Navbar', 2: 'About', 3: 'Services', 4: 'Gallery', 8: 'CTA', 10: 'Footer'}
        summary = ', '.join([f"{type_counts[t]} {type_names.get(t, f'Type{t}')}" for t in sorted(type_counts.keys())])
        print(f"      📊 Final types ({changes_count} changes): {summary}")

        # Apply extracted colors and typography to all sections
        for idx, section in enumerate(self.sections):
            # Apply extracted colors and typography
            content = section.get('content', {})
            colors = content.get('colors', {})
            typography = content.get('typography', {})
            buttons = content.get('buttons', [])
            paragraphs = content.get('paragraphs', [])
            headings = content.get('headings', [])

            # Store colors
            section['bg_color'] = colors.get('background', 'rgb(255, 255, 255)')
            section['text_color'] = colors.get('text', 'rgb(0, 0, 0)')
            section['gradient'] = colors.get('gradient', '')
            section['color_palette'] = colors.get('palette', [])

            # Store typography
            section['title_font_size'] = typography.get('titleSize', 42)
            section['title_font_weight'] = typography.get('titleWeight', 700)
            section['title_color'] = typography.get('titleColor', 'rgb(0, 0, 0)')
            section['content_font_size'] = typography.get('contentSize', 16)
            section['content_font_weight'] = typography.get('contentWeight', 400)
            section['content_color'] = typography.get('contentColor', 'rgb(0, 0, 0)')
            section['font_family'] = typography.get('fontFamily', 'Arial')

            # IMPROVED: Store button data - prioritize CTA buttons over nav buttons
            if len(buttons) > 0:
                # Separate CTA buttons from navigation links
                cta_buttons = [b for b in buttons if b.get('buttonType') == 'cta']
                nav_buttons = [b for b in buttons if b.get('buttonType') == 'nav']
                other_buttons = [b for b in buttons if b.get('buttonType') not in ['cta', 'nav']]

                # For navbar sections, store nav buttons separately
                if section['type'] == 1:
                    section['nav_buttons'] = nav_buttons
                    # Use first CTA as primary button if available
                    btn = cta_buttons[0] if cta_buttons else (buttons[0] if buttons else None)
                else:
                    # For other sections, prefer CTA buttons
                    btn = cta_buttons[0] if cta_buttons else (other_buttons[0] if other_buttons else buttons[0])

                if btn:
                    section['button_text'] = btn.get('text', '')
                    section['button_link'] = btn.get('href', '')
                    section['button_bg_color'] = btn.get('bgColor', 'rgb(200, 100, 125)')
                    section['button_text_color'] = btn.get('textColor', 'rgb(255, 255, 255)')
                    # Complete button CSS
                    section['button_border_radius'] = btn.get('borderRadius', '0px')
                    section['button_border_width'] = btn.get('borderWidth', '0px')
                    section['button_border_color'] = btn.get('borderColor', 'rgb(0,0,0)')
                    section['button_box_shadow'] = btn.get('boxShadow', 'none')
                    section['button_padding'] = btn.get('padding', '10px 20px')
                    section['button_text_transform'] = btn.get('textTransform', 'none')
                    section['button_letter_spacing'] = btn.get('letterSpacing', 'normal')
                    section['button_font_size'] = btn.get('fontSize', 16)
                    section['button_font_weight'] = btn.get('fontWeight', 600)

            # Create card items from multiple buttons/links (for sections with many buttons)
            cards = []
            if len(buttons) > 3:  # If there are multiple buttons, create cards
                for idx, btn in enumerate(buttons[:12]):  # Limit to 12 items
                    card = {
                        'title': btn.get('text', f'Item {idx+1}')[:100],
                        'description': paragraphs[idx].get('text', '')[:300] if idx < len(paragraphs) else '',
                        'link': btn.get('href', ''),
                        'button_text': btn.get('text', '')[:50],
                        'bg_color': btn.get('bgColor', 'rgb(255, 255, 255)'),
                        'text_color': btn.get('textColor', 'rgb(0, 0, 0)'),
                        'title_font_size': int(btn.get('fontSize', 16)),
                        'title_font_weight': int(btn.get('fontWeight', 500)),
                    }
                    cards.append(card)

                section['cards'] = cards
                # Set grid layout based on captured CSS
                styles = section.get('styles', {})
                grid_cols = styles.get('gridTemplateColumns', '')
                if grid_cols:
                    # Count how many columns (e.g., "270px 270px 270px 270px" = 4 columns)
                    col_count = len([x for x in grid_cols.split() if 'px' in x or 'fr' in x])
                    section['cards_per_row'] = min(col_count, 4) if col_count > 0 else 3

            # Store multiple headings as structured content
            if len(headings) > 2:
                # Store first heading as title, second as subtitle, rest as multi_column_text
                section['title'] = headings[0].get('text', '') if len(headings) > 0 else ''
                section['subtitle'] = headings[1].get('text', '') if len(headings) > 1 else ''
                # Combine remaining headings into multi_column_text
                extra_headings = [h.get('text', '') for h in headings[2:5]]  # Get 3-5 more headings
                if extra_headings:
                    section['multi_column_text'] = '\n'.join(extra_headings)

            # Store multiple paragraphs as multi-column content
            if len(paragraphs) > 2 and not cards:  # Only if not already creating cards
                # Join paragraphs with separator for multi-column rendering
                para_texts = [p.get('text', '') for p in paragraphs[:5]]  # Limit to 5 paragraphs
                section['multi_column_text'] = ' | '.join(para_texts)  # Use | as column separator

            # Store complete section CSS
            css = content.get('css', {})
            if css:
                section['css_border_radius'] = css.get('borderRadius', '0px')
                section['css_box_shadow'] = css.get('boxShadow', 'none')
                section['css_border'] = css.get('border', 'none')
                section['css_opacity'] = css.get('opacity', '1')
                section['css_background_image'] = css.get('backgroundImage', 'none')
                section['css_background_size'] = css.get('backgroundSize', 'auto')
                section['css_filter'] = css.get('filter', 'none')
                section['css_transform'] = css.get('transform', 'none')
                section['css_text_shadow'] = css.get('textShadow', 'none')
                section['css_line_height'] = css.get('lineHeight', 'normal')
                section['css_letter_spacing'] = css.get('letterSpacing', 'normal')

            # Store layout properties (padding, flexbox, grid, positioning)
            styles = section.get('styles', {})
            if styles:
                # Padding (4-sided: top, right, bottom, left)
                padding_str = styles.get('padding', '60px')
                section['padding_top'] = padding_str.split()[0] if padding_str != 'normal' else '60px'
                section['padding_right'] = padding_str.split()[1] if len(padding_str.split()) > 1 else section['padding_top']
                section['padding_bottom'] = padding_str.split()[2] if len(padding_str.split()) > 2 else section['padding_top']
                section['padding_left'] = padding_str.split()[3] if len(padding_str.split()) > 3 else section['padding_right']

                # Flexbox/Grid properties
                section['display'] = styles.get('display', 'block')
                section['flex_direction'] = styles.get('flexDirection', 'row')
                section['justify_content'] = styles.get('justifyContent', 'normal')
                section['align_items'] = styles.get('alignItems', 'normal')
                section['gap'] = styles.get('gap', '0px')
                section['grid_template_columns'] = styles.get('gridTemplateColumns', 'none')
                section['grid_template_rows'] = styles.get('gridTemplateRows', 'none')

                # Background properties
                section['background_position'] = styles.get('backgroundPosition', '0% 0%')
                section['background_repeat'] = styles.get('backgroundRepeat', 'repeat')
                section['background_size'] = styles.get('backgroundSize', 'auto')
                section['background_image'] = styles.get('backgroundImage', 'none')

                # Position properties (for overlays)
                section['position'] = styles.get('position', 'static')
                section['top'] = styles.get('top', 'auto')
                section['left'] = styles.get('left', 'auto')
                section['right'] = styles.get('right', 'auto')
                section['bottom'] = styles.get('bottom', 'auto')
                section['z_index'] = styles.get('zIndex', 'auto')

                # Font family for custom fonts
                section['font_family'] = styles.get('fontFamily', 'system-ui')

        print(f"      ✓ Applied colors, typography and CSS to {len(self.sections)} sections")

    async def standardize_component_sizes(self):
        """Apply standard component sizing for consistency"""
        print("\n   📏 Standardizing component sizes...")

        standards = {
            'button': {'min_width': 120, 'height': 48, 'padding': 16},
            'card': {'width': 800, 'height': 1000, 'spacing': 40, 'border_radius': 8},
            'hero': {'min_height': 600, 'max_height': 900},
            'navbar': {'height': 80},
            'footer': {'min_height': 300},
            'input': {'height': 48, 'border_radius': 4}
        }

        for section in self.sections:
            section_type = section['type']

            # Apply card standards to card sections (types 3, 4, 5, 6)
            if section_type in [3, 4, 5, 6]:
                section['card_width'] = standards['card']['width']
                section['card_height'] = standards['card']['height']
                section['card_spacing'] = standards['card']['spacing']
                section['border_radius'] = standards['card']['border_radius']

            # Apply hero standards
            elif section_type == 0:  # Hero
                if section['height'] < standards['hero']['min_height']:
                    section['height'] = standards['hero']['min_height']
                elif section['height'] > standards['hero']['max_height']:
                    section['height'] = standards['hero']['max_height']

            # Apply navbar standards
            elif section_type == 1:  # Navbar
                section['height'] = standards['navbar']['height']

            # Apply footer standards
            elif section_type == 10:  # Footer
                if section['height'] < standards['footer']['min_height']:
                    section['height'] = standards['footer']['min_height']

            # FIX: Cap all section heights to reasonable viewport sizes
            # Problem: Sections can be 5000px+ which makes scrolling terrible
            # Solution: Cap to 1200px max (about 1.5 viewports)
            if section['height'] > 1200:
                # Store original height for reference
                section['original_height'] = section['height']
                # Cap to reasonable size based on content
                if section_type in [3, 4, 5, 6]:  # Card sections
                    section['height'] = 800  # Enough for 2-3 rows of cards
                elif section_type in [0]:  # Hero
                    section['height'] = 700  # Full viewport hero
                elif section_type in [2, 8]:  # About, CTA
                    section['height'] = 500  # Medium content sections
                else:
                    section['height'] = 600  # Default reasonable height

        print(f"      ✓ Standardized {len(self.sections)} sections")
        print(f"      ✓ Card size: {standards['card']['width']}×{standards['card']['height']}px")

    async def detect_grid_system(self, page: Page):
        """Detect grid system and spacing patterns"""
        print("\n   🎯 Detecting grid system and spacing...")

        grid_info = await page.evaluate("""
            () => {
                const containers = document.querySelectorAll('[class*="container"], [class*="wrapper"], main, .main');
                const spacings = [];
                const gridColumns = [];

                containers.forEach(container => {
                    const style = window.getComputedStyle(container);

                    // Extract max-width
                    const maxWidth = style.maxWidth;

                    // Extract grid template columns
                    const gridCols = style.gridTemplateColumns;
                    if (gridCols && gridCols !== 'none') {
                        gridColumns.push(gridCols);
                    }

                    // Extract gaps and padding
                    const gap = parseFloat(style.gap) || parseFloat(style.gridGap);
                    const padding = parseFloat(style.padding);

                    if (gap && gap > 0) spacings.push(Math.round(gap));
                    if (padding && padding > 0) spacings.push(Math.round(padding));
                });

                // Find common spacings (GCD approach)
                const uniqueSpacings = [...new Set(spacings)].filter(s => s > 0).sort((a, b) => a - b);

                // Detect base unit (4, 8, or 16)
                let baseUnit = 8;
                if (uniqueSpacings.length > 0) {
                    // Find GCD
                    const gcd = (a, b) => b === 0 ? a : gcd(b, a % b);
                    baseUnit = uniqueSpacings.reduce((a, b) => gcd(a, b));

                    // Round to nearest 4
                    baseUnit = Math.round(baseUnit / 4) * 4;
                    if (baseUnit < 4) baseUnit = 4;
                    if (baseUnit > 16) baseUnit = 16;
                }

                return {
                    baseUnit: baseUnit,
                    spacingScale: [baseUnit, baseUnit * 2, baseUnit * 3, baseUnit * 4, baseUnit * 6, baseUnit * 8],
                    commonSpacings: uniqueSpacings.slice(0, 10),
                    gridColumns: gridColumns.length > 0 ? gridColumns[0] : 'none'
                };
            }
        """)

        self.grid_system = grid_info
        print(f"      ✓ Base spacing unit: {grid_info['baseUnit']}px")
        print(f"      ✓ Spacing scale: {grid_info['spacingScale']}")

        # Apply grid spacing and padding to ALL sections
        for section in self.sections:
            base_unit = grid_info['baseUnit']

            # Apply padding based on section type
            if section['type'] == 1:  # Navbar
                section['padding'] = base_unit * 5  # 20-40px
            elif section['type'] == 0:  # Hero
                section['padding'] = base_unit * 10  # 40-160px
            elif section['type'] == 10:  # Footer
                section['padding'] = base_unit * 10  # 40-160px
            else:  # Content sections
                section['padding'] = base_unit * 15  # 60-240px

            # Apply card spacing for grid sections
            if section['type'] in [3, 4, 5, 6]:  # Card sections
                section['card_spacing'] = base_unit * 5  # 20-80px

            # Store container max width
            section['container_max_width'] = 1200  # Standard container width

        print(f"      ✓ Applied spacing to {len(self.sections)} sections")
        return grid_info

    def split_wix_sections(self):
        """IMPROVED: Dynamically split Wix sections based on content analysis"""
        if not self.sections:
            return

        # Check if we have a section with lots of content that needs splitting
        main_section = self.sections[0]
        content = main_section.get('content', {})
        headings = content.get('headings', [])
        buttons = content.get('buttons', [])
        paragraphs = content.get('paragraphs', [])
        colors = content.get('colors', {})
        palette = colors.get('palette', [])

        # Only split if we have substantial content lumped together
        total_content_items = len(headings) + len(buttons) + len(paragraphs)
        if total_content_items < 10:
            print(f"   ⚠️  Not enough content to split ({total_content_items} items)")
            return

        print(f"   🔀 Dynamically splitting: {len(headings)} headings, {len(buttons)} buttons, {len(paragraphs)} paragraphs...")

        # Extract dominant colors from palette
        bg_colors = [c for c in palette if c and 'rgba' in str(c)]
        primary_bg = bg_colors[0] if bg_colors else 'rgba(255, 255, 255, 1)'
        secondary_bg = bg_colors[1] if len(bg_colors) > 1 else 'rgba(245, 245, 245, 1)'
        accent_bg = bg_colors[2] if len(bg_colors) > 2 else 'rgba(79, 172, 159, 1)'

        # Get text colors
        text_color = colors.get('text', 'rgba(32, 48, 60, 1)')

        # Extract styling info from original section to reuse
        base_styles = {
            'text_color': text_color,
            'title_color': text_color,
            'accent_color': accent_bg,
            'title_font_size': main_section.get('title_font_size', 48),
            'content_font_size': main_section.get('content_font_size', 16),
            'padding': main_section.get('padding', 80),
        }

        new_sections = []
        current_y = 0
        section_idx = 0

        # SECTION 1: Create Navigation from short buttons at top
        nav_buttons = [b for b in buttons[:15] if b.get('text') and len(b.get('text', '')) < 25]
        if nav_buttons and len(nav_buttons) >= 3:
            nav_items = [{'text': b.get('text', ''), 'href': b.get('href', '')} for b in nav_buttons[:8]]
            nav_section = {
                'index': section_idx,
                'type': 1,
                'name': 'Navigation',
                'title': headings[0].get('text', 'Site Name')[:50] if headings else 'Site Name',
                'y_position': current_y,
                'height': 80,
                'width': 1920,
                'nav_items': nav_items,
                **base_styles,
                'bg_color': accent_bg,
                'text_color': 'rgba(255, 255, 255, 1)',
            }
            new_sections.append(nav_section)
            section_idx += 1
            current_y += 80

        # SECTION 2: Hero section - first large heading with associated content
        hero_heading = headings[0] if headings else {'text': 'Welcome', 'fontSize': 48}
        hero_subtitle = headings[1] if len(headings) > 1 else None
        hero_paragraphs = paragraphs[:2]
        hero_buttons = [b for b in buttons if b.get('text') and len(b.get('text', '')) >= 10][:2]

        hero_section = {
            'index': section_idx,
            'type': 0,
            'name': 'Hero',
            'title': hero_heading.get('text', '')[:100],
            'subtitle': hero_subtitle.get('text', '')[:100] if hero_subtitle else '',
            'content_text': ' '.join([p.get('text', '') for p in hero_paragraphs])[:300],
            'button_text': hero_buttons[0].get('text', 'Learn More') if hero_buttons else 'Learn More',
            'y_position': current_y,
            'height': 600,
            'width': 1920,
            **base_styles,
            'bg_color': primary_bg,
            'title_font_size': hero_heading.get('fontSize', 48),
            'title_color': hero_heading.get('color', text_color),
        }
        # Copy button styling if available
        if hero_buttons:
            hero_section['button_bg_color'] = hero_buttons[0].get('bgColor', accent_bg)
            hero_section['button_text_color'] = hero_buttons[0].get('textColor', 'rgba(255, 255, 255, 1)')
        new_sections.append(hero_section)
        section_idx += 1
        current_y += 600

        # SECTION 3+: Create sections from remaining headings (each H2/H3 becomes a section)
        remaining_headings = headings[2:] if len(headings) > 2 else []
        remaining_paragraphs = paragraphs[2:] if len(paragraphs) > 2 else []
        remaining_buttons = buttons[len(nav_buttons)+2:] if len(buttons) > len(nav_buttons)+2 else []

        # Group content by headings
        para_per_section = max(1, len(remaining_paragraphs) // max(1, len(remaining_headings)))
        btn_per_section = max(1, len(remaining_buttons) // max(1, len(remaining_headings)))

        section_types = [3, 2, 3, 8, 3, 7]  # Services, About, Services, CTA, Services, Testimonials
        bg_cycle = [secondary_bg, primary_bg, accent_bg]

        for i, heading in enumerate(remaining_headings[:6]):  # Max 6 additional sections
            section_type = section_types[i % len(section_types)]
            section_bg = bg_cycle[i % len(bg_cycle)]

            # Get paragraphs for this section
            start_para = i * para_per_section
            end_para = start_para + para_per_section
            section_paragraphs = remaining_paragraphs[start_para:end_para]

            # Get buttons for this section
            start_btn = i * btn_per_section
            end_btn = start_btn + btn_per_section
            section_buttons = remaining_buttons[start_btn:end_btn]

            # Determine section height based on content
            content_length = len(' '.join([p.get('text', '') for p in section_paragraphs]))
            section_height = max(300, min(600, 200 + content_length // 2))

            new_section = {
                'index': section_idx,
                'type': section_type,
                'name': heading.get('text', f'Section {section_idx}')[:50],
                'title': heading.get('text', '')[:100],
                'subtitle': '',
                'content_text': ' '.join([p.get('text', '') for p in section_paragraphs])[:500],
                'button_text': section_buttons[0].get('text', '') if section_buttons else '',
                'y_position': current_y,
                'height': section_height,
                'width': 1920,
                **base_styles,
                'bg_color': section_bg,
                'title_font_size': heading.get('fontSize', 32),
                'title_color': heading.get('color', text_color),
            }

            # Copy button styling if available
            if section_buttons:
                new_section['button_bg_color'] = section_buttons[0].get('bgColor', accent_bg)
                new_section['button_text_color'] = section_buttons[0].get('textColor', 'rgba(255, 255, 255, 1)')

            new_sections.append(new_section)
            section_idx += 1
            current_y += section_height

        # FINAL SECTION: Footer
        footer_section = {
            'index': section_idx,
            'type': 10,
            'name': 'Footer',
            'title': 'Contact Us',
            'subtitle': '',
            'content_text': 'Get in touch with us today.',
            'y_position': current_y,
            'height': 200,
            'width': 1920,
            **base_styles,
            'bg_color': 'rgba(32, 48, 60, 1)',
            'text_color': 'rgba(200, 200, 200, 1)',
            'title_color': 'rgba(255, 255, 255, 1)',
        }
        new_sections.append(footer_section)

        # Replace sections with new split sections
        self.sections = new_sections

        print(f"   ✅ Dynamically created {len(self.sections)} sections from Wix content")

    async def associate_images_with_sections(self, context):
        """Associate downloaded images with their respective sections using position data"""
        import os

        # Use pre-collected image data with positions
        if not hasattr(self, 'all_images_data') or not self.all_images_data:
            return

        for idx, section in enumerate(self.sections):
            section_top = section.get('y_position', 0)
            section_bottom = section_top + section.get('height', 500)

            # Find images within this section's Y range
            images_in_section = []
            for img_data in self.all_images_data:
                img_y = img_data.get('y', 0)
                local_path = img_data.get('local_path', '')

                # Check if image overlaps with section
                if local_path and img_y >= section_top - 50 and img_y <= section_bottom + 50:
                    # Get actual file size to determine image importance
                    try:
                        file_size = os.path.getsize(local_path) if os.path.exists(local_path) else 0
                    except:
                        file_size = 0

                    images_in_section.append({
                        'local_path': local_path,
                        'y': img_y,
                        'file_size': file_size,
                        'display_width': img_data.get('display_width', 0),
                        'display_height': img_data.get('display_height', 0)
                    })

            # Sort by file size (largest first) to get the most prominent image
            images_in_section.sort(key=lambda x: x['file_size'], reverse=True)

            # For hero sections (first section or type 0), prefer the largest image
            if images_in_section:
                # Pick the largest image as the section image
                best_image = images_in_section[0]
                if best_image['file_size'] > 1000:  # Only use if > 1KB (not a tiny icon)
                    section['section_image'] = best_image['local_path']

                    # For hero sections, also set as background
                    if idx == 0 or section.get('type') == 0:
                        section['background_image'] = best_image['local_path']
                        section['use_bg_image'] = True

    async def download_images(self, page: Page, context=None):
        """IMPROVED: Download all images from the page with better lazy loading and srcset support"""
        # Use the provided context for finding images, or fall back to page
        search_context = context if context else page

        # Get all image URLs from the appropriate context
        images = await search_context.evaluate("""
            () => {
                const imgs = [];
                const seenUrls = new Set();

                function addImage(src, alt, rect, naturalWidth, naturalHeight, priority = 0) {
                    if (!src || src.startsWith('data:') || seenUrls.has(src)) return;
                    // Skip tiny placeholder images
                    if (src.includes('1x1') || src.includes('pixel') || src.includes('spacer')) return;
                    // Skip tracking pixels and icons
                    if (src.includes('tracking') || src.includes('analytics') || src.includes('favicon')) return;
                    seenUrls.add(src);
                    imgs.push({
                        src: src,
                        alt: alt || '',
                        width: naturalWidth || 0,
                        height: naturalHeight || 0,
                        x: rect ? rect.left + window.scrollX : 0,
                        y: rect ? rect.top + window.scrollY : 0,
                        display_width: rect ? rect.width : 0,
                        display_height: rect ? rect.height : 0,
                        priority: priority  // Higher priority = more important
                    });
                }

                // Helper to get best URL from srcset
                function getBestSrcFromSrcset(srcset) {
                    if (!srcset) return null;
                    const entries = srcset.split(',').map(s => {
                        const parts = s.trim().split(/\\s+/);
                        const url = parts[0];
                        let width = 0;
                        if (parts[1]) {
                            const match = parts[1].match(/(\\d+)w/);
                            if (match) width = parseInt(match[1]);
                        }
                        return { url, width };
                    });
                    // Sort by width descending and get the largest
                    entries.sort((a, b) => b.width - a.width);
                    return entries[0]?.url || entries[entries.length - 1]?.url;
                }

                // 1. Regular images with ALL lazy loading attributes
                document.querySelectorAll('img').forEach(img => {
                    const rect = img.getBoundingClientRect();
                    // Skip tiny images
                    if (rect.width < 20 || rect.height < 20) return;

                    // Priority: currentSrc > srcset (highest res) > src > data attributes
                    let bestSrc = img.currentSrc;

                    // Check srcset for higher resolution
                    const srcset = img.getAttribute('srcset');
                    if (srcset) {
                        const srcsetBest = getBestSrcFromSrcset(srcset);
                        if (srcsetBest) bestSrc = srcsetBest;
                    }

                    // Fallbacks for lazy loading
                    if (!bestSrc || bestSrc.includes('placeholder')) {
                        bestSrc = img.src ||
                                  img.getAttribute('data-src') ||
                                  img.getAttribute('data-lazy-src') ||
                                  img.getAttribute('data-original') ||
                                  img.getAttribute('data-pin-media') ||
                                  img.getAttribute('data-full-src') ||
                                  img.getAttribute('data-highres') ||
                                  img.getAttribute('data-srcset')?.split(',')[0]?.split(' ')[0];
                    }

                    // Calculate priority based on size and position
                    const priority = (rect.width * rect.height) / 1000 + (rect.y < 800 ? 100 : 0);
                    addImage(bestSrc, img.alt, rect, img.naturalWidth, img.naturalHeight, priority);
                });

                // 2. Picture elements - get highest quality source
                document.querySelectorAll('picture').forEach(picture => {
                    const rect = picture.getBoundingClientRect();
                    if (rect.width < 20 || rect.height < 20) return;

                    let bestSrc = null;
                    let maxWidth = 0;

                    // Check all source elements
                    picture.querySelectorAll('source').forEach(source => {
                        const srcset = source.getAttribute('srcset');
                        if (srcset) {
                            const srcsetBest = getBestSrcFromSrcset(srcset);
                            // Estimate width from srcset
                            const widthMatch = srcset.match(/(\\d+)w/);
                            const width = widthMatch ? parseInt(widthMatch[1]) : 0;
                            if (width > maxWidth || !bestSrc) {
                                bestSrc = srcsetBest;
                                maxWidth = width;
                            }
                        }
                    });

                    // Fallback to img inside picture
                    if (!bestSrc) {
                        const img = picture.querySelector('img');
                        if (img) bestSrc = img.currentSrc || img.src;
                    }

                    if (bestSrc) {
                        const priority = (rect.width * rect.height) / 1000 + 50;
                        addImage(bestSrc, '', rect, 0, 0, priority);
                    }
                });

                // 3. Wix-specific: WixImage components
                document.querySelectorAll('wix-image, [data-hook="imageViewer"], [data-hook="gallery-item-image"]').forEach(el => {
                    const rect = el.getBoundingClientRect();
                    if (rect.width < 20 || rect.height < 20) return;

                    const img = el.querySelector('img');
                    if (img) {
                        let src = img.currentSrc || img.src || img.getAttribute('data-src');
                        // Try to get higher resolution from srcset
                        const srcset = img.getAttribute('srcset');
                        if (srcset) {
                            const srcsetBest = getBestSrcFromSrcset(srcset);
                            if (srcsetBest) src = srcsetBest;
                        }
                        const priority = (rect.width * rect.height) / 1000 + 30;
                        addImage(src, img.alt, rect, img.naturalWidth, img.naturalHeight, priority);
                    }
                });

                // 4. Background images with position data
                document.querySelectorAll('*').forEach(el => {
                    const rect = el.getBoundingClientRect();
                    // Only check elements with significant size
                    if (rect.width < 100 || rect.height < 100) return;

                    const style = window.getComputedStyle(el);
                    const bg = style.backgroundImage;
                    if (bg && bg !== 'none' && bg.includes('url')) {
                        // Handle multiple backgrounds
                        const urls = bg.match(/url\\(['"]?([^'"\\)]+)['"]?\\)/g);
                        if (urls) {
                            urls.forEach(urlMatch => {
                                const url = urlMatch.match(/url\\(['"]?([^'"\\)]+)['"]?\\)/);
                                if (url && url[1] && !url[1].startsWith('data:')) {
                                    const priority = (rect.width * rect.height) / 2000;
                                    addImage(url[1], 'background', rect, 0, 0, priority);
                                }
                            });
                        }
                    }
                });

                // 5. Video posters (often high-quality images)
                document.querySelectorAll('video[poster]').forEach(video => {
                    const poster = video.getAttribute('poster');
                    if (poster) {
                        const rect = video.getBoundingClientRect();
                        addImage(poster, 'video poster', rect, 0, 0, 80);
                    }
                });

                // 6. SVG images (often logos)
                document.querySelectorAll('svg image, image[href]').forEach(img => {
                    const href = img.getAttribute('href') || img.getAttribute('xlink:href');
                    if (href && !href.startsWith('data:')) {
                        const rect = img.getBoundingClientRect();
                        addImage(href, 'svg image', rect, 0, 0, 20);
                    }
                });

                // 7. Wix-specific: Look for wixstatic.com URLs in any attribute
                document.querySelectorAll('[style*="wixstatic"], [data-src*="wixstatic"], [src*="wixstatic"]').forEach(el => {
                    const rect = el.getBoundingClientRect();
                    const attrs = ['style', 'data-src', 'src', 'data-pin-media', 'data-image-src'];
                    attrs.forEach(attr => {
                        const val = el.getAttribute(attr);
                        if (val && val.includes('wixstatic.com')) {
                            const urlMatch = val.match(/https?:\\/\\/[^\\s'"\\)]+wixstatic\\.com[^\\s'"\\)]*/);
                            if (urlMatch) {
                                addImage(urlMatch[0], '', rect, 0, 0, 40);
                            }
                        }
                    });
                });

                // 8. Object/embed elements (sometimes contain images)
                document.querySelectorAll('object[data], embed[src]').forEach(el => {
                    const src = el.getAttribute('data') || el.getAttribute('src');
                    if (src && (src.includes('.jpg') || src.includes('.png') || src.includes('.webp'))) {
                        const rect = el.getBoundingClientRect();
                        addImage(src, '', rect, 0, 0, 10);
                    }
                });

                // Sort by priority (highest first) to download most important images first
                imgs.sort((a, b) => b.priority - a.priority);

                return imgs;
            }
        """)

        print(f"   📥 Found {len(images)} images to download")

        # Download unique images (increased limit)
        unique_urls = list(set(img['src'] for img in images))
        self.downloaded_images = {}  # Store mapping of URL to local path
        self.all_images_data = []  # Store complete image data with positions

        # Create a mapping of URL to image data
        url_to_image_data = {img['src']: img for img in images}

        for idx, img_url in enumerate(unique_urls[:50]):  # Limit to 50 images for better quality
            try:
                # Use page.request to download (handles auth/cookies)
                response = await page.request.get(img_url)
                if response.ok:
                    img_data = await response.body()
                    # Determine file extension from content-type or URL
                    ext = 'jpg'
                    if 'png' in img_url.lower() or 'image/png' in response.headers.get('content-type', ''):
                        ext = 'png'
                    img_path = f"{self.images_dir}/img_{idx}.{ext}"
                    with open(img_path, 'wb') as f:
                        f.write(img_data)
                    self.downloaded_images[img_url] = img_path  # Store mapping

                    # Store complete image data with position for improvement functions
                    img_info = url_to_image_data.get(img_url, {})
                    self.all_images_data.append({
                        'src': img_url,
                        'local_path': img_path,
                        'x': img_info.get('x', 0),
                        'y': img_info.get('y', 0),
                        'width': img_info.get('display_width', img_info.get('width', 0)),
                        'height': img_info.get('display_height', img_info.get('height', 0)),
                        'alt': img_info.get('alt', '')
                    })

                    print(f"   ✅ Downloaded: {os.path.basename(img_path)}")
            except Exception as e:
                print(f"   ⚠️  Failed to download {img_url}: {e}")

    def analyze_screenshot_with_cv(self, screenshot_path: str) -> Dict[str, Any]:
        """Analyze screenshot using OpenCV for visual section detection"""
        print("\n   🎨 Analyzing screenshot with Computer Vision...")

        # Load screenshot
        img = cv2.imread(screenshot_path)
        if img is None:
            print("   ⚠️  Could not load screenshot for CV analysis")
            return {}

        height, width = img.shape[:2]
        print(f"   📐 Screenshot size: {width}×{height}px")

        # Detect visual boundaries
        contours_data = self.detect_visual_boundaries(img)
        print(f"   📦 Found {len(contours_data['boxes'])} visual boxes")

        # Analyze spacing patterns
        spacing_data = self.analyze_spacing_patterns(contours_data['boxes'], height)
        print(f"   📏 Detected grid base unit: {spacing_data['base_unit']}px")

        # Detect visual section boundaries
        visual_sections = self.detect_visual_sections(img, spacing_data)
        print(f"   🔍 Detected {len(visual_sections)} visual sections")

        return {
            'contours': contours_data,
            'spacing': spacing_data,
            'visual_sections': visual_sections,
            'image_size': {'width': width, 'height': height}
        }

    def detect_visual_boundaries(self, img: np.ndarray) -> Dict[str, Any]:
        """Detect UI elements using edge detection and contour finding"""
        gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

        # Apply Gaussian blur to reduce noise
        blurred = cv2.GaussianBlur(gray, (5, 5), 0)

        # Edge detection with Canny
        edges = cv2.Canny(blurred, 30, 100)

        # Morphological operations to connect nearby edges
        kernel = np.ones((3, 3), np.uint8)
        dilated = cv2.dilate(edges, kernel, iterations=2)

        # Find contours
        contours, hierarchy = cv2.findContours(dilated, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)

        # Filter and analyze contours
        boxes = []
        for contour in contours:
            x, y, w, h = cv2.boundingRect(contour)
            area = w * h

            # Filter out very small or very large boxes
            if area < 1000 or area > (img.shape[0] * img.shape[1] * 0.8):
                continue

            # Calculate aspect ratio
            aspect_ratio = w / h if h > 0 else 0

            # Check if it's a potential UI element
            # Buttons/cards are typically wider than tall or roughly square
            if 0.3 <= aspect_ratio <= 8.0 and h >= 20:
                boxes.append({
                    'x': x,
                    'y': y,
                    'width': w,
                    'height': h,
                    'area': area,
                    'aspect_ratio': aspect_ratio
                })

        # Sort by y position
        boxes.sort(key=lambda b: b['y'])

        return {
            'boxes': boxes,
            'total_contours': len(contours),
            'filtered_boxes': len(boxes)
        }

    def analyze_spacing_patterns(self, boxes: List[Dict], page_height: int) -> Dict[str, Any]:
        """Analyze vertical spacing to detect grid system"""
        if len(boxes) < 2:
            return {'base_unit': 8, 'common_spacings': [], 'rhythm': 'unknown'}

        # Calculate vertical gaps between boxes
        vertical_gaps = []
        for i in range(len(boxes) - 1):
            box1_bottom = boxes[i]['y'] + boxes[i]['height']
            box2_top = boxes[i + 1]['y']
            gap = box2_top - box1_bottom

            # Only consider positive gaps between 4px and 200px
            if 4 <= gap <= 200:
                vertical_gaps.append(gap)

        if not vertical_gaps:
            return {'base_unit': 8, 'common_spacings': [], 'rhythm': 'unknown'}

        # Find the greatest common divisor (GCD) of spacing values
        # This reveals the base grid unit
        def gcd(a, b):
            while b:
                a, b = b, a % b
            return a

        def gcd_list(numbers):
            if not numbers:
                return 8
            result = numbers[0]
            for num in numbers[1:]:
                result = gcd(result, int(num))
                if result == 1:
                    break
            return result if result >= 4 else 8

        # Round gaps to nearest 4px to reduce noise
        rounded_gaps = [round(gap / 4) * 4 for gap in vertical_gaps]

        # Find base unit (should be 4, 8, or 16 typically)
        base_unit = gcd_list([g for g in rounded_gaps if g >= 8])

        # Clamp to reasonable values
        if base_unit < 4:
            base_unit = 4
        elif base_unit > 16:
            base_unit = 16

        # Find most common spacing values
        spacing_counts = {}
        for gap in rounded_gaps:
            spacing_counts[gap] = spacing_counts.get(gap, 0) + 1

        common_spacings = sorted(spacing_counts.items(), key=lambda x: x[1], reverse=True)[:5]

        return {
            'base_unit': base_unit,
            'common_spacings': [s[0] for s in common_spacings],
            'total_gaps_analyzed': len(vertical_gaps),
            'rhythm': 'consistent' if len(set(rounded_gaps)) <= 10 else 'variable'
        }

    def detect_visual_sections(self, img: np.ndarray, spacing_data: Dict) -> List[Dict]:
        """Detect section boundaries using visual analysis"""
        height, width = img.shape[:2]

        # Convert to grayscale
        gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

        # Calculate horizontal projection (sum of pixel intensities per row)
        # Areas with content will have higher variance
        projection = []
        step = 10  # Analyze every 10 pixels for speed

        for y in range(0, height, step):
            if y + step <= height:
                row_slice = gray[y:y+step, :]
                variance = np.var(row_slice)
                projection.append({'y': y, 'variance': variance})

        # Find boundaries: large gaps in content (low variance areas)
        base_unit = spacing_data.get('base_unit', 8)
        boundary_threshold = np.percentile([p['variance'] for p in projection], 20)

        boundaries = []
        in_gap = False
        gap_start = 0

        for i, p in enumerate(projection):
            if p['variance'] < boundary_threshold:
                if not in_gap:
                    gap_start = p['y']
                    in_gap = True
            else:
                if in_gap and (p['y'] - gap_start) >= base_unit * 5:  # At least 40-80px gap
                    boundaries.append(gap_start + (p['y'] - gap_start) // 2)
                in_gap = False

        # Create sections from boundaries
        visual_sections = []
        boundaries = [0] + boundaries + [height]

        for i in range(len(boundaries) - 1):
            section_y = boundaries[i]
            section_height = boundaries[i + 1] - boundaries[i]

            # Skip very small sections
            if section_height < 100:
                continue

            visual_sections.append({
                'y_position': section_y,
                'height': section_height,
                'visual_boundary': True
            })

        return visual_sections

    def enhance_sections_with_cv(self, cv_data: Dict):
        """Enhance DOM-detected sections with CV analysis"""
        if not cv_data or 'visual_sections' not in cv_data:
            return

        print("\n   🔧 Enhancing sections with Computer Vision data...")

        visual_sections = cv_data['visual_sections']
        spacing_data = cv_data.get('spacing', {})
        base_unit = spacing_data.get('base_unit', 8)

        # Match DOM sections to visual boundaries
        for section in self.sections:
            dom_y = section['y_position']
            dom_height = section['height']

            # Find closest visual section
            closest_visual = None
            min_distance = float('inf')

            for visual in visual_sections:
                visual_y = visual['y_position']
                distance = abs(visual_y - dom_y)

                if distance < min_distance and distance < 100:  # Within 100px
                    min_distance = distance
                    closest_visual = visual

            # If we found a matching visual section, use its boundaries
            if closest_visual:
                # Use visual height if it's significantly different
                visual_height = closest_visual['height']
                if abs(visual_height - dom_height) > 50:
                    section['visual_height'] = visual_height
                    section['cv_adjusted'] = True

        # Update grid system with CV-detected base unit
        if hasattr(self, 'grid_system'):
            self.grid_system['cv_base_unit'] = base_unit
            self.grid_system['cv_verified'] = True

        print(f"   ✅ Sections enhanced with CV data (base unit: {base_unit}px)")

    def generate_template_data(self) -> Dict[str, Any]:
        """Generate final template data"""
        # FINAL SORT: Ensure sections are in correct visual order by y_position
        self.sections.sort(key=lambda s: s['y_position'])
        print(f"\n✅ Sections sorted by y_position (final order verified)")

        # Re-index after final sort
        for idx, section in enumerate(self.sections):
            section['index'] = idx

        # ===================================================================
        # APPLY COMPREHENSIVE IMPROVEMENTS (All 4 Phases)
        # ===================================================================
        print(f"\n🔧 Applying scraper improvements (4 phases)...")
        try:
            from scraper_improvements import improve_scraped_data

            # Use the collected images data with positions
            all_images = getattr(self, 'all_images_data', [])
            print(f"   📸 Processing {len(all_images)} images with position data")

            # Apply improvements
            self.sections = improve_scraped_data(self.sections, all_images)
            print(f"   ✅ Improvements applied successfully!")
        except Exception as e:
            print(f"   ⚠️  Could not apply improvements: {e}")
            import traceback
            traceback.print_exc()
            # Continue without improvements

        return {
            'template_name': self.template_name,
            'url': self.url,
            'scraped_date': datetime.now().isoformat(),
            'sections': self.sections,
            'responsive_layouts': self.responsive_layouts,
            'typography_system': self.typography_system,
            'grid_system': self.grid_system,
            'forms': self.forms,
            'social_links': self.social_links,
            'seo_data': self.seo_data,
            'custom_fonts': self.custom_fonts,
            'advanced_css': self.advanced_css
        }


def main():
    """Test the scraper"""
    import sys

    if len(sys.argv) < 2:
        print("Usage: python web_scraper_playwright.py <url> [template_name]")
        sys.exit(1)

    url = sys.argv[1]
    template_name = sys.argv[2] if len(sys.argv) > 2 else None

    scraper = PlaywrightWebsiteScraper(url, template_name)
    template_data = scraper.scrape_website()

    # Save to JSON
    json_file = f"scraped_{scraper.template_name}.json"
    with open(json_file, 'w') as f:
        json.dump(template_data, f, indent=2)

    print(f"\n✅ Template data saved to: {json_file}")


if __name__ == '__main__':
    main()
