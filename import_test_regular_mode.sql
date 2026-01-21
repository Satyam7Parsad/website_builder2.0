-- Import Scraped Template: test_regular_mode
-- Generated: 2026-01-19 23:35:30
-- Source: https://example.com
-- Sections: 1
--
-- Run this script to import the template into PostgreSQL:
-- psql -d website_builder < test_regular_mode.sql
--


BEGIN;

-- Insert the template
INSERT INTO templates (template_name, description, project_name, created_date)
VALUES (
    'test_regular_mode',
    'Imported from https://example.com - Metadata: {"url": "https://example.com", "scraped_date": "2026-01-19T23:35:30.158595", "forms": [], "social_links": [], "seo_data": {"title": "Example Domain", "description": "", "keywords": "", "og": {"title": "", "description": "", "image": "", "url": ""}, "twitter": {"card": "", "title": "", "description": "", "image": ""}, "favicon": "", "canonical": "", "lang": "en"}, "custom_fonts": [], "advanced_css": {"hoverEffects": [], "animations": [{"selector": "a", "animation": "none 0s ease 0s 1 normal none running"}], "transitions": [{"selector": "a", "transition": "all"}]}, "typography_system": {"fonts": ["system-ui, sans-serif"], "sizes": {"h1": 24, "p": 16, "a": 16}, "weights": [400, 700]}, "grid_system": {"baseUnit": 8, "spacingScale": [8, 16, 24, 32, 48, 64], "commonSpacings": [], "gridColumns": "none", "cv_base_unit": 8, "cv_verified": true}, "responsive_layouts": {"mobile": {"width": 375, "height": 812, "sections": []}, "tablet": {"width": 768, "height": 1024, "sections": []}, "desktop": {"width": 1920, "height": 1080, "sections": []}}}',  -- Limit to 5000 chars
    'Test Regular Mode',
    '2026-01-19 23:35:30'
);


-- Get the template ID
DO $$
DECLARE
    template_id_var integer;
BEGIN
    SELECT id INTO template_id_var FROM templates WHERE template_name = 'test_regular_mode';


    -- Section 1: Section 1
    -- CSS Data: {"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(51, 68, 136)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"bor...
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
        1,
        'Section 1',
        'section-1',
        80,
        162,
        'Section 1',
        '',
        'This domain is for use in documentation examples without needing permission. Avoid use in operations. Learn more',
        'Learn more',
        'https://iana.org/domains/example',
        24,
        12,
        16,
        700,
        400,
        400,
        16,
        400,
        15,
        500,
        '0.00,0.00,0.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.00,0.00,0.00,0.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.20,0.27,0.53,1.00',
        '0.00,0.00,0.00,0.00',
        '0.00,0.00,0.00,1.00',
        40,
        1,
        300,
        250,
        20,
        3,
        'none',
        '',
        TRUE,
        '{"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(51, 68, 136)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "0px none rgb(0, 0, 0)", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        '{"paragraphs": [{"text": "This domain is for use in documentation examples without needing permission. Avoid use in operations.", "fontSize": 16, "fontWeight": 400, "color": "rgb(0, 0, 0)", "fontFamily": "system-ui, sans-serif"}, {"text": "Learn more", "fontSize": 16, "fontWeight": 400, "color": "rgb(0, 0, 0)", "fontFamily": "system-ui, sans-serif"}], "nav_items": [{"text": "Learn more", "href": "https://iana.org/domains/example", "fontSize": 16, "fontWeight": 400, "color": "rgb(51, 68, 136)"}]}',
        '{"padding": {"top": "0px", "right": "0px", "bottom": "0px", "left": "0px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "normal"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat", "backgroundSize": "auto", "backgroundImage": "none"}, "position": {"position": "static", "top": "auto", "left": "auto", "right": "auto", "bottom": "auto", "zIndex": "auto"}, "typography": {"fontFamily": "Times"}}'
    );

END $$;


COMMIT;


-- Template import complete!
-- Template name: test_regular_mode
-- Total sections: 1
--
-- To verify the import:
-- SELECT * FROM templates WHERE template_name = 'test_regular_mode';
-- SELECT COUNT(*) FROM sections WHERE template_id = (SELECT id FROM templates WHERE template_name = 'test_regular_mode');

-- Update sections with BYTEA image data
