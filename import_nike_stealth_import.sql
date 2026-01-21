-- Import Scraped Template: nike_stealth_import
-- Generated: 2026-01-20 00:04:58
-- Source: Unknown
-- Sections: 4
--
-- Run this script to import the template into PostgreSQL:
-- psql -d website_builder < nike_stealth_import.sql
--


BEGIN;

-- Insert the template
INSERT INTO templates (template_name, description, project_name, created_date)
VALUES (
    'nike_stealth_import',
    'Imported from  - Metadata: {"url": "", "scraped_date": "2026-01-20T00:04:58.633365", "forms": [], "social_links": [], "seo_data": {}, "custom_fonts": [], "advanced_css": {}, "typography_system": {}, "grid_system": {}, "responsive_layouts": {}}',  -- Limit to 5000 chars
    'Nike Stealth Import',
    '2026-01-20 00:04:58'
);


-- Get the template ID
DO $$
DECLARE
    template_id_var integer;
BEGIN
    SELECT id INTO template_id_var FROM templates WHERE template_name = 'nike_stealth_import';


    -- Section 1: New & Featured Details 
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
        1,
        'New & Featured Details ',
        'new-featured-details',
        300,
        36,
        'New & Featured Details ',
        ':host summary {',
        'New & Featured Details  :host summary {   display: list-item;   counter-increment: list-item 0;   list-style: disclosure-closed inside; } :host([open]) summary {   list-style-type: disclosure-open; }  Featured Upcoming Drops New Arrivals Bestsellers SNKRS Launch Calendar Customise with Nike By You Jordan Kobe Bryant LeBron James All Conditions Gear Trending Just Do the Work Ready for the Cold More Colours, More Running What''s Trending 24.7 Collection Colours of the Season Retro Running Running S',
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
        '1.00,1.00,1.00,1.00',
        '1.00,1.00,1.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.12,0.12,0.16,1.00',
        '1.00,1.00,1.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.78,0.39,0.49,1.00',
        '1.00,1.00,1.00,1.00',
        '0.12,0.12,0.16,1.00',
        '1.00,1.00,1.00,1.00',
        60,
        1,
        300,
        250,
        20,
        3,
        '',
        'https://static.nike.com/a/images/f_auto/dpr_1.0,cs_srgb/w_1905,c_limit/459fe6b8-e51d-4d96-9880-66d7199de533/nike-just-do-it.png',
        FALSE,
        '{"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(0,0,0)", "boxShadow": "none", "padding": "10px 20px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        NULL,
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat", "backgroundSize": "auto", "backgroundImage": "none"}, "position": {"position": "static", "top": "auto", "left": "auto", "right": "auto", "bottom": "auto", "zIndex": "auto"}, "typography": {"fontFamily": "system-ui"}}'
    );


    -- Section 2: Court Styles Shop Nike GP Challenge Pro Women's Ha
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
        1,
        1,
        'Court Styles Shop Nike GP Challenge Pro Women''s Ha',
        'court-styles-shop-nike-gp-challenge-pro-womens-ha',
        776,
        3092,
        'Court Styles Shop Nike GP Challenge Pro Women''s Hard Court Tennis Shoes MRP : â¹ 9 695.00 Nike GP C',
        '',
        'Court Styles Shop Nike GP Challenge Pro Women''s Hard Court Tennis Shoes MRP : â¹ 9 695.00 Nike GP Challenge Pro Women''s Hard Court Tennis Shoes MRP : â¹ 9 695.00 Nike Vapor 12 Women''s Hard Court Tennis Shoes MRP : â¹ 15 995.00 NikeCourt Slam Men''s Dri-FIT ADV Tank Top MRP : â¹ 4 495.00 NikeCourt Slam Women''s Dri-FIT High-Waisted Tennis Skirt MRP : â¹ 3 995.00 NikeCourt Slam Women''s Tank Top MRP : â¹ 4 495.00 Nike Zoom GP Challenge 1.5 PRM Women''s Hard Court Tennis Shoes MRP : â¹ 14 995.00',
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
        '1.00,1.00,1.00,1.00',
        '1.00,1.00,1.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.12,0.12,0.16,1.00',
        '1.00,1.00,1.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.78,0.39,0.49,1.00',
        '1.00,1.00,1.00,1.00',
        '0.12,0.12,0.16,1.00',
        '1.00,1.00,1.00,1.00',
        60,
        1,
        300,
        250,
        20,
        3,
        '',
        'https://static.nike.com/a/images/q_auto:eco/t_product_v1/f_auto/dpr_1.0/h_594,c_limit/cbddbaeb-68b8-437b-a5a0-25a85c1d4aaf/gp-challenge-pro-hard-court-tennis-shoes-3hxffJQG.png',
        FALSE,
        '{"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(0,0,0)", "boxShadow": "none", "padding": "10px 20px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        NULL,
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat", "backgroundSize": "auto", "backgroundImage": "none"}, "position": {"position": "static", "top": "auto", "left": "auto", "right": "auto", "bottom": "auto", "zIndex": "auto"}, "typography": {"fontFamily": "system-ui"}}'
    );


    -- Section 3: Shop by Sport Nike. Just Do It Running  Nike. Just
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
        2,
        1,
        'Shop by Sport Nike. Just Do It Running  Nike. Just',
        'shop-by-sport-nike-just-do-it-running-nike-just',
        881,
        3953,
        'Shop by Sport Nike. Just Do It Running  Nike. Just Do It Football Nike. Just Do It Basketball Nike. ',
        '',
        'Shop by Sport Nike. Just Do It Running  Nike. Just Do It Football Nike. Just Do It Basketball Nike. Just Do It Gym & Training Nike. Just Do It Yoga Nike. Just Do It Golf Nike. Just Do It Tennis Nike. Just Do It Skateboarding',
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
        '1.00,1.00,1.00,1.00',
        '1.00,1.00,1.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.18,0.18,0.22,1.00',
        '1.00,1.00,1.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.78,0.39,0.49,1.00',
        '1.00,1.00,1.00,1.00',
        '0.18,0.18,0.22,1.00',
        '1.00,1.00,1.00,1.00',
        60,
        1,
        300,
        250,
        20,
        3,
        '',
        'https://static.nike.com/a/images/f_auto/dpr_1.0,cs_srgb/h_710,c_limit/1f6dcd2f-749b-412d-938b-abac8e505a10/nike-just-do-it.png',
        FALSE,
        '{"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(0,0,0)", "boxShadow": "none", "padding": "10px 20px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        NULL,
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat", "backgroundSize": "auto", "backgroundImage": "none"}, "position": {"position": "static", "top": "auto", "left": "auto", "right": "auto", "bottom": "auto", "zIndex": "auto"}, "typography": {"fontFamily": "system-ui"}}'
    );


    -- Section 4: Details 
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
        3,
        1,
        'Details ',
        'details',
        577,
        5533,
        'Details ',
        ':host summary {',
        'Details  :host summary {   display: list-item;   counter-increment: list-item 0;   list-style: disclosure-closed inside; } :host([open]) summary {   list-style-type: disclosure-open; }  Resources Find A Store Become A Member Running Shoe Finder Product Advice Nike Coaching Send Us Feedback Details  :host summary {   display: list-item;   counter-increment: list-item 0;   list-style: disclosure-closed inside; } :host([open]) summary {   list-style-type: disclosure-open; }  Help Get Help Order Sta',
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
        '1.00,1.00,1.00,1.00',
        '1.00,1.00,1.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.12,0.12,0.16,1.00',
        '1.00,1.00,1.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.78,0.39,0.49,1.00',
        '1.00,1.00,1.00,1.00',
        '0.12,0.12,0.16,1.00',
        '1.00,1.00,1.00,1.00',
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
-- Template name: nike_stealth_import
-- Total sections: 4
--
-- To verify the import:
-- SELECT * FROM templates WHERE template_name = 'nike_stealth_import';
-- SELECT COUNT(*) FROM sections WHERE template_id = (SELECT id FROM templates WHERE template_name = 'nike_stealth_import');

-- Update sections with BYTEA image data
