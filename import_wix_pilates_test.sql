-- Import Scraped Template: wix_pilates_test
-- Generated: 2026-01-20 03:15:37
-- Source: https://www.wix.com/website-template/view/html/835?originUrl=https%3A%2F%2Fwww.wix.com%2Fwebsite%2Ftemplates%2Fhtml%2Fall%2F223&tpClick=view_button&esi=968b7184-8308-4212-bec7-7827efe451dd
-- Sections: 1
--
-- Run this script to import the template into PostgreSQL:
-- psql -d website_builder < wix_pilates_test.sql
--


BEGIN;

-- Insert the template
INSERT INTO templates (template_name, description, project_name, created_date)
VALUES (
    'wix_pilates_test',
    'Imported from https://www.wix.com/website-template/view/html/835?originUrl=https%3A%2F%2Fwww.wix.com%2Fwebsite%2Ftemplates%2Fhtml%2Fall%2F223&tpClick=view_button&esi=968b7184-8308-4212-bec7-7827efe451dd - Metadata: {"url": "https://www.wix.com/website-template/view/html/835?originUrl=https%3A%2F%2Fwww.wix.com%2Fwebsite%2Ftemplates%2Fhtml%2Fall%2F223&tpClick=view_button&esi=968b7184-8308-4212-bec7-7827efe451dd", "scraped_date": "2026-01-20T03:15:37.381548", "forms": [], "social_links": [], "seo_data": {"title": "Pilates Studio Website Template | WIX", "description": "Perfect for yoga, pilates, and fitness studios, this modern template uses cool colors and subtle design. Add text to promote your classes and upload photos to introduce your facilities and instructors. Create a professional website and build your online presence!", "keywords": "", "og": {"title": "Pilates Studio Website Template | WIX", "description": "Perfect for yoga, pilates, and fitness studios, this modern template uses cool colors and subtle design. Add text to promote your classes and upload photos to introduce your facilities and instructors. Create a professional website and build your online presence!", "image": "//static.wixstatic.com/media//templates/image/fc7d698084668d65c58e2d2157ab1e663f04236b0fd68aec5a59bd17f90d2cdd.jpg", "url": "https://www.wix.com/website-template/view/html/835"}, "twitter": {"card": "", "title": "", "description": "", "image": ""}, "favicon": "https://www.wix.com/favicon.ico", "canonical": "https://www.wix.com/website-template/view/html/835", "lang": ""}, "custom_fonts": [], "advanced_css": {"hoverEffects": [], "animations": [{"selector": "nHuSJZ", "animation": "none 0s ease 0s 1 normal none running"}, {"selector": "oOZ5cH FrcaLY", "animation": "none 0s ease 0s 1 normal none running"}, {"selector": "oOZ5cH", "animation": "none 0s ease 0s 1 normal none running"}, {"selector": "bggdgE LCjeiB", "animation": "none 0s ease 0s 1 normal none running"}, {"selector": "Ydu4WK Y_xMZ5", "animation": "none 0s ease 0s 1 normal none running"}, {"selector": "gVJ7eC", "animation": "none 0s ease 0s 1 normal none running"}, {"selector": "XpwCp3 sKD7vO kX8CZg", "animation": "none 0s ease 0s 1 normal none running"}], "transitions": [{"selector": "nHuSJZ", "transition": "all"}, {"selector": "oOZ5cH FrcaLY", "transition": "all"}, {"selector": "oOZ5cH", "transition": "all"}, {"selector": "bggdgE LCjeiB", "transition": "all"}, {"selector": "Ydu4WK Y_xMZ5", "transition": "all"}, {"selector": "gVJ7eC", "transition": "all"}, {"selector": "XpwCp3 sKD7vO kX8CZg", "transition": "all"}]}, "typography_system": {"fonts": ["\"Madefor Display\", \"Helvetica Neue\", Helvetica, Arial, \u30e1\u30a4\u30ea\u30aa, meiryo, \"\u30d2\u30e9\u30ae\u30ce\u89d2\u30b4 pro w3\", \"hiragino kaku gothic pro\", sans-serif", "Madefor, \"Helvetica Neue\", Helvetica, Arial, \u30e1\u30a4\u30ea\u30aa, meiryo, \"\u30d2\u30e9\u30ae\u30ce\u89d2\u30b4 pro w3\", \"hiragino kaku gothic pro\", sans-serif"], "sizes": {"h1": 36, "h3": 16, "p": 16, "button": 16, "a": 16}, "weights": [300, 400, 700]}, "grid_system": {"baseUnit": 8, "spacingScale": [8, 16, 24, 32, 48, 64], "commonSpacings": [], "gridColumns": "none", "cv_base_unit": 4, "cv_verified": true}, "responsive_layouts": {"mobile": {"width": 375, "height": 812, "sections": []}, "tablet": {"width": 768, "height": 1024, "sections": []}, "desktop": {"width": 1920, "height": 1080, "sections": []}}}',  -- Limit to 5000 chars
    'Wix Pilates Test',
    '2026-01-20 03:15:37'
);


