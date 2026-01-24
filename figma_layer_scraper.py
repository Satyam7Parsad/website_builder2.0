#!/usr/bin/env python3
"""
Figma-style Layer Extractor
Extracts every visible element from a webpage with exact positions for pixel-perfect recreation.

This creates a layer-based representation similar to Figma/Sketch where each element
is positioned absolutely on a canvas.
"""

import os
import sys
import json
import asyncio
from urllib.parse import urljoin, urlparse
from playwright.async_api import async_playwright
from playwright_stealth import Stealth

class FigmaLayerScraper:
    """Extract all visible elements as positioned layers"""

    def __init__(self, url: str, output_dir: str = "figma_export"):
        self.url = url
        self.output_dir = output_dir
        self.layers = []
        self.next_layer_id = 1
        self.canvas_width = 1920
        self.canvas_height = 0
        self.screenshot_path = ""

        os.makedirs(output_dir, exist_ok=True)
        os.makedirs(f"{output_dir}/images", exist_ok=True)

    async def extract_layers(self) -> dict:
        """Main extraction method"""
        print(f"\n{'='*60}")
        print(f"  FIGMA-STYLE LAYER EXTRACTOR")
        print(f"{'='*60}")
        print(f"\n🌐 URL: {self.url}\n")

        async with async_playwright() as p:
            # Launch browser
            print("1️⃣  Launching browser...")
            browser = await p.chromium.launch(
                headless=True,
                args=['--no-sandbox', '--disable-dev-shm-usage']
            )

            context = await browser.new_context(
                viewport={'width': 1920, 'height': 1080},
                user_agent='Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36'
            )

            page = await context.new_page()

            # Apply stealth
            stealth = Stealth()
            await stealth.apply_stealth_async(page)

            try:
                # Navigate
                print("2️⃣  Loading page...")
                try:
                    await page.goto(self.url, wait_until='networkidle', timeout=60000)
                except:
                    await page.goto(self.url, wait_until='load', timeout=60000)

                # Handle Wix iframe
                working_context = page
                if 'wix.com/website-template/view' in self.url:
                    print("   🔄 Wix template detected, looking for iframe...")
                    await page.wait_for_timeout(3000)
                    frames = page.frames
                    for frame in frames:
                        if frame.url and frame.url != self.url:
                            try:
                                content_len = await frame.evaluate("document.body.innerHTML.length")
                                if content_len > 5000:
                                    working_context = frame
                                    print(f"   ✓ Using iframe: {frame.url[:50]}...")
                                    break
                            except:
                                continue

                # Wait for content
                print("3️⃣  Waiting for content to render...")
                await page.wait_for_timeout(3000)

                # Scroll to load lazy content
                print("4️⃣  Scrolling to load lazy content...")
                await self._scroll_page(working_context)
                await page.wait_for_timeout(2000)

                # Take full-page screenshot
                print("5️⃣  Taking full-page screenshot...")
                self.screenshot_path = f"{self.output_dir}/screenshot.png"
                await page.screenshot(path=self.screenshot_path, full_page=True)
                print(f"   📸 Screenshot saved: {self.screenshot_path}")

                # Get page dimensions
                page_info = await working_context.evaluate("""
                    () => ({
                        width: Math.max(document.body.scrollWidth, document.documentElement.scrollWidth),
                        height: Math.max(document.body.scrollHeight, document.documentElement.scrollHeight),
                        bgColor: window.getComputedStyle(document.body).backgroundColor
                    })
                """)
                self.canvas_width = page_info['width']
                self.canvas_height = page_info['height']
                print(f"   📐 Canvas size: {self.canvas_width} x {self.canvas_height}")

                # Extract all visible elements
                print("6️⃣  Extracting all visible elements as layers...")
                raw_layers = await self._extract_all_elements(working_context)
                print(f"   📦 Found {len(raw_layers)} raw elements")

                # Filter and process layers
                print("7️⃣  Processing and filtering layers...")
                self.layers = self._process_layers(raw_layers)
                print(f"   ✓ Processed {len(self.layers)} layers")

                # Download images
                print("8️⃣  Downloading images...")
                await self._download_images(page)

                # Generate output
                print("9️⃣  Generating output...")
                output = self._generate_output()

                # Save JSON
                json_path = f"{self.output_dir}/layers.json"
                with open(json_path, 'w') as f:
                    json.dump(output, f, indent=2)
                print(f"   💾 Saved: {json_path}")

                print(f"\n✅ Extraction complete!")
                print(f"   📊 Total layers: {len(self.layers)}")
                print(f"   📁 Output directory: {self.output_dir}")

                return output

            except Exception as e:
                print(f"\n❌ Error: {e}")
                import traceback
                traceback.print_exc()
                raise
            finally:
                await browser.close()

    async def _scroll_page(self, context):
        """Scroll page to trigger lazy loading"""
        await context.evaluate("""
            async () => {
                const delay = ms => new Promise(resolve => setTimeout(resolve, ms));
                const height = document.body.scrollHeight;
                for (let y = 0; y < height; y += 300) {
                    window.scrollTo(0, y);
                    await delay(100);
                }
                window.scrollTo(0, 0);
            }
        """)

    async def _extract_all_elements(self, context) -> list:
        """Extract all visible elements with their properties"""
        return await context.evaluate("""
            () => {
                const layers = [];
                const seenRects = new Set();

                // Helper to check if color is visible (not transparent)
                function isVisibleColor(color) {
                    if (!color) return false;
                    if (color === 'rgba(0, 0, 0, 0)' || color === 'transparent') return false;
                    return true;
                }

                // Helper to get unique rect key
                function getRectKey(rect) {
                    return `${Math.round(rect.x)},${Math.round(rect.y)},${Math.round(rect.width)},${Math.round(rect.height)}`;
                }

                // Process each element
                function processElement(el, depth = 0) {
                    if (depth > 20) return; // Prevent too deep recursion

                    const rect = el.getBoundingClientRect();
                    const style = window.getComputedStyle(el);

                    // Skip invisible elements
                    if (style.display === 'none' || style.visibility === 'hidden') return;
                    if (rect.width < 5 || rect.height < 5) return;
                    if (style.opacity === '0') return;

                    // Get absolute position
                    const x = rect.left + window.scrollX;
                    const y = rect.top + window.scrollY;

                    // Skip elements outside viewport (negative positions)
                    if (x < -100 || y < -100) return;

                    // Check if this rect was already processed (dedup)
                    const rectKey = getRectKey({x, y, width: rect.width, height: rect.height});

                    // Determine layer type
                    let layerType = 'div';
                    let text = '';
                    let imageSrc = '';

                    const tagName = el.tagName.toLowerCase();

                    // Text elements
                    if (['h1','h2','h3','h4','h5','h6','p','span','a','label','li'].includes(tagName)) {
                        // Only get direct text content
                        const directText = Array.from(el.childNodes)
                            .filter(n => n.nodeType === Node.TEXT_NODE)
                            .map(n => n.textContent.trim())
                            .join(' ').trim();

                        if (directText.length > 0 && directText.length < 500) {
                            layerType = 'text';
                            text = directText;
                        }
                    }

                    // Image elements
                    if (tagName === 'img') {
                        layerType = 'image';
                        imageSrc = el.currentSrc || el.src || el.dataset.src || '';
                    }

                    // Button elements
                    let isDisabled = false;
                    let buttonType = 'button';
                    let dataTarget = '';
                    let formId = '';

                    if (tagName === 'button' || (tagName === 'a' && (
                        el.className.includes('btn') ||
                        el.className.includes('button') ||
                        isVisibleColor(style.backgroundColor)
                    ))) {
                        layerType = 'button';
                        text = el.textContent.trim().substring(0, 100);

                        // Extract button-specific attributes
                        isDisabled = el.disabled || el.hasAttribute('disabled') || el.classList.contains('disabled');
                        buttonType = el.type || 'button';  // submit, reset, button
                        dataTarget = el.getAttribute('data-target') || el.getAttribute('data-bs-target') || '';
                        formId = el.getAttribute('form') || '';
                    }

                    // Extract onclick and determine action type
                    let onclickAction = el.getAttribute('onclick') || '';
                    let actionType = 'none';
                    const href = el.href || '';

                    if (href && href.startsWith('http')) {
                        actionType = 'link';
                    } else if (href && href.startsWith('#')) {
                        actionType = 'scroll';
                    } else if (href && href.startsWith('mailto:')) {
                        actionType = 'email';
                    } else if (href && href.startsWith('tel:')) {
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
                    } else if (layerType === 'button') {
                        actionType = 'button';
                    }

                    // Input elements
                    if (['input', 'textarea', 'select'].includes(tagName)) {
                        layerType = 'input';
                        text = el.placeholder || el.value || '';
                    }

                    // Background image check
                    const bgImage = style.backgroundImage;
                    if (bgImage && bgImage !== 'none' && bgImage.includes('url')) {
                        const urlMatch = bgImage.match(/url\\(['"]?([^'"\\)]+)['"]?\\)/);
                        if (urlMatch && urlMatch[1] && !urlMatch[1].startsWith('data:')) {
                            if (layerType === 'div') {
                                layerType = 'image';
                                imageSrc = urlMatch[1];
                            }
                        }
                    }

                    // Check if element has visible content or background
                    const hasVisibleBg = isVisibleColor(style.backgroundColor);
                    const hasBorder = parseFloat(style.borderWidth) > 0 && style.borderStyle !== 'none';
                    const hasImage = imageSrc.length > 0;
                    const hasText = text.length > 0;
                    const hasShadow = style.boxShadow && style.boxShadow !== 'none';

                    // Only add if element has something visible
                    if (hasVisibleBg || hasBorder || hasImage || hasText || hasShadow) {
                        // Skip if already have this exact rect (keep first one)
                        if (!seenRects.has(rectKey) || hasText || hasImage) {
                            seenRects.add(rectKey);

                            layers.push({
                                type: layerType,
                                tagName: tagName,
                                className: el.className || '',
                                id: el.id || '',
                                x: Math.round(x),
                                y: Math.round(y),
                                width: Math.round(rect.width),
                                height: Math.round(rect.height),
                                zIndex: parseInt(style.zIndex) || 0,
                                text: text,
                                imageSrc: imageSrc,
                                href: href,
                                onclick: onclickAction,
                                actionType: actionType,
                                // Button-specific properties
                                disabled: isDisabled,
                                buttonType: buttonType,
                                dataTarget: dataTarget,
                                formId: formId,
                                // Colors
                                bgColor: style.backgroundColor,
                                textColor: style.color,
                                borderColor: style.borderColor,
                                // Typography
                                fontSize: parseFloat(style.fontSize) || 16,
                                fontWeight: parseInt(style.fontWeight) || 400,
                                fontFamily: style.fontFamily,
                                textAlign: style.textAlign,
                                lineHeight: style.lineHeight,
                                letterSpacing: style.letterSpacing,
                                // Box model
                                paddingTop: parseFloat(style.paddingTop) || 0,
                                paddingRight: parseFloat(style.paddingRight) || 0,
                                paddingBottom: parseFloat(style.paddingBottom) || 0,
                                paddingLeft: parseFloat(style.paddingLeft) || 0,
                                // Border
                                borderWidth: parseFloat(style.borderWidth) || 0,
                                borderRadius: style.borderRadius,
                                borderStyle: style.borderStyle,
                                // Effects
                                opacity: parseFloat(style.opacity) || 1,
                                boxShadow: style.boxShadow,
                                // Gradient
                                backgroundImage: bgImage !== 'none' ? bgImage : ''
                            });
                        }
                    }

                    // Process children
                    for (const child of el.children) {
                        processElement(child, depth + 1);
                    }
                }

                // Start from body
                processElement(document.body);

                // Sort by z-index and y position
                layers.sort((a, b) => {
                    if (a.zIndex !== b.zIndex) return a.zIndex - b.zIndex;
                    return a.y - b.y;
                });

                return layers;
            }
        """)

    def _process_layers(self, raw_layers: list) -> list:
        """Process and filter raw layers"""
        processed = []
        used_ids = set()

        for raw in raw_layers:
            # Skip very small elements
            if raw['width'] < 10 or raw['height'] < 10:
                continue

            # Map type
            type_map = {
                'text': 'LAYER_TEXT',
                'image': 'LAYER_IMAGE',
                'button': 'LAYER_BUTTON',
                'input': 'LAYER_INPUT',
                'div': 'LAYER_DIV'
            }

            layer_type = type_map.get(raw['type'], 'LAYER_DIV')

            # Generate name
            if raw['text']:
                name = raw['text'][:30]
            elif raw['tagName']:
                name = f"{raw['tagName']}_{self.next_layer_id}"
            else:
                name = f"Layer_{self.next_layer_id}"

            # Parse border radius
            border_radius = 0
            if raw.get('borderRadius'):
                br = raw['borderRadius'].replace('px', '').split()[0]
                try:
                    border_radius = float(br)
                except:
                    pass

            layer = {
                'id': self.next_layer_id,
                'type': layer_type,
                'name': name,
                'element_id': raw.get('id', ''),  # HTML element ID for scroll targets
                'x': raw['x'],
                'y': raw['y'],
                'width': raw['width'],
                'height': raw['height'],
                'z_index': raw.get('zIndex', 0),
                'text': raw.get('text', ''),
                'image_path': raw.get('imageSrc', ''),
                'href': raw.get('href', ''),
                'onclick_action': raw.get('onclick', ''),
                'action_type': raw.get('actionType', 'none'),
                # Button-specific properties
                'disabled': raw.get('disabled', False),
                'button_type': raw.get('buttonType', 'button'),
                'data_target': raw.get('dataTarget', ''),
                'form_id': raw.get('formId', ''),
                'bg_color': raw.get('bgColor', 'rgba(0,0,0,0)'),
                'text_color': raw.get('textColor', 'rgb(0,0,0)'),
                'border_color': raw.get('borderColor', 'rgb(0,0,0)'),
                'font_size': raw.get('fontSize', 16),
                'font_weight': raw.get('fontWeight', 400),
                'font_family': raw.get('fontFamily', 'system-ui'),
                'text_align': raw.get('textAlign', 'left'),
                'line_height': raw.get('lineHeight', 'normal'),
                'letter_spacing': raw.get('letterSpacing', 'normal'),
                'padding_top': raw.get('paddingTop', 0),
                'padding_right': raw.get('paddingRight', 0),
                'padding_bottom': raw.get('paddingBottom', 0),
                'padding_left': raw.get('paddingLeft', 0),
                'border_width': raw.get('borderWidth', 0),
                'border_radius': border_radius,
                'border_style': raw.get('borderStyle', 'none'),
                'opacity': raw.get('opacity', 1),
                'box_shadow': raw.get('boxShadow', 'none'),
                'background_image': raw.get('backgroundImage', '')
            }

            processed.append(layer)
            self.next_layer_id += 1

        return processed

    async def _download_images(self, page):
        """Download all images referenced by layers"""
        image_urls = set()
        for layer in self.layers:
            if layer['image_path'] and not layer['image_path'].startswith('data:'):
                image_urls.add(layer['image_path'])

        print(f"   📥 Downloading {len(image_urls)} images...")

        for idx, url in enumerate(list(image_urls)[:50]):  # Limit to 50
            try:
                response = await page.request.get(url)
                if response.ok:
                    data = await response.body()
                    ext = 'jpg'
                    if 'png' in url.lower() or 'image/png' in response.headers.get('content-type', ''):
                        ext = 'png'
                    elif 'webp' in url.lower():
                        ext = 'webp'

                    local_path = f"{self.output_dir}/images/img_{idx}.{ext}"
                    with open(local_path, 'wb') as f:
                        f.write(data)

                    # Update layer image paths
                    for layer in self.layers:
                        if layer['image_path'] == url:
                            layer['image_path'] = local_path

                    print(f"      ✓ {os.path.basename(local_path)}")
            except Exception as e:
                print(f"      ⚠️ Failed: {url[:50]}... ({e})")

    def _generate_output(self) -> dict:
        """Generate final output structure"""
        return {
            'project': {
                'name': urlparse(self.url).netloc,
                'source_url': self.url,
                'canvas_width': self.canvas_width,
                'canvas_height': self.canvas_height,
                'screenshot_path': self.screenshot_path,
                'layer_count': len(self.layers)
            },
            'layers': self.layers
        }


def main():
    if len(sys.argv) < 2:
        print("Usage: python figma_layer_scraper.py <url> [output_dir]")
        sys.exit(1)

    url = sys.argv[1]
    output_dir = sys.argv[2] if len(sys.argv) > 2 else "figma_export"

    scraper = FigmaLayerScraper(url, output_dir)
    result = asyncio.run(scraper.extract_layers())

    # Print summary
    print(f"\n{'='*60}")
    print(f"  LAYER SUMMARY")
    print(f"{'='*60}")

    type_counts = {}
    for layer in result['layers']:
        t = layer['type']
        type_counts[t] = type_counts.get(t, 0) + 1

    for t, count in sorted(type_counts.items()):
        print(f"  {t}: {count}")


if __name__ == "__main__":
    main()
