#!/usr/bin/env python3
"""
SQL Generator for Scraped Templates
Converts scraped website data to PostgreSQL INSERT statements
"""

import json
import os
from datetime import datetime
from typing import Dict, List


class SQLGenerator:
    """Generate PostgreSQL INSERT statements from scraped data"""

    def __init__(self, template_data: Dict):
        self.template_data = template_data
        self.template_name = template_data['template_name']
        self.sections = template_data.get('sections', [])

    def generate_sql(self, output_file: str = None) -> str:
        """Generate complete SQL import script"""

        if not output_file:
            output_file = f"import_{self.template_name}.sql"

        sql_parts = []

        # Header
        sql_parts.append(self.generate_header())

        # Begin transaction
        sql_parts.append("BEGIN;\n")

        # Insert template
        sql_parts.append(self.generate_template_insert())

        # Get template ID
        sql_parts.append("""
-- Get the template ID
DO $$
DECLARE
    template_id_var integer;
BEGIN
    SELECT id INTO template_id_var FROM templates WHERE template_name = '{template_name}';
""".format(template_name=self.escape_sql(self.template_name)))

        # Insert sections
        for idx, section in enumerate(self.sections):
            sql_parts.append(self.generate_section_insert(section, idx))

        # End DO block
        sql_parts.append("END $$;\n")

        # Insert enhanced data (Phase 1-3)
        for idx, section in enumerate(self.sections):
            sql_parts.append(self.generate_enhanced_inserts(section, idx))

        # Commit transaction
        sql_parts.append("COMMIT;\n")

        # Footer
        sql_parts.append(self.generate_footer())

        # Combine all parts
        full_sql = '\n'.join(sql_parts)

        # Write to file
        with open(output_file, 'w') as f:
            f.write(full_sql)

        print(f"\n✅ SQL script generated: {output_file}")
        return output_file

    def generate_header(self) -> str:
        """Generate SQL header with comments"""
        return f"""-- Import Scraped Template: {self.template_name}
-- Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}
-- Source: {self.template_data.get('url', 'Unknown')}
-- Sections: {len(self.sections)}
--
-- Run this script to import the template into PostgreSQL:
-- psql -d website_builder < {self.template_name}.sql
--

"""

    def generate_template_insert(self) -> str:
        """Generate INSERT for templates table"""
        url = self.template_data.get('url', '')

        # Build metadata JSON with all extracted template-level data
        metadata = {
            'url': url,
            'scraped_date': self.template_data.get('scraped_date', datetime.now().isoformat()),
            'forms': self.template_data.get('forms', []),
            'social_links': self.template_data.get('social_links', []),
            'seo_data': self.template_data.get('seo_data', {}),
            'custom_fonts': self.template_data.get('custom_fonts', []),
            'advanced_css': self.template_data.get('advanced_css', {}),
            'typography_system': self.template_data.get('typography_system', {}),
            'grid_system': self.template_data.get('grid_system', {}),
            'responsive_layouts': self.template_data.get('responsive_layouts', {})
        }

        description = f"Imported from {url} - Metadata: {json.dumps(metadata)}"

        return f"""-- Insert the template
INSERT INTO templates (template_name, description, project_name, created_date)
VALUES (
    '{self.escape_sql(self.template_name)}',
    '{self.escape_sql(description[:5000])}',  -- Limit to 5000 chars
    '{self.escape_sql(self.template_name.replace('_', ' ').title())}',
    '{datetime.now().strftime('%Y-%m-%d %H:%M:%S')}'
);
"""

    def _convert_section_type(self, type_value) -> int:
        """Convert section type to integer (for database storage)"""
        # If already an integer, return it
        if isinstance(type_value, int):
            return type_value

        # Map string types to enum values (matching C++ SectionType enum)
        type_map = {
            'hero': 0,           # SEC_HERO
            'navigation': 1,     # SEC_NAVBAR
            'header': 0,         # Map to hero
            'nav': 1,            # Map to navbar
            'content': 2,        # SEC_CONTENT
            'about': 2,          # Map to content
            'cards': 3,          # SEC_CARDS
            'card': 3,
            'team': 4,           # SEC_TEAM
            'pricing': 5,        # SEC_PRICING
            'stats': 6,          # SEC_STATS
            'gallery': 7,        # SEC_GALLERY
            'portfolio': 7,      # Map to gallery
            'contact': 8,        # SEC_CONTACT
            'cta': 9,            # SEC_CTA
            'image': 10,         # SEC_IMAGE
            'text': 11,          # SEC_TEXTBOX
            'textbox': 11,
            'footer': 12,        # SEC_FOOTER
            'services': 3,       # Map to cards
            'features': 3,       # Map to cards
            'testimonials': 3,   # Map to cards
            'faq': 2,            # Map to content
            'blog': 3,           # Map to cards
        }

        # Convert string to lowercase and look up
        if isinstance(type_value, str):
            return type_map.get(type_value.lower(), 2)  # Default to content (2)

        return 2  # Default to content

    def generate_section_insert(self, section: Dict, index: int) -> str:
        """Generate INSERT for a single section"""

        # Extract and convert type to integer
        raw_type = section.get('type', 2)
        section_type = self._convert_section_type(raw_type)

        # Handle content - can be dict or string (from different scraper versions)
        # First check root-level name/title (stealth scraper format)
        root_name = section.get('name', '')
        root_title = section.get('title', '')
        root_subtitle = section.get('subtitle', '')

        content = section.get('content', {})
        if isinstance(content, dict):
            # Check if content dict has data, otherwise use root level
            content_title = content.get('title', '') or content.get('text', '')[:100] if content.get('text') else ''
            section_name = root_name or content_title or f'Section {index + 1}'
            section_name = section_name[:100]
            title = (root_title or content_title or section_name)[:500]
            subtitle = (root_subtitle or content.get('subtitle') or '')[:500]
            text_content = (content.get('content') or content.get('text') or '')[:1000]
        else:
            # Content is a string (old format)
            section_name = (root_name or root_title or f'Section {index + 1}')[:100]
            title = (root_title or section_name)[:500]
            subtitle = root_subtitle[:500]
            text_content = str(content)[:1000] if content else section.get('multi_column_text', '')[:1000]

        # Remove newlines from section name for SQL comments
        section_name = section_name.replace('\n', ' ').replace('\r', ' ')
        section_id = self.slugify(section_name)
        height = section.get('height', 400)
        y_position = section.get('y_position', 0)

        # Buttons - now extracted with full data
        button_text = (section.get('button_text') or '')[:100]
        button_link = (section.get('button_link') or '')[:2000]  # Increased for long URLs with query params
        button_bg_color = self.extract_color(section.get('button_bg_color', 'rgb(200, 100, 125)'))
        button_text_color = self.extract_color(section.get('button_text_color', 'rgb(255, 255, 255)'))

        # Typography - now stored at root level
        title_font_size = int(section.get('title_font_size', 42))
        title_font_weight = int(section.get('title_font_weight', 700))
        title_color = self.extract_color(section.get('title_color', 'rgb(0, 0, 0)'))

        content_font_size = int(section.get('content_font_size', 16))
        content_font_weight = int(section.get('content_font_weight', 400))
        content_color = self.extract_color(section.get('content_color', 'rgb(0, 0, 0)'))

        button_font_size = int(section.get('button_font_size', 16))
        button_font_weight = int(section.get('button_font_weight', 600))

        # Colors - now extracted from actual elements
        bg_color = self.extract_color(section.get('bg_color', 'rgb(255,255,255)'))
        text_color = self.extract_color(section.get('text_color', 'rgb(26,26,26)'))

        # Fix color contrast issues - if title is light and bg is light, make bg dark
        title_rgb = [float(x) for x in title_color.split(',')[:3]]
        bg_rgb = [float(x) for x in bg_color.split(',')[:3]]
        title_brightness = sum(title_rgb) / 3
        bg_brightness = sum(bg_rgb) / 3

        # If both are light (brightness > 0.7), make background dark
        if title_brightness > 0.7 and bg_brightness > 0.7:
            bg_color = '0.10,0.10,0.12,1.00'  # Dark background
        # If both are dark (brightness < 0.3), make background light
        elif title_brightness < 0.3 and bg_brightness < 0.3:
            bg_color = '0.95,0.95,0.95,1.00'  # Light background

        # Navbar colors (for SEC_NAVBAR sections)
        nav_bg_color = self.extract_color(section.get('nav_bg_color', section.get('bg_color', 'rgb(255,255,255)')))
        nav_text_color = self.extract_color(section.get('nav_text_color', section.get('text_color', 'rgb(51,51,51)')))

        # Images
        background_image = section.get('background_image', '')
        section_image = section.get('section_image', '')

        # Card sizes - use extracted values or defaults
        card_width = section.get('card_width', 800 if section_type in [3, 4, 5, 6] else 300)
        card_height = section.get('card_height', 1000 if section_type in [3, 4, 5, 6] else 250)
        card_spacing = section.get('card_spacing', 40 if section_type in [3, 4, 5, 6] else 20)

        # Padding - use extracted value or default
        padding = section.get('padding', 60)

        # CSS Properties - NEW!
        css_data = {
            'button': {
                'borderRadius': section.get('button_border_radius', '0px'),
                'borderWidth': section.get('button_border_width', '0px'),
                'borderColor': section.get('button_border_color', 'rgb(0,0,0)'),
                'boxShadow': section.get('button_box_shadow', 'none'),
                'padding': section.get('button_padding', '10px 20px'),
                'textTransform': section.get('button_text_transform', 'none'),
                'letterSpacing': section.get('button_letter_spacing', 'normal')
            },
            'section': {
                'borderRadius': section.get('css_border_radius', '0px'),
                'boxShadow': section.get('css_box_shadow', 'none'),
                'border': section.get('css_border', 'none'),
                'opacity': section.get('css_opacity', '1'),
                'backgroundImage': section.get('css_background_image', 'none'),
                'backgroundSize': section.get('css_background_size', 'auto'),
                'filter': section.get('css_filter', 'none'),
                'transform': section.get('css_transform', 'none'),
                'textShadow': section.get('css_text_shadow', 'none'),
                'lineHeight': section.get('css_line_height', 'normal'),
                'letterSpacing': section.get('css_letter_spacing', 'normal')
            }
        }
        css_json = json.dumps(css_data)

        # Cards/Items data (multiple buttons/content blocks)
        cards = section.get('cards', [])
        cards_per_row = section.get('cards_per_row', 3)
        interactive_data = {}
        if cards:
            interactive_data['cards'] = cards

        # Extract paragraphs from content for text rendering
        if isinstance(content, dict) and 'paragraphs' in content:
            paragraphs = content.get('paragraphs', [])
            if paragraphs:
                # Store paragraph data with text, styling, and colors
                interactive_data['paragraphs'] = [
                    {
                        'text': p.get('text', ''),
                        'fontSize': p.get('fontSize', 16),
                        'fontWeight': p.get('fontWeight', 400),
                        'color': p.get('color', 'rgb(0, 0, 0)'),
                        'fontFamily': p.get('fontFamily', 'Arial')
                    }
                    for p in paragraphs[:10]  # Limit to 10 paragraphs
                ]

        # Extract navigation items (for navbar sections)
        nav_items = section.get('nav_items', [])
        if nav_items:
            interactive_data['nav_items'] = nav_items

        # Extract gallery images (for gallery sections)
        gallery_images = section.get('gallery_images', [])
        if gallery_images:
            interactive_data['gallery_images'] = gallery_images

        # Extract hero animation images (for hero sections)
        hero_animation_images = section.get('hero_animation_images', [])
        if hero_animation_images:
            interactive_data['hero_animation_images'] = hero_animation_images
            interactive_data['enable_hero_animation'] = section.get('enable_hero_animation', True)
            interactive_data['hero_animation_speed'] = section.get('hero_animation_speed', 2.0)

        # Extract logo (for navbar sections)
        logo = section.get('logo')
        if logo:
            interactive_data['logo'] = logo

        # Extract dropdown menus (for navbar sections)
        dropdown_menus = section.get('dropdown_menus', [])
        if dropdown_menus:
            interactive_data['dropdown_menus'] = dropdown_menus

        # Extract footer links (for footer sections)
        footer_links = section.get('footer_links', [])
        if footer_links:
            interactive_data['footer_links'] = footer_links

        # Extract social links (for footer/header sections)
        social_links = section.get('social_links', [])
        if social_links:
            interactive_data['social_links'] = social_links

        # Extract copyright (for footer sections)
        copyright_text = section.get('copyright')
        if copyright_text:
            interactive_data['copyright'] = copyright_text

        interactive_json = json.dumps(interactive_data) if interactive_data else None

        # Layout Properties (padding, flexbox, grid, positioning, gradients, fonts)
        layout_data = {
            'padding': {
                'top': section.get('padding_top', '60px'),
                'right': section.get('padding_right', '60px'),
                'bottom': section.get('padding_bottom', '60px'),
                'left': section.get('padding_left', '60px')
            },
            'flexbox': {
                'display': section.get('display', 'block'),
                'flexDirection': section.get('flex_direction', 'row'),
                'justifyContent': section.get('justify_content', 'normal'),
                'alignItems': section.get('align_items', 'normal'),
                'gap': section.get('gap', '0px')
            },
            'grid': {
                'gridTemplateColumns': section.get('grid_template_columns', 'none'),
                'gridTemplateRows': section.get('grid_template_rows', 'none')
            },
            'background': {
                'backgroundPosition': section.get('background_position', '0% 0%'),
                'backgroundRepeat': section.get('background_repeat', 'repeat'),
                'backgroundSize': section.get('background_size', 'auto'),
                'backgroundImage': section.get('background_image', 'none')
            },
            'position': {
                'position': section.get('position', 'static'),
                'top': section.get('top', 'auto'),
                'left': section.get('left', 'auto'),
                'right': section.get('right', 'auto'),
                'bottom': section.get('bottom', 'auto'),
                'zIndex': section.get('z_index', 'auto')
            },
            'typography': {
                'fontFamily': section.get('font_family', 'system-ui')
            }
        }
        layout_json = json.dumps(layout_data)

        # Build INSERT statement
        sql = f"""
    -- Section {index + 1}: {section_name}
    -- CSS Data: {self.escape_sql(css_json)[:200]}...
    -- Cards: {len(cards)} items
    INSERT INTO sections (
        template_id, section_order, type, name, section_id, height, y_position,
        title, subtitle, content, button_text, button_link,
        title_font_size, subtitle_font_size, content_font_size,
        title_font_weight, subtitle_font_weight, content_font_weight,
        button_font_size, button_font_weight, nav_font_size, nav_font_weight,
        title_color, subtitle_color, content_color, bg_color, text_color,
        accent_color, button_bg_color, button_text_color,
        nav_bg_color, nav_text_color,
        padding, text_align, card_width, card_height, card_spacing, cards_per_row,
        background_image, section_image, use_bg_image, css_data, interactive_data, layout_data
    ) VALUES (
        template_id_var,
        {index},
        {section_type},
        '{self.escape_sql(section_name)}',
        '{self.escape_sql(section_id)}',
        {int(height)},
        {int(y_position)},
        '{self.escape_sql(title)}',
        '{self.escape_sql(subtitle)}',
        '{self.escape_sql(text_content)}',
        '{self.escape_sql(button_text)}',
        '{self.escape_sql(button_link)}',
        {title_font_size},
        {title_font_size - 12},
        {content_font_size},
        {title_font_weight},
        400,
        {content_font_weight},
        {button_font_size},
        {button_font_weight},
        15,
        500,
        '{title_color}',
        '{title_color}',
        '{content_color}',
        '{bg_color}',
        '{text_color}',
        '0.8,0.4,0.5,1.0',
        '{button_bg_color}',
        '{button_text_color}',
        '{nav_bg_color}',
        '{nav_text_color}',
        {int(padding)},
        1,
        {int(card_width)},
        {int(card_height)},
        {int(card_spacing)},
        {cards_per_row},
        '{self.escape_sql(background_image)}',
        '{self.escape_sql(section_image)}',
        {str(bool(background_image)).upper()},
        '{self.escape_sql(css_json)}',
        {f"'{self.escape_sql(interactive_json)}'" if interactive_json else 'NULL'},
        '{self.escape_sql(layout_json)}'
    );
"""
        return sql

    def extract_color(self, css_color: str) -> str:
        """Extract color from CSS and convert to SQL format"""
        import re

        # Parse rgb(r,g,b) or rgba(r,g,b,a)
        match = re.search(r'rgba?\((\d+),\s*(\d+),\s*(\d+)(?:,\s*([\d.]+))?\)', css_color)
        if match:
            r = int(match.group(1)) / 255.0
            g = int(match.group(2)) / 255.0
            b = int(match.group(3)) / 255.0
            a = float(match.group(4)) if match.group(4) else 1.0
            return f"{r:.2f},{g:.2f},{b:.2f},{a:.2f}"

        # Default
        return "1.0,1.0,1.0,1.0"

    def slugify(self, text: str) -> str:
        """Convert text to URL-friendly slug"""
        import re
        text = text.lower()
        text = re.sub(r'[^\w\s-]', '', text)
        text = re.sub(r'[\s_-]+', '-', text)
        text = re.sub(r'^-+|-+$', '', text)
        return text[:100]

    def escape_sql(self, text: str) -> str:
        """Escape SQL strings"""
        if not text:
            return ''
        # Replace single quotes with two single quotes
        return text.replace("'", "''").replace('\n', ' ').replace('\r', '')

    def parse_css_number(self, value: str) -> float:
        """Parse CSS number value to float"""
        import re
        if isinstance(value, (int, float)):
            return float(value)
        if not value or value == 'normal' or value == 'none':
            return 0.0
        # Extract number from strings like "20px", "1.5em", etc.
        match = re.search(r'([\d.]+)', str(value))
        if match:
            return float(match.group(1))
        return 0.0

    def generate_enhanced_inserts(self, section: Dict, index: int) -> str:
        """Generate INSERTs for Phase 1-3 enhancement tables"""
        sql_parts = []

        # Phase 1: Custom section type (type_name)
        type_info = section.get('type_info', {})
        type_name = type_info.get('id', '')
        if type_name:
            sql_parts.append(f"""
-- Enhanced data for Section {index + 1}
UPDATE sections
SET type_name = '{self.escape_sql(type_name)}',
    use_legacy_type = FALSE
WHERE template_id = (SELECT id FROM templates WHERE template_name = '{self.template_name}')
  AND section_order = {index};
""")

        # Phase 2: Layout properties
        layout = section.get('layout', {})
        is_flexbox = layout.get('isFlexbox', False)
        is_grid = layout.get('isGrid', False)

        if is_flexbox or is_grid:
            layout_mode = 1 if is_flexbox else 2  # 1=flexbox, 2=grid
            flex_direction = layout.get('flexDirection', 'row')
            justify_content = layout.get('justifyContent', 'normal')
            align_items = layout.get('alignItems', 'normal')
            gap = self.parse_css_number(layout.get('gap', '0'))
            grid_template_columns = layout.get('gridTemplateColumns', 'none')
            grid_template_rows = layout.get('gridTemplateRows', 'none')
            grid_gap = self.parse_css_number(layout.get('gridGap', '0'))

            sql_parts.append(f"""
INSERT INTO section_layout_properties (
    section_id, layout_mode, flex_direction, justify_content, align_items,
    flex_gap, grid_template_columns, grid_template_rows, grid_gap
) VALUES (
    (SELECT id FROM sections
     WHERE template_id = (SELECT id FROM templates WHERE template_name = '{self.template_name}')
     AND section_order = {index}),
    {layout_mode},
    '{self.escape_sql(flex_direction)}',
    '{self.escape_sql(justify_content)}',
    '{self.escape_sql(align_items)}',
    {gap},
    '{self.escape_sql(grid_template_columns)}',
    '{self.escape_sql(grid_template_rows)}',
    {grid_gap}
);
""")

        # Phase 3: Interactive elements
        interactive = section.get('interactive', {})

        # Interactive elements currently disabled due to duplicate key issues
        # TODO: Fix element_index uniqueness constraint before re-enabling
        #
        # # Carousel
        # carousel = interactive.get('carousel', {})
        # if carousel.get('detected'):
        #     images = carousel.get('images', [])
        #     images_json = json.dumps(images)
        #     auto_play_speed = carousel.get('auto_play_speed', 3.0)
        #
        #     sql_parts.append(f"""
        # INSERT INTO interactive_elements (
        #     section_id, element_index, element_type, carousel_images, carousel_auto_play_speed
        # ) VALUES (
        #     (SELECT id FROM sections
        #      WHERE template_id = (SELECT id FROM templates WHERE template_name = '{self.template_name}')
        #      AND section_order = {index}),
        #     0,
        #     2,  -- INTERACT_CAROUSEL
        #     '{self.escape_sql(images_json)}',
        #     {auto_play_speed}
        # );
        # """)
        #
        # # Dropdowns
        # dropdowns = interactive.get('dropdowns', [])
        # for dd_idx, dropdown in enumerate(dropdowns):
        #     options = dropdown.get('options', [])
        #     options_json = json.dumps(options)
        #
        #     sql_parts.append(f"""
        # INSERT INTO interactive_elements (
        #     section_id, element_index, element_type, dropdown_items
        # ) VALUES (
        #     (SELECT id FROM sections
        #      WHERE template_id = (SELECT id FROM templates WHERE template_name = '{self.template_name}')
        #      AND section_order = {index}),
        #     {dd_idx},
        #     1,  -- INTERACT_DROPDOWN
        #     '{self.escape_sql(options_json)}'
        # );
        # """)

        return '\n'.join(sql_parts)

    def generate_footer(self) -> str:
        """Generate SQL footer"""
        return f"""
-- Template import complete!
-- Template name: {self.template_name}
-- Total sections: {len(self.sections)}
--
-- To verify the import:
-- SELECT * FROM templates WHERE template_name = '{self.template_name}';
-- SELECT COUNT(*) FROM sections WHERE template_id = (SELECT id FROM templates WHERE template_name = '{self.template_name}');
"""

    def generate_image_bytea_updates(self, images_dir: str) -> str:
        """Generate SQL UPDATE statements to add BYTEA image data"""
        if not os.path.exists(images_dir):
            return ""

        updates = ["\n-- Update sections with BYTEA image data\n"]

        for idx, section in enumerate(self.sections):
            # Background image
            bg_image_path = section.get('background_image', '')
            if bg_image_path and os.path.exists(bg_image_path):
                bytea_data = self.image_to_bytea(bg_image_path)
                if bytea_data:
                    updates.append(f"""
UPDATE sections
SET background_image_data = {bytea_data}
WHERE template_id = (SELECT id FROM templates WHERE template_name = '{self.template_name}')
  AND section_order = {idx};
""")

            # Section image
            sec_image_path = section.get('section_image', '')
            if sec_image_path and os.path.exists(sec_image_path):
                bytea_data = self.image_to_bytea(sec_image_path)
                if bytea_data:
                    updates.append(f"""
UPDATE sections
SET section_image_data = {bytea_data}
WHERE template_id = (SELECT id FROM templates WHERE template_name = '{self.template_name}')
  AND section_order = {idx};
""")

        return '\n'.join(updates)

    def image_to_bytea(self, image_path: str) -> str:
        """Convert image file to PostgreSQL BYTEA hex format"""
        try:
            with open(image_path, 'rb') as f:
                image_data = f.read()

            # Convert to hex string with PostgreSQL BYTEA format
            hex_string = image_data.hex()
            return f"E'\\\\x{hex_string}'"

        except Exception as e:
            print(f"   ⚠️  Failed to convert image to BYTEA: {image_path}: {e}")
            return None


def main():
    """Example usage"""
    import sys

    if len(sys.argv) < 2:
        print("Usage: python sql_generator.py <scraped_json_file>")
        print("\nExample:")
        print("  python sql_generator.py scraped_example_com.json")
        sys.exit(1)

    json_file = sys.argv[1]

    # Load scraped data
    with open(json_file, 'r') as f:
        template_data = json.load(f)

    # Generate SQL
    generator = SQLGenerator(template_data)
    output_file = generator.generate_sql()

    print(f"\n✅ SQL import script ready!")
    print(f"\nTo import into PostgreSQL:")
    print(f"  psql -d website_builder < {output_file}")


if __name__ == '__main__':
    main()