-- Get the template ID
DO $$
DECLARE
    template_id_var integer;
BEGIN
    SELECT id INTO template_id_var FROM templates WHERE template_name = 'wix_pilates_test';


    -- Section 1: Section 1
    -- CSS Data: {"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(0, 0, 238)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"borde...
    -- Cards: 7 items
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
        0,
        'Section 1',
        'section-1',
        1080,
        0,
        'Pilates Studio - Website Template',
        'Good For:',
        'Click edit and create your own amazing website Pilates, fitness studio and personal training Perfect for yoga, pilates, and fitness studios, this modern template uses cool colors and subtle design. Add text to promote your classes and upload photos to introduce your facilities and instructors. Create a professional website and build your online presence!',
        'wix.com',
        'https://www.wix.com/',
        36,
        24,
        16,
        400,
        400,
        400,
        16,
        400,
        15,
        500,
        '0.13,0.19,0.24,1.00',
        '0.13,0.19,0.24,1.00',
        '0.13,0.19,0.24,1.00',
        '0.95,0.95,0.95,1.00',
        '0.13,0.19,0.24,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.00,0.00,0.93,1.00',
        '0.00,0.00,0.00,0.00',
        '0.13,0.19,0.24,1.00',
        80,
        1,
        800,
        1000,
        40,
        3,
        'none',
        'scraped_images/wix_pilates_test/img_5.jpg',
        TRUE,
        '{"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(0, 0, 238)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "0px none rgb(32, 48, 60)", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "24px", "letterSpacing": "normal"}}',
        '{"cards": [{"title": "wix.com", "description": "Click edit and create your own amazing website", "link": "https://www.wix.com/", "button_text": "wix.com", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(0, 0, 238)", "title_font_size": 16, "title_font_weight": 400}, {"title": "show desktop view", "description": "Pilates, fitness studio and personal training", "link": "", "button_text": "show desktop view", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(77, 51, 222)", "title_font_size": 16, "title_font_weight": 400}, {"title": ".mobile-new-ui_svg__st1{fill:currentColor}show mobile view", "description": "Perfect for yoga, pilates, and fitness studios, this modern template uses cool colors and subtle design. Add text to promote your classes and upload photos to introduce your facilities and instructors. Create a professional website and build your online presence!", "link": "", "button_text": ".mobile-new-ui_svg__st1{fill:currentColor}show mob", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(32, 48, 60)", "title_font_size": 16, "title_font_weight": 400}, {"title": "Read More", "description": "", "link": "https://www.wix.com/website-template/view/html/835?originUrl=https%3A%2F%2Fwww.wix.com%2Fwebsite%2Ftemplates%2Fhtml%2Fall%2F223&tpClick=view_button&esi=968b7184-8308-4212-bec7-7827efe451dd#", "button_text": "Read More", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(32, 48, 60)", "title_font_size": 16, "title_font_weight": 300}, {"title": "Edit this site", "description": "", "link": "https://manage.wix.com/edit-template/from-intro?originTemplateId=12a1d854-6e87-a3d8-58b8-6fe9d6dbf579&editorSessionId=968b7184-8308-4212-bec7-7827efe451dd", "button_text": "Edit this site", "bg_color": "rgb(22, 22, 22)", "text_color": "rgb(255, 255, 255)", "title_font_size": 16, "title_font_weight": 400}, {"title": "close info popup", "description": "", "link": "", "button_text": "close info popup", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(32, 48, 60)", "title_font_size": 16, "title_font_weight": 400}, {"title": "Edit Now", "description": "", "link": "https://manage.wix.com/edit-template/from-intro?originTemplateId=12a1d854-6e87-a3d8-58b8-6fe9d6dbf579&editorSessionId=968b7184-8308-4212-bec7-7827efe451dd", "button_text": "Edit Now", "bg_color": "rgb(22, 22, 22)", "text_color": "rgb(255, 255, 255)", "title_font_size": 16, "title_font_weight": 400}], "paragraphs": [{"text": "Click edit and create your own amazing website", "fontSize": 16, "fontWeight": 400, "color": "rgb(32, 48, 60)", "fontFamily": "Madefor, \"Helvetica Neue\", Helvetica, Arial, \u30e1\u30a4\u30ea\u30aa, meiryo, \"\u30d2\u30e9\u30ae\u30ce\u89d2\u30b4 pro w3\", \"hiragino kaku gothic pro\", sans-serif"}, {"text": "Pilates, fitness studio and personal training", "fontSize": 16, "fontWeight": 400, "color": "rgb(32, 48, 60)", "fontFamily": "Madefor, \"Helvetica Neue\", Helvetica, Arial, \u30e1\u30a4\u30ea\u30aa, meiryo, \"\u30d2\u30e9\u30ae\u30ce\u89d2\u30b4 pro w3\", \"hiragino kaku gothic pro\", sans-serif"}, {"text": "Perfect for yoga, pilates, and fitness studios, this modern template uses cool colors and subtle design. Add text to promote your classes and upload photos to introduce your facilities and instructors. Create a professional website and build your online presence!", "fontSize": 16, "fontWeight": 400, "color": "rgb(32, 48, 60)", "fontFamily": "Madefor, \"Helvetica Neue\", Helvetica, Arial, \u30e1\u30a4\u30ea\u30aa, meiryo, \"\u30d2\u30e9\u30ae\u30ce\u89d2\u30b4 pro w3\", \"hiragino kaku gothic pro\", sans-serif"}]}',
        '{"padding": {"top": "0px", "right": "0px", "bottom": "0px", "left": "0px"}, "flexbox": {"display": "inline", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "normal"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat", "backgroundSize": "auto", "backgroundImage": "none"}, "position": {"position": "static", "top": "auto", "left": "auto", "right": "auto", "bottom": "auto", "zIndex": "auto"}, "typography": {"fontFamily": "Madefor, \"Helvetica Neue\", Helvetica, Arial, \u30e1\u30a4\u30ea\u30aa, meiryo, \"\u30d2\u30e9\u30ae\u30ce\u89d2\u30b4 pro w3\", \"hiragino kaku gothic pro\", sans-serif"}}'
    );

END $$;


COMMIT;


-- Template import complete!
-- Template name: wix_pilates_test
-- Total sections: 1
--
-- To verify the import:
-- SELECT * FROM templates WHERE template_name = 'wix_pilates_test';
-- SELECT COUNT(*) FROM sections WHERE template_id = (SELECT id FROM templates WHERE template_name = 'wix_pilates_test');

-- Update sections with BYTEA image data


UPDATE sections
SET section_image_data = E'\\x'
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'wix_pilates_test')
  AND section_order = 0;
