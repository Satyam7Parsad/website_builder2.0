-- Import Scraped Template: imported_awwwards_com_1768361371
-- Generated: 2026-01-14 09:04:32
-- Source: https://www.awwwards.com
-- Sections: 12
--
-- Run this script to import the template into PostgreSQL:
-- psql -d website_builder < imported_awwwards_com_1768361371.sql
--


BEGIN;

-- Insert the template
INSERT INTO templates (template_name, description, project_name, created_date)
VALUES (
    'imported_awwwards_com_1768361371',
    'Imported from https://www.awwwards.com',
    'Imported Awwwards Com 1768361371',
    '2026-01-14 09:04:32'
);


-- Get the template ID
DO $$
DECLARE
    template_id_var integer;
BEGIN
    SELECT id INTO template_id_var FROM templates WHERE template_name = 'imported_awwwards_com_1768361371';


    -- Section 1: 
    INSERT INTO sections (
        template_id, section_order, type, name, section_id, height, y_position,
        title, subtitle, content, button_text, button_link,
        title_font_size, subtitle_font_size, content_font_size,
        title_font_weight, subtitle_font_weight, content_font_weight,
        button_font_size, button_font_weight, nav_font_size, nav_font_weight,
        title_color, subtitle_color, content_color, bg_color, text_color,
        accent_color, button_bg_color, button_text_color,
        padding, text_align, card_width, card_height, card_spacing, cards_per_row,
        background_image, section_image, use_bg_image
    ) VALUES (
        template_id_var,
        0,
        8,
        '',
        '',
        54,
        58,
        '',
        '',
        '',
        '',
        'https://www.awwwards.com/',
        42,
        30,
        16,
        700,
        400,
        400,
        14,
        400,
        15,
        500,
        '0.13,0.13,0.13,1.00',
        '0.13,0.13,0.13,1.00',
        '0.13,0.13,0.13,1.00',
        '0.91,0.91,0.91,1.00',
        '0.13,0.13,0.13,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.13,0.13,0.13,1.00',
        40,
        1,
        300,
        250,
        20,
        3,
        '',
        '',
        FALSE
    );


    -- Section 2: Site of the Day                                 Jan 13, 2026                                 Score 7
    INSERT INTO sections (
        template_id, section_order, type, name, section_id, height, y_position,
        title, subtitle, content, button_text, button_link,
        title_font_size, subtitle_font_size, content_font_size,
        title_font_weight, subtitle_font_weight, content_font_weight,
        button_font_size, button_font_weight, nav_font_size, nav_font_weight,
        title_color, subtitle_color, content_color, bg_color, text_color,
        accent_color, button_bg_color, button_text_color,
        padding, text_align, card_width, card_height, card_spacing, cards_per_row,
        background_image, section_image, use_bg_image
    ) VALUES (
        template_id_var,
        1,
        8,
        'Site of the Day                                 Jan 13, 2026                                 Score 7',
        'site-of-the-day-jan-13-2026-score-7',
        208,
        111,
        'Site of the Day                                 Jan 13, 2026                                 Score 7.37 of 10',
        '',
        '',
        'Collections',
        'https://www.awwwards.com/collections/',
        14,
        2,
        16,
        400,
        400,
        400,
        14,
        400,
        15,
        500,
        '0.13,0.13,0.13,1.00',
        '0.13,0.13,0.13,1.00',
        '0.13,0.13,0.13,1.00',
        '0.91,0.91,0.91,1.00',
        '0.13,0.13,0.13,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.13,0.13,0.13,1.00',
        120,
        1,
        300,
        250,
        40,
        3,
        '',
        '',
        FALSE
    );


    -- Section 3: 
    INSERT INTO sections (
        template_id, section_order, type, name, section_id, height, y_position,
        title, subtitle, content, button_text, button_link,
        title_font_size, subtitle_font_size, content_font_size,
        title_font_weight, subtitle_font_weight, content_font_weight,
        button_font_size, button_font_weight, nav_font_size, nav_font_weight,
        title_color, subtitle_color, content_color, bg_color, text_color,
        accent_color, button_bg_color, button_text_color,
        padding, text_align, card_width, card_height, card_spacing, cards_per_row,
        background_image, section_image, use_bg_image
    ) VALUES (
        template_id_var,
        2,
        2,
        '',
        '',
        138,
        1124,
        '',
        '',
        '',
        '',
        'https://www.awwwards.com/academy/course/innovative-web-design-in-figma-a-step-by-step-process',
        42,
        30,
        16,
        700,
        400,
        400,
        13,
        300,
        15,
        500,
        '0.00,0.00,0.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.13,0.13,0.13,1.00',
        120,
        1,
        300,
        250,
        20,
        3,
        '',
        '',
        FALSE
    );


    -- Section 4: Latest
    INSERT INTO sections (
        template_id, section_order, type, name, section_id, height, y_position,
        title, subtitle, content, button_text, button_link,
        title_font_size, subtitle_font_size, content_font_size,
        title_font_weight, subtitle_font_weight, content_font_weight,
        button_font_size, button_font_weight, nav_font_size, nav_font_weight,
        title_color, subtitle_color, content_color, bg_color, text_color,
        accent_color, button_bg_color, button_text_color,
        padding, text_align, card_width, card_height, card_spacing, cards_per_row,
        background_image, section_image, use_bg_image
    ) VALUES (
        template_id_var,
        3,
        3,
        'Latest',
        'latest',
        999,
        1873,
        'Latest',
        'Granyon - Designing for Good',
        '',
        '',
        'https://www.awwwards.com/sites/granyon-designing-for-good',
        14,
        2,
        16,
        400,
        400,
        400,
        22,
        300,
        15,
        500,
        '0.13,0.13,0.13,1.00',
        '0.13,0.13,0.13,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.13,0.13,0.13,1.00',
        120,
        1,
        800,
        1000,
        40,
        3,
        '',
        'scraped_images/imported_awwwards_com_1768361371/img_20.png',
        FALSE
    );


    -- Section 5: Winners
    INSERT INTO sections (
        template_id, section_order, type, name, section_id, height, y_position,
        title, subtitle, content, button_text, button_link,
        title_font_size, subtitle_font_size, content_font_size,
        title_font_weight, subtitle_font_weight, content_font_weight,
        button_font_size, button_font_weight, nav_font_size, nav_font_weight,
        title_color, subtitle_color, content_color, bg_color, text_color,
        accent_color, button_bg_color, button_text_color,
        padding, text_align, card_width, card_height, card_spacing, cards_per_row,
        background_image, section_image, use_bg_image
    ) VALUES (
        template_id_var,
        4,
        3,
        'Winners',
        'winners',
        1396,
        3072,
        'Winners',
        'Lightship',
        '',
        '',
        'https://www.awwwards.com/sites/lightship-1',
        14,
        2,
        16,
        400,
        400,
        400,
        22,
        300,
        15,
        500,
        '0.13,0.13,0.13,1.00',
        '0.13,0.13,0.13,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.13,0.13,0.13,1.00',
        120,
        1,
        800,
        1000,
        40,
        3,
        '',
        'scraped_images/imported_awwwards_com_1768361371/img_14.jpg',
        FALSE
    );


    -- Section 6: Academy
    INSERT INTO sections (
        template_id, section_order, type, name, section_id, height, y_position,
        title, subtitle, content, button_text, button_link,
        title_font_size, subtitle_font_size, content_font_size,
        title_font_weight, subtitle_font_weight, content_font_weight,
        button_font_size, button_font_weight, nav_font_size, nav_font_weight,
        title_color, subtitle_color, content_color, bg_color, text_color,
        accent_color, button_bg_color, button_text_color,
        padding, text_align, card_width, card_height, card_spacing, cards_per_row,
        background_image, section_image, use_bg_image
    ) VALUES (
        template_id_var,
        5,
        3,
        'Academy',
        'academy',
        933,
        4668,
        'Academy',
        'Learn UI Design with Figma from Scratch',
        '',
        '',
        'https://www.awwwards.com/academy/course/ui-design-for-beginners-with-figma',
        14,
        2,
        16,
        400,
        400,
        400,
        15,
        300,
        15,
        500,
        '0.13,0.13,0.13,1.00',
        '0.13,0.13,0.13,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.13,0.13,0.13,1.00',
        120,
        1,
        800,
        1000,
        40,
        3,
        '',
        '',
        FALSE
    );


    -- Section 7: Collections
    INSERT INTO sections (
        template_id, section_order, type, name, section_id, height, y_position,
        title, subtitle, content, button_text, button_link,
        title_font_size, subtitle_font_size, content_font_size,
        title_font_weight, subtitle_font_weight, content_font_weight,
        button_font_size, button_font_weight, nav_font_size, nav_font_weight,
        title_color, subtitle_color, content_color, bg_color, text_color,
        accent_color, button_bg_color, button_text_color,
        padding, text_align, card_width, card_height, card_spacing, cards_per_row,
        background_image, section_image, use_bg_image
    ) VALUES (
        template_id_var,
        6,
        3,
        'Collections',
        'collections',
        1067,
        5801,
        'Collections',
        'Transitions',
        '',
        '',
        'https://www.awwwards.com/awwwards/collections/transitions/',
        14,
        2,
        16,
        400,
        400,
        400,
        22,
        300,
        15,
        500,
        '0.13,0.13,0.13,1.00',
        '0.13,0.13,0.13,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.13,0.13,0.13,1.00',
        120,
        1,
        800,
        1000,
        40,
        3,
        '',
        'scraped_images/imported_awwwards_com_1768361371/img_2.jpg',
        FALSE
    );


    -- Section 8: Directory
    INSERT INTO sections (
        template_id, section_order, type, name, section_id, height, y_position,
        title, subtitle, content, button_text, button_link,
        title_font_size, subtitle_font_size, content_font_size,
        title_font_weight, subtitle_font_weight, content_font_weight,
        button_font_size, button_font_weight, nav_font_size, nav_font_weight,
        title_color, subtitle_color, content_color, bg_color, text_color,
        accent_color, button_bg_color, button_text_color,
        padding, text_align, card_width, card_height, card_spacing, cards_per_row,
        background_image, section_image, use_bg_image
    ) VALUES (
        template_id_var,
        7,
        3,
        'Directory',
        'directory',
        1658,
        7069,
        'Directory',
        'Merlin',
        'International International International',
        '',
        'https://www.awwwards.com/MerlinStudio/',
        14,
        2,
        15,
        400,
        400,
        300,
        22,
        300,
        15,
        500,
        '0.13,0.13,0.13,1.00',
        '0.13,0.13,0.13,1.00',
        '1.00,1.00,1.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '1.00,1.00,1.00,1.00',
        120,
        1,
        800,
        1000,
        40,
        3,
        '',
        'scraped_images/imported_awwwards_com_1768361371/img_24.png',
        FALSE
    );


    -- Section 9: Blog
    INSERT INTO sections (
        template_id, section_order, type, name, section_id, height, y_position,
        title, subtitle, content, button_text, button_link,
        title_font_size, subtitle_font_size, content_font_size,
        title_font_weight, subtitle_font_weight, content_font_weight,
        button_font_size, button_font_weight, nav_font_size, nav_font_weight,
        title_color, subtitle_color, content_color, bg_color, text_color,
        accent_color, button_bg_color, button_text_color,
        padding, text_align, card_width, card_height, card_spacing, cards_per_row,
        background_image, section_image, use_bg_image
    ) VALUES (
        template_id_var,
        8,
        3,
        'Blog',
        'blog',
        918,
        8928,
        'Blog',
        'Shopify vs WooCommerce: What''s the better?',
        '',
        '',
        'https://www.awwwards.com/shopify-vs-woocommerce.html',
        14,
        2,
        16,
        400,
        400,
        400,
        14,
        300,
        15,
        500,
        '0.13,0.13,0.13,1.00',
        '0.13,0.13,0.13,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.13,0.13,0.13,1.00',
        120,
        1,
        800,
        1000,
        40,
        3,
        '',
        'scraped_images/imported_awwwards_com_1768361371/img_18.jpg',
        FALSE
    );


    -- Section 10: Market
    INSERT INTO sections (
        template_id, section_order, type, name, section_id, height, y_position,
        title, subtitle, content, button_text, button_link,
        title_font_size, subtitle_font_size, content_font_size,
        title_font_weight, subtitle_font_weight, content_font_weight,
        button_font_size, button_font_weight, nav_font_size, nav_font_weight,
        title_color, subtitle_color, content_color, bg_color, text_color,
        accent_color, button_bg_color, button_text_color,
        padding, text_align, card_width, card_height, card_spacing, cards_per_row,
        background_image, section_image, use_bg_image
    ) VALUES (
        template_id_var,
        9,
        3,
        'Market',
        'market',
        1047,
        10047,
        'Market',
        'Roundsite — Professional & SaaS Webflow Template',
        '',
        '',
        'https://www.awwwards.com/market/product_6964a4be25755947633443',
        14,
        2,
        16,
        400,
        400,
        400,
        15,
        300,
        15,
        500,
        '0.13,0.13,0.13,1.00',
        '0.13,0.13,0.13,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.13,0.13,0.13,1.00',
        120,
        1,
        800,
        1000,
        40,
        3,
        '',
        '',
        FALSE
    );


    -- Section 11: Submit your website for visibility and recognition
    INSERT INTO sections (
        template_id, section_order, type, name, section_id, height, y_position,
        title, subtitle, content, button_text, button_link,
        title_font_size, subtitle_font_size, content_font_size,
        title_font_weight, subtitle_font_weight, content_font_weight,
        button_font_size, button_font_weight, nav_font_size, nav_font_weight,
        title_color, subtitle_color, content_color, bg_color, text_color,
        accent_color, button_bg_color, button_text_color,
        padding, text_align, card_width, card_height, card_spacing, cards_per_row,
        background_image, section_image, use_bg_image
    ) VALUES (
        template_id_var,
        10,
        3,
        'Submit your website for visibility and recognition',
        'submit-your-website-for-visibility-and-recognition',
        558,
        11295,
        'Submit your website for visibility and recognition',
        '',
        'Share your work Be a member',
        'Submit Website',
        'https://www.awwwards.com/submit/',
        50,
        38,
        14,
        600,
        400,
        300,
        18,
        400,
        15,
        500,
        '1.00,1.00,1.00,1.00',
        '1.00,1.00,1.00,1.00',
        '1.00,1.00,1.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '1.00,1.00,1.00,1.00',
        120,
        1,
        800,
        1000,
        40,
        3,
        '',
        'scraped_images/imported_awwwards_com_1768361371/img_34.jpg',
        FALSE
    );


    -- Section 12: 
    INSERT INTO sections (
        template_id, section_order, type, name, section_id, height, y_position,
        title, subtitle, content, button_text, button_link,
        title_font_size, subtitle_font_size, content_font_size,
        title_font_weight, subtitle_font_weight, content_font_weight,
        button_font_size, button_font_weight, nav_font_size, nav_font_weight,
        title_color, subtitle_color, content_color, bg_color, text_color,
        accent_color, button_bg_color, button_text_color,
        padding, text_align, card_width, card_height, card_spacing, cards_per_row,
        background_image, section_image, use_bg_image
    ) VALUES (
        template_id_var,
        11,
        3,
        '',
        '',
        433,
        12053,
        '',
        '',
        '',
        'Websites',
        'https://www.awwwards.com/websites/',
        42,
        30,
        16,
        700,
        400,
        400,
        14,
        600,
        15,
        500,
        '0.00,0.00,0.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.13,0.13,0.13,1.00',
        80,
        1,
        800,
        1000,
        40,
        3,
        '',
        '',
        FALSE
    );

END $$;













COMMIT;


-- Template import complete!
-- Template name: imported_awwwards_com_1768361371
-- Total sections: 12
--
-- To verify the import:
-- SELECT * FROM templates WHERE template_name = 'imported_awwwards_com_1768361371';
-- SELECT COUNT(*) FROM sections WHERE template_id = (SELECT id FROM templates WHERE template_name = 'imported_awwwards_com_1768361371');
