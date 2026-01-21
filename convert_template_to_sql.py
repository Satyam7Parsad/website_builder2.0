#!/usr/bin/env python3
"""
Convert JSON template to SQL insert statement
"""

import json

# Read the template
with open('templates/pilates_studio.json', 'r') as f:
    template = json.load(f)

# Convert sections to database format
db_sections = []
y_pos = 0

for section in template['sections']:
    # Convert color objects to arrays
    db_section = {
        "id": section["id"],
        "type": section["type"],
        "name": section["name"],
        "section_id": section["section_id"],
        "y_position": y_pos,
        "height": section["height"],
        "selected": False,
        "title": section["title"],
        "subtitle": section["subtitle"],
        "content": section["content"],
        "button_text": section["button_text"],
        "button_link": section["button_link"],
        "title_font_size": section["title_font_size"],
        "subtitle_font_size": section["subtitle_font_size"],
        "content_font_size": section["content_font_size"],
        "title_font_weight": section["title_font_weight"],
        "subtitle_font_weight": section["subtitle_font_weight"],
        "content_font_weight": section["content_font_weight"],
        "title_color": [section["title_color"]["r"], section["title_color"]["g"],
                       section["title_color"]["b"], section["title_color"]["a"]],
        "subtitle_color": [section["subtitle_color"]["r"], section["subtitle_color"]["g"],
                          section["subtitle_color"]["b"], section["subtitle_color"]["a"]],
        "content_color": [section["content_color"]["r"], section["content_color"]["g"],
                         section["content_color"]["b"], section["content_color"]["a"]],
        "background_image": "",
        "section_image": "",
        "bg_texture_id": 0,
        "img_texture_id": 0,
        "use_bg_image": False,
        "bg_overlay_opacity": 0.5,
        "bg_color": [section["bg_color"]["r"], section["bg_color"]["g"],
                    section["bg_color"]["b"], section["bg_color"]["a"]],
        "text_color": [section["text_color"]["r"], section["text_color"]["g"],
                      section["text_color"]["b"], section["text_color"]["a"]],
        "accent_color": [section["accent_color"]["r"], section["accent_color"]["g"],
                        section["accent_color"]["b"], section["accent_color"]["a"]],
        "button_bg_color": [section["button_bg_color"]["r"], section["button_bg_color"]["g"],
                           section["button_bg_color"]["b"], section["button_bg_color"]["a"]],
        "button_text_color": [section["button_text_color"]["r"], section["button_text_color"]["g"],
                             section["button_text_color"]["b"], section["button_text_color"]["a"]],
        "button_font_size": section["button_font_size"],
        "button_font_weight": section["button_font_weight"],
        "padding": section["padding"],
        "text_align": section["text_align"],
        "nav_font_size": section["nav_font_size"],
        "nav_font_weight": section["nav_font_weight"],
        "card_width": section["card_width"],
        "card_height": section["card_height"],
        "card_spacing": section["card_spacing"],
        "cards_per_row": section["cards_per_row"]
    }

    db_sections.append(db_section)
    y_pos += section["height"]

# Generate SQL
sections_json = json.dumps(db_sections, indent=8).replace("'", "''")

sql = f"""-- Pilates Studio Template - Database Insert
-- Run this SQL script to add the Pilates Studio template to your database

-- Insert Pilates Studio Template
INSERT INTO website_templates (
    template_name,
    description,
    author,
    section_count,
    sections_json,
    page_count,
    tags,
    category
) VALUES (
    '{template["template_name"]}',
    '{template["description"]}',
    'Claude Code',
    {len(db_sections)},
    '{sections_json}',
    1,
    'fitness,pilates,wellness,studio,health',
    'Fitness & Wellness'
);
"""

# Write SQL file
with open('insert_pilates_studio.sql', 'w') as f:
    f.write(sql)

print("SQL script generated: insert_pilates_studio.sql")
print(f"Template: {template['template_name']}")
print(f"Sections: {len(db_sections)}")
