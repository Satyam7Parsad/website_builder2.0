#!/usr/bin/env python3
"""
Figma API Import Script
=======================
Imports designs directly from Figma using the Figma REST API.

Usage:
    python3 figma_api_import.py <API_TOKEN> <FILE_KEY> <OUTPUT_DIR>

Example:
    python3 figma_api_import.py "figd_xxxxx" "ABC123xyz" "/tmp/figma_import"
"""

import sys
import os
import json
import requests
from urllib.parse import urlparse
import re
import time

# Figma API Base URL
FIGMA_API_BASE = "https://api.figma.com/v1"

# Retry settings
MAX_RETRIES = 5
INITIAL_DELAY = 5  # seconds

class FigmaAPIImport:
    def __init__(self, api_token, file_key, output_dir):
        self.api_token = api_token
        self.file_key = file_key
        self.output_dir = output_dir
        self.headers = {
            "X-Figma-Token": api_token
        }
        self.layers = []
        self.images = {}
        self.canvas_width = 1920
        self.canvas_height = 1080
        self.file_name = "Figma Design"

        # Create output directories
        os.makedirs(output_dir, exist_ok=True)
        os.makedirs(f"{output_dir}/images", exist_ok=True)

    def extract_file_key(self, url_or_key):
        """Extract file key from Figma URL or return as-is if already a key"""
        # If it's a URL like https://www.figma.com/file/ABC123/DesignName
        if 'figma.com' in url_or_key:
            match = re.search(r'figma\.com/(?:file|design)/([a-zA-Z0-9]+)', url_or_key)
            if match:
                return match.group(1)
        # Already a key
        return url_or_key

    def api_request_with_retry(self, url, params=None):
        """Make an API request with exponential backoff retry for rate limits"""
        delay = INITIAL_DELAY

        for attempt in range(MAX_RETRIES):
            response = requests.get(url, headers=self.headers, params=params)

            if response.status_code == 200:
                return response
            elif response.status_code == 429:  # Rate limit
                if attempt < MAX_RETRIES - 1:
                    print(f"   ⏳ Rate limited, waiting {delay}s (attempt {attempt + 1}/{MAX_RETRIES})...")
                    time.sleep(delay)
                    delay *= 2  # Exponential backoff
                else:
                    raise Exception(f"Rate limit exceeded after {MAX_RETRIES} retries")
            else:
                # Other error, don't retry
                error_msg = 'Unknown error'
                try:
                    error_msg = response.json().get('err', 'Unknown error')
                except:
                    pass
                raise Exception(f"Figma API Error: {error_msg} (Status: {response.status_code})")

        return response

    def fetch_file(self):
        """Fetch the Figma file data"""
        print(f"1️⃣  Fetching Figma file: {self.file_key}")

        url = f"{FIGMA_API_BASE}/files/{self.file_key}"
        response = self.api_request_with_retry(url)

        data = response.json()
        self.file_name = data.get('name', 'Figma Design')
        print(f"   📄 File: {self.file_name}")

        return data

    def fetch_images(self, node_ids):
        """Fetch rendered images for nodes"""
        if not node_ids:
            return {}

        print(f"2️⃣  Fetching {len(node_ids)} images from Figma...")

        # Figma API accepts comma-separated node IDs
        ids_param = ",".join(node_ids[:50])  # Limit to 50 images

        url = f"{FIGMA_API_BASE}/images/{self.file_key}"
        params = {
            "ids": ids_param,
            "format": "png",
            "scale": 2
        }

        try:
            response = self.api_request_with_retry(url, params)
            data = response.json()
            return data.get('images', {})
        except Exception as e:
            print(f"   ⚠️ Warning: Could not fetch images - {str(e)}")
            return {}

    def download_image(self, url, filename):
        """Download an image from URL"""
        try:
            response = requests.get(url, timeout=30)
            if response.status_code == 200:
                filepath = f"{self.output_dir}/images/{filename}"
                with open(filepath, 'wb') as f:
                    f.write(response.content)
                return filepath
        except Exception as e:
            print(f"   ⚠️ Failed to download: {filename}")
        return None

    def rgba_to_css(self, color):
        """Convert Figma color object to CSS rgba string"""
        if not color:
            return "rgba(0,0,0,0)"
        r = int(color.get('r', 0) * 255)
        g = int(color.get('g', 0) * 255)
        b = int(color.get('b', 0) * 255)
        a = color.get('a', 1)
        return f"rgba({r},{g},{b},{a})"

    def process_node(self, node, parent_x=0, parent_y=0, depth=0):
        """Recursively process Figma nodes into layers"""
        if depth > 20:
            return

        node_type = node.get('type', '')
        node_id = node.get('id', '')
        name = node.get('name', 'Unnamed')

        # Get absolute bounding box
        abs_bbox = node.get('absoluteBoundingBox', {})
        x = abs_bbox.get('x', 0)
        y = abs_bbox.get('y', 0)
        width = abs_bbox.get('width', 0)
        height = abs_bbox.get('height', 0)

        # Skip tiny or invalid elements
        if width < 2 or height < 2:
            return

        # Determine layer type
        layer_type = "LAYER_DIV"
        text_content = ""
        image_path = ""

        if node_type == 'TEXT':
            layer_type = "LAYER_TEXT"
            text_content = node.get('characters', '')
        elif node_type in ['RECTANGLE', 'ELLIPSE', 'POLYGON', 'STAR', 'LINE', 'VECTOR']:
            # Check if it has image fill
            fills = node.get('fills', [])
            for fill in fills:
                if fill.get('type') == 'IMAGE':
                    layer_type = "LAYER_IMAGE"
                    break
            else:
                layer_type = "LAYER_DIV"
        elif node_type == 'FRAME' or node_type == 'GROUP' or node_type == 'COMPONENT':
            layer_type = "LAYER_DIV"
        elif node_type == 'INSTANCE':
            # Component instance - check if it looks like a button
            if 'button' in name.lower() or 'btn' in name.lower():
                layer_type = "LAYER_BUTTON"
                text_content = name
            else:
                layer_type = "LAYER_DIV"

        # Extract colors
        bg_color = "rgba(0,0,0,0)"
        text_color = "rgba(0,0,0,255)"
        border_color = "rgba(0,0,0,0)"

        fills = node.get('fills', [])
        for fill in fills:
            if fill.get('visible', True) and fill.get('type') == 'SOLID':
                bg_color = self.rgba_to_css(fill.get('color'))
                break

        strokes = node.get('strokes', [])
        for stroke in strokes:
            if stroke.get('visible', True) and stroke.get('type') == 'SOLID':
                border_color = self.rgba_to_css(stroke.get('color'))
                break

        # Text style - enhanced
        font_size = 16
        font_weight = 400
        font_family = "system-ui"
        font_style = "normal"  # normal, italic
        text_align = "left"  # left, center, right, justify
        letter_spacing = 0
        line_height = 1.2
        text_decoration = "none"  # none, underline, line-through

        if node_type == 'TEXT':
            style = node.get('style', {})
            font_size = style.get('fontSize', 16)
            font_weight = style.get('fontWeight', 400)

            # Font family
            font_family = style.get('fontFamily', 'system-ui')

            # Font style (italic)
            font_style = "italic" if style.get('italic', False) else "normal"

            # Text alignment
            text_align_horizontal = style.get('textAlignHorizontal', 'LEFT')
            if text_align_horizontal == 'CENTER':
                text_align = "center"
            elif text_align_horizontal == 'RIGHT':
                text_align = "right"
            elif text_align_horizontal == 'JUSTIFIED':
                text_align = "justify"
            else:
                text_align = "left"

            # Letter spacing (Figma uses pixels, can be negative)
            letter_spacing = style.get('letterSpacing', 0)

            # Line height
            line_height_obj = style.get('lineHeightPx', 0)
            if line_height_obj and font_size > 0:
                line_height = line_height_obj / font_size
            else:
                line_height_unit = style.get('lineHeightUnit', 'AUTO')
                if line_height_unit == 'PIXELS':
                    line_height = style.get('lineHeightPx', font_size * 1.2) / font_size
                elif line_height_unit == 'PERCENT':
                    line_height = style.get('lineHeightPercent', 120) / 100
                else:
                    line_height = 1.2

            # Text decoration
            text_decoration_val = style.get('textDecoration', 'NONE')
            if text_decoration_val == 'UNDERLINE':
                text_decoration = "underline"
            elif text_decoration_val == 'STRIKETHROUGH':
                text_decoration = "line-through"
            else:
                text_decoration = "none"

            # Get text color from fills
            for fill in fills:
                if fill.get('visible', True) and fill.get('type') == 'SOLID':
                    text_color = self.rgba_to_css(fill.get('color'))
                    break

        # Border radius
        border_radius = 0
        corner_radius = node.get('cornerRadius', 0)
        if corner_radius:
            border_radius = corner_radius

        # Individual corner radii (if different)
        border_radius_tl = node.get('rectangleCornerRadii', [0,0,0,0])[0] if node.get('rectangleCornerRadii') else border_radius
        border_radius_tr = node.get('rectangleCornerRadii', [0,0,0,0])[1] if node.get('rectangleCornerRadii') else border_radius
        border_radius_br = node.get('rectangleCornerRadii', [0,0,0,0])[2] if node.get('rectangleCornerRadii') else border_radius
        border_radius_bl = node.get('rectangleCornerRadii', [0,0,0,0])[3] if node.get('rectangleCornerRadii') else border_radius

        # Opacity
        opacity = node.get('opacity', 1)

        # Box shadow (effects)
        box_shadow = "none"
        effects = node.get('effects', [])
        for effect in effects:
            if effect.get('visible', True) and effect.get('type') == 'DROP_SHADOW':
                shadow_color = effect.get('color', {})
                shadow_r = int(shadow_color.get('r', 0) * 255)
                shadow_g = int(shadow_color.get('g', 0) * 255)
                shadow_b = int(shadow_color.get('b', 0) * 255)
                shadow_a = shadow_color.get('a', 0.25)
                offset_x = effect.get('offset', {}).get('x', 0)
                offset_y = effect.get('offset', {}).get('y', 4)
                blur = effect.get('radius', 4)
                spread = effect.get('spread', 0)
                box_shadow = f"{offset_x}px {offset_y}px {blur}px {spread}px rgba({shadow_r},{shadow_g},{shadow_b},{shadow_a})"
                break
            elif effect.get('visible', True) and effect.get('type') == 'INNER_SHADOW':
                shadow_color = effect.get('color', {})
                shadow_r = int(shadow_color.get('r', 0) * 255)
                shadow_g = int(shadow_color.get('g', 0) * 255)
                shadow_b = int(shadow_color.get('b', 0) * 255)
                shadow_a = shadow_color.get('a', 0.25)
                offset_x = effect.get('offset', {}).get('x', 0)
                offset_y = effect.get('offset', {}).get('y', 4)
                blur = effect.get('radius', 4)
                box_shadow = f"inset {offset_x}px {offset_y}px {blur}px rgba({shadow_r},{shadow_g},{shadow_b},{shadow_a})"
                break

        # Create layer with enhanced styling
        layer = {
            "id": len(self.layers) + 1,
            "node_id": node_id,
            "type": layer_type,
            "name": name,
            "x": int(x),
            "y": int(y),
            "width": int(width),
            "height": int(height),
            "z_index": len(self.layers),
            "text": text_content,
            "image_path": image_path,
            "href": "",
            "bg_color": bg_color,
            "text_color": text_color,
            "border_color": border_color,
            # Font properties
            "font_size": font_size,
            "font_weight": font_weight,
            "font_family": font_family,
            "font_style": font_style,
            # Text properties
            "text_align": text_align,
            "letter_spacing": letter_spacing,
            "line_height": line_height,
            "text_decoration": text_decoration,
            # Border properties
            "border_width": node.get('strokeWeight', 0),
            "border_radius": border_radius,
            "border_radius_tl": border_radius_tl,
            "border_radius_tr": border_radius_tr,
            "border_radius_br": border_radius_br,
            "border_radius_bl": border_radius_bl,
            # Other properties
            "opacity": opacity,
            "box_shadow": box_shadow,
            "visible": node.get('visible', True)
        }

        # Track image nodes for later fetching
        if layer_type == "LAYER_IMAGE" or (node_type in ['FRAME', 'RECTANGLE'] and fills):
            for fill in fills:
                if fill.get('type') == 'IMAGE':
                    self.images[node_id] = layer
                    layer["type"] = "LAYER_IMAGE"
                    break

        self.layers.append(layer)

        # Update canvas bounds
        if x + width > self.canvas_width:
            self.canvas_width = int(x + width)
        if y + height > self.canvas_height:
            self.canvas_height = int(y + height)

        # Process children
        children = node.get('children', [])
        for child in children:
            self.process_node(child, x, y, depth + 1)

    def normalize_positions(self):
        """Normalize layer positions to start from 0,0"""
        if not self.layers:
            return

        min_x = min(layer['x'] for layer in self.layers)
        min_y = min(layer['y'] for layer in self.layers)

        for layer in self.layers:
            layer['x'] -= min_x
            layer['y'] -= min_y

        self.canvas_width = max(layer['x'] + layer['width'] for layer in self.layers)
        self.canvas_height = max(layer['y'] + layer['height'] for layer in self.layers)

    def generate_screenshot(self):
        """Request a screenshot of the entire file"""
        print("3️⃣  Generating screenshot...")

        # Get the first page/canvas
        url = f"{FIGMA_API_BASE}/images/{self.file_key}"
        params = {
            "format": "png",
            "scale": 1
        }

        response = requests.get(url, headers=self.headers, params=params)

        if response.status_code == 200:
            data = response.json()
            images = data.get('images', {})
            if images:
                # Download first available image as screenshot
                for node_id, img_url in images.items():
                    if img_url:
                        filepath = self.download_image(img_url, "screenshot.png")
                        if filepath:
                            print(f"   📸 Screenshot saved")
                            return filepath

        print("   ⚠️ Could not generate screenshot")
        return None

    def run(self):
        """Main import process"""
        print("\n" + "=" * 60)
        print("  FIGMA API IMPORT")
        print("=" * 60)
        print(f"\n🔑 API Token: {self.api_token[:10]}...")
        print(f"📁 File Key: {self.file_key}\n")

        try:
            # 1. Fetch file data
            file_data = self.fetch_file()

            # 2. Process document tree
            print("4️⃣  Processing design nodes...")
            document = file_data.get('document', {})

            # Process all pages
            pages = document.get('children', [])
            for page in pages:
                print(f"   📄 Page: {page.get('name', 'Unnamed')}")
                children = page.get('children', [])
                for child in children:
                    self.process_node(child)

            print(f"   ✓ Found {len(self.layers)} layers")

            # 3. Normalize positions
            self.normalize_positions()

            # 4. Fetch images for image layers
            image_node_ids = list(self.images.keys())
            if image_node_ids:
                print(f"5️⃣  Downloading {len(image_node_ids)} images...")
                image_urls = self.fetch_images(image_node_ids)

                img_count = 0
                for node_id, url in image_urls.items():
                    if url and node_id in self.images:
                        filename = f"img_{img_count}.png"
                        filepath = self.download_image(url, filename)
                        if filepath:
                            self.images[node_id]['image_path'] = filepath
                            print(f"      ✓ {filename}")
                            img_count += 1

            # 5. Generate output
            print("6️⃣  Generating output...")

            output = {
                "project": {
                    "name": self.file_name,
                    "source": "figma_api",
                    "file_key": self.file_key,
                    "canvas_width": int(self.canvas_width),
                    "canvas_height": int(self.canvas_height),
                    "screenshot_path": f"{self.output_dir}/images/screenshot.png",
                    "layer_count": len(self.layers)
                },
                "layers": self.layers
            }

            # Save JSON
            json_path = f"{self.output_dir}/layers.json"
            with open(json_path, 'w') as f:
                json.dump(output, f, indent=2)

            print(f"   💾 Saved: {json_path}")

            # 6. Try to get a screenshot of the main frame
            # Look for the largest element to use as screenshot
            print("7️⃣  Generating screenshot...")
            best_frame_id = None
            best_frame_area = 0

            for page in pages:
                for child in page.get('children', []):
                    # Accept FRAME, GROUP, or any element with bounding box
                    bbox = child.get('absoluteBoundingBox', {})
                    area = bbox.get('width', 0) * bbox.get('height', 0)
                    if area > best_frame_area:
                        best_frame_area = area
                        best_frame_id = child.get('id')

            # If no frame found, use the page itself or first element
            if not best_frame_id and pages:
                if pages[0].get('children'):
                    best_frame_id = pages[0]['children'][0].get('id')
                else:
                    best_frame_id = pages[0].get('id')

            if best_frame_id:
                try:
                    url = f"{FIGMA_API_BASE}/images/{self.file_key}"
                    params = {"ids": best_frame_id, "format": "png", "scale": 1}
                    response = self.api_request_with_retry(url, params)
                    img_data = response.json().get('images', {})
                    if best_frame_id in img_data and img_data[best_frame_id]:
                        self.download_image(img_data[best_frame_id], "screenshot.png")
                        print("   📸 Screenshot saved")
                    else:
                        print("   ⚠️ No screenshot URL returned")
                except Exception as e:
                    print(f"   ⚠️ Could not generate screenshot: {str(e)}")
            else:
                print("   ⚠️ No frame found for screenshot")

            print("\n" + "=" * 60)
            print("  ✅ IMPORT COMPLETE!")
            print("=" * 60)
            print(f"   📊 Total layers: {len(self.layers)}")
            print(f"   📐 Canvas: {int(self.canvas_width)} x {int(self.canvas_height)}")
            print(f"   📁 Output: {self.output_dir}")
            print("=" * 60 + "\n")

            return True

        except Exception as e:
            print(f"\n❌ Error: {str(e)}")
            return False


def main():
    if len(sys.argv) < 4:
        print("Usage: python3 figma_api_import.py <API_TOKEN> <FILE_KEY_OR_URL> <OUTPUT_DIR>")
        print("\nExample:")
        print('  python3 figma_api_import.py "figd_xxxxx" "ABC123xyz" "/tmp/figma_import"')
        print('  python3 figma_api_import.py "figd_xxxxx" "https://www.figma.com/file/ABC123/Design" "/tmp/figma_import"')
        sys.exit(1)

    api_token = sys.argv[1]
    file_key_or_url = sys.argv[2]
    output_dir = sys.argv[3]

    importer = FigmaAPIImport(api_token, "", output_dir)

    # Extract file key from URL if needed
    file_key = importer.extract_file_key(file_key_or_url)
    importer.file_key = file_key

    success = importer.run()
    sys.exit(0 if success else 1)


if __name__ == "__main__":
    main()
