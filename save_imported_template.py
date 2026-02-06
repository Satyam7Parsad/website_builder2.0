#!/usr/bin/env python3
"""
Save imported Figma-style template to database
Converts layers.json to database format and generates SQL
"""

import json
import sys
import os
import re

def parse_color(color_str):
    """Parse CSS color string to RGBA array"""
    if not color_str:
        return [1.0, 1.0, 1.0, 1.0]

    # Handle rgba(r, g, b, a)
    rgba_match = re.match(r'rgba?\((\d+),\s*(\d+),\s*(\d+)(?:,\s*([\d.]+))?\)', color_str)
    if rgba_match:
        r = int(rgba_match.group(1)) / 255.0
        g = int(rgba_match.group(2)) / 255.0
        b = int(rgba_match.group(3)) / 255.0
        a = float(rgba_match.group(4)) if rgba_match.group(4) else 1.0
        return [r, g, b, a]

    # Handle rgb(r, g, b)
    rgb_match = re.match(r'rgb\((\d+),\s*(\d+),\s*(\d+)\)', color_str)
    if rgb_match:
        r = int(rgb_match.group(1)) / 255.0
        g = int(rgb_match.group(2)) / 255.0
        b = int(rgb_match.group(3)) / 255.0
        return [r, g, b, 1.0]

    return [1.0, 1.0, 1.0, 1.0]


def convert_to_template(layers_json_path, template_name=None, category="Imported"):
    """Convert Figma layers.json to database template format"""

    with open(layers_json_path, 'r') as f:
        data = json.load(f)

    project = data['project']
    layers = data['layers']
    sections = data.get('sections', [])

    # Auto-generate template name from source URL
    if not template_name:
        template_name = project.get('name', 'Imported Template')
        template_name = template_name.replace('.', ' ').replace('-', ' ').title()

    # Convert layers to database format
    db_layers = []
    for layer in layers:
        db_layer = {
            "id": layer['id'],
            "type": layer['type'],
            "name": layer['name'],
            "x": layer['x'],
            "y": layer['y'],
            "width": layer['width'],
            "height": layer['height'],
            "z_index": layer.get('z_index', 0),
            "text": layer.get('text', ''),
            "image_path": layer.get('image_path', ''),
            "href": layer.get('href', ''),
            "action_type": layer.get('action_type', 'none'),
            "bg_color": parse_color(layer.get('bg_color', '')),
            "text_color": parse_color(layer.get('text_color', '')),
            "border_color": parse_color(layer.get('border_color', '')),
            "font_size": layer.get('font_size', 16),
            "font_weight": layer.get('font_weight', 400),
            "font_family": layer.get('font_family', 'system-ui'),
            "text_align": layer.get('text_align', 'left'),
            "border_width": layer.get('border_width', 0),
            "border_radius": layer.get('border_radius', 0),
            "opacity": layer.get('opacity', 1.0),
            "box_shadow": layer.get('box_shadow', 'none'),
            "background_image": layer.get('background_image', ''),
            "visible": True,
            "locked": False
        }
        db_layers.append(db_layer)

    # Convert sections
    db_sections = []
    for section in sections:
        db_section = {
            "id": section['id'],
            "name": section['name'],
            "y_start": section['y_start'],
            "y_end": section['y_end'],
            "layer_ids": section['layer_ids'],
            "bg_color": parse_color(section.get('bg_color', ''))
        }
        db_sections.append(db_section)

    # Create template object
    template = {
        "template_name": template_name,
        "description": f"Imported from {project.get('source_url', 'unknown')}",
        "source_url": project.get('source_url', ''),
        "canvas_width": project.get('canvas_width', 1920),
        "canvas_height": project.get('canvas_height', 1080),
        "layer_count": len(db_layers),
        "section_count": len(db_sections),
        "category": category,
        "tags": "imported,webflow,store",
        "layers": db_layers,
        "sections": db_sections
    }

    return template


def generate_sql(template, output_path):
    """Generate SQL insert statement"""

    layers_json = json.dumps(template['layers']).replace("'", "''")
    sections_json = json.dumps(template['sections']).replace("'", "''")

    sql = f"""-- {template['template_name']} - Database Insert
-- Auto-generated from imported website

-- Insert Template
INSERT INTO website_templates (
    template_name,
    description,
    author,
    source_url,
    canvas_width,
    canvas_height,
    layer_count,
    section_count,
    layers_json,
    sections_json,
    tags,
    category,
    created_at
) VALUES (
    '{template["template_name"]}',
    '{template["description"].replace("'", "''")}',
    'Figma Layer Scraper',
    '{template["source_url"]}',
    {template["canvas_width"]},
    {template["canvas_height"]},
    {template["layer_count"]},
    {template["section_count"]},
    '{layers_json}',
    '{sections_json}',
    '{template["tags"]}',
    '{template["category"]}',
    CURRENT_TIMESTAMP
);

-- Verify insertion
SELECT template_id, template_name, layer_count, section_count
FROM website_templates
WHERE template_name = '{template["template_name"]}';
"""

    with open(output_path, 'w') as f:
        f.write(sql)

    print(f"✅ SQL saved: {output_path}")


def save_template_json(template, output_path):
    """Save template as JSON file"""
    with open(output_path, 'w') as f:
        json.dump(template, f, indent=2)
    print(f"✅ Template JSON saved: {output_path}")


def main():
    # Default paths
    layers_json = "figma_export/layers.json"

    if len(sys.argv) > 1:
        layers_json = sys.argv[1]

    template_name = None
    if len(sys.argv) > 2:
        template_name = sys.argv[2]

    if not os.path.exists(layers_json):
        print(f"❌ File not found: {layers_json}")
        sys.exit(1)

    print(f"📂 Loading: {layers_json}")

    # Convert to template format
    template = convert_to_template(layers_json, template_name, "E-commerce")

    # Generate output filenames
    safe_name = template['template_name'].lower().replace(' ', '_')

    # Save template JSON
    template_json_path = f"templates/{safe_name}.json"
    os.makedirs("templates", exist_ok=True)
    save_template_json(template, template_json_path)

    # Generate SQL
    sql_path = f"import_{safe_name}.sql"
    generate_sql(template, sql_path)

    print(f"\n📊 Template Summary:")
    print(f"   Name: {template['template_name']}")
    print(f"   Layers: {template['layer_count']}")
    print(f"   Sections: {template['section_count']}")
    print(f"   Canvas: {template['canvas_width']}x{template['canvas_height']}")


if __name__ == "__main__":
    main()
