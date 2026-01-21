-- Import Scraped Template: test_import
-- Generated: 2026-01-19 23:08:13
-- Source: Unknown
-- Sections: 1
--
-- Run this script to import the template into PostgreSQL:
-- psql -d website_builder < test_import.sql
--


BEGIN;

-- Insert the template
INSERT INTO templates (template_name, description, project_name, created_date)
VALUES (
    'test_import',
    'Imported from  - Metadata: {"url": "", "scraped_date": "2026-01-19T23:08:13.031456", "forms": [], "social_links": [], "seo_data": {}, "custom_fonts": [], "advanced_css": {}, "typography_system": {}, "grid_system": {}, "responsive_layouts": {}}',  -- Limit to 5000 chars
    'Test Import',
    '2026-01-19 23:08:13'
);


-- Get the template ID
DO $$
DECLARE
    template_id_var integer;
BEGIN
    SELECT id INTO template_id_var FROM templates WHERE template_name = 'test_import';


    -- Section 1: Section 1
    -- CSS Data: {"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(0,0,0)", "boxShadow": "none", "padding": "10px 20px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"bor...
    -- Cards: 0 items
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
        0,
        hero,
        'Section 1',
        'section-1',
        600,
        0,
        '',
        '',
        '',
        '',
        '',
        42,
        30,
        16,
        700,
        400,
        400,
        16,
        600,
        15,
        500,
        '0.00,0.00,0.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.12,0.12,0.12,1.00',
        '1.0,1.0,1.0,1.0',
        '0.8,0.4,0.5,1.0',
        '0.78,0.39,0.49,1.00',
        '1.00,1.00,1.00,1.00',
        '0.12,0.12,0.12,1.00',
        '1.0,1.0,1.0,1.0',
        60,
        1,
        300,
        250,
        20,
        3,
        '',
        '',
        FALSE,
        '{"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(0,0,0)", "boxShadow": "none", "padding": "10px 20px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        NULL,
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat", "backgroundSize": "auto", "backgroundImage": "none"}, "position": {"position": "static", "top": "auto", "left": "auto", "right": "auto", "bottom": "auto", "zIndex": "auto"}, "typography": {"fontFamily": "system-ui"}}'
    );

END $$;


COMMIT;


-- Template import complete!
-- Template name: test_import
-- Total sections: 1
--
-- To verify the import:
-- SELECT * FROM templates WHERE template_name = 'test_import';
-- SELECT COUNT(*) FROM sections WHERE template_id = (SELECT id FROM templates WHERE template_name = 'test_import');
