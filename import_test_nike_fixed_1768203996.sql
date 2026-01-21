-- Import Scraped Template: test_nike_fixed_1768203996
-- Generated: 2026-01-12 13:26:30
-- Source: https://www.nike.com/in/
-- Sections: 9
--
-- Run this script to import the template into PostgreSQL:
-- psql -d website_builder < test_nike_fixed_1768203996.sql
--


BEGIN;

-- Insert the template
INSERT INTO templates (template_name, description, project_name, created_date)
VALUES (
    'test_nike_fixed_1768203996',
    'Imported from www.nike.com',
    'Test Nike Fixed 1768203996',
    '2026-01-12 13:26:30'
);


-- Get the template ID
DO $$
DECLARE
    template_id_var integer;
BEGIN
    SELECT id INTO template_id_var FROM templates WHERE template_name = 'test_nike_fixed_1768203996';


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
        3,
        '',
        '',
        96,
        0,
        '',
        '',
        'Find a Store Help Help',
        '',
        '',
        42,
        20,
        12,
        700,
        400,
        500,
        16,
        600,
        15,
        500,
        '0.1,0.1,0.1,1.0',
        '0.3,0.3,0.3,1.0',
        '0.07,0.07,0.07,1.00',
        '1.00,1.00,1.00,1.00',
        '0.07,0.07,0.07,1.00',
        '0.8,0.4,0.5,1.0',
        '0.8,0.4,0.5,1.0',
        '1.0,1.0,1.0,1.0',
        60,
        1,
        800,
        1000,
        40,
        3,
        '',
        '',
        FALSE
    );


    -- Section 2: 
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
        3,
        '',
        '',
        700,
        154,
        '',
        '',
        'This is a modal window. Beginning of dialog window. Escape will cancel and close the window. End of dialog window.',
        '',
        '',
        42,
        20,
        16,
        700,
        400,
        400,
        16,
        600,
        15,
        500,
        '0.1,0.1,0.1,1.0',
        '0.3,0.3,0.3,1.0',
        '1.00,1.00,1.00,1.00',
        '0.96,0.96,0.96,1.00',
        '0.07,0.07,0.07,1.00',
        '0.8,0.4,0.5,1.0',
        '0.8,0.4,0.5,1.0',
        '1.0,1.0,1.0,1.0',
        60,
        1,
        800,
        1000,
        40,
        3,
        '',
        '',
        FALSE
    );


    -- Section 3: Featured
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
        3,
        'Featured',
        'featured',
        1078,
        938,
        'Featured',
        'Optimal Stability',
        'Structure 26 Luka 5 ‘Venom’',
        '',
        '',
        32,
        20,
        16,
        500,
        400,
        500,
        16,
        600,
        15,
        500,
        '0.07,0.07,0.07,1.00',
        '0.3,0.3,0.3,1.0',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,0.00',
        '0.07,0.07,0.07,1.00',
        '0.8,0.4,0.5,1.0',
        '0.8,0.4,0.5,1.0',
        '1.0,1.0,1.0,1.0',
        60,
        1,
        800,
        1000,
        40,
        3,
        '',
        'scraped_images/test_nike_fixed_1768203996/img_2.jpg',
        FALSE
    );


    -- Section 4: 
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
        '',
        '',
        1009,
        2016,
        '',
        'Nike Star Runner 5',
        '',
        '',
        '',
        42,
        24,
        16,
        700,
        500,
        400,
        16,
        600,
        15,
        500,
        '0.1,0.1,0.1,1.0',
        '1.00,1.00,1.00,1.00',
        '0.2,0.2,0.2,1.0',
        '0.00,0.00,0.00,0.00',
        '0.07,0.07,0.07,1.00',
        '0.8,0.4,0.5,1.0',
        '0.8,0.4,0.5,1.0',
        '1.0,1.0,1.0,1.0',
        60,
        1,
        800,
        1000,
        40,
        3,
        '',
        'scraped_images/test_nike_fixed_1768203996/img_3.jpg',
        FALSE
    );


    -- Section 5: Court Styles
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
        1,
        'Court Styles',
        'court-styles',
        766,
        3109,
        'Court Styles',
        'MRP : ₹ 15 995.00',
        '',
        '',
        '',
        32,
        16,
        16,
        500,
        500,
        400,
        16,
        600,
        15,
        500,
        '0.07,0.07,0.07,1.00',
        '0.07,0.07,0.07,1.00',
        '0.2,0.2,0.2,1.0',
        '0.00,0.00,0.00,0.00',
        '0.00,0.00,0.00,0.00',
        '0.8,0.4,0.5,1.0',
        '0.8,0.4,0.5,1.0',
        '1.0,1.0,1.0,1.0',
        60,
        1,
        300,
        250,
        20,
        3,
        '',
        'scraped_images/test_nike_fixed_1768203996/img_4.jpg',
        FALSE
    );


    -- Section 6: Shop by Sport
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
        'Shop by Sport',
        'shop-by-sport',
        867,
        3959,
        'Shop by Sport',
        'Running',
        '',
        '',
        '',
        32,
        24,
        16,
        500,
        500,
        400,
        16,
        600,
        15,
        500,
        '0.07,0.07,0.07,1.00',
        '0.07,0.07,0.07,1.00',
        '0.2,0.2,0.2,1.0',
        '0.00,0.00,0.00,0.00',
        '0.07,0.07,0.07,1.00',
        '0.8,0.4,0.5,1.0',
        '0.8,0.4,0.5,1.0',
        '1.0,1.0,1.0,1.0',
        60,
        1,
        800,
        1000,
        40,
        3,
        '',
        'scraped_images/test_nike_fixed_1768203996/img_5.jpg',
        FALSE
    );


    -- Section 7: SPOTLIGHT
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
        'SPOTLIGHT',
        'spotlight',
        118,
        4910,
        'SPOTLIGHT',
        '',
        'Classic silhouettes and cutting-edge innovation to build your game from the ground up.',
        '',
        '',
        96,
        20,
        12,
        500,
        400,
        500,
        16,
        600,
        15,
        500,
        '0.07,0.07,0.07,1.00',
        '0.3,0.3,0.3,1.0',
        '0.07,0.07,0.07,1.00',
        '0.00,0.00,0.00,0.00',
        '0.07,0.07,0.07,1.00',
        '0.8,0.4,0.5,1.0',
        '0.8,0.4,0.5,1.0',
        '1.0,1.0,1.0,1.0',
        60,
        1,
        800,
        1000,
        40,
        3,
        '',
        '',
        FALSE
    );


    -- Section 8: 
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
        '',
        '',
        356,
        5112,
        '',
        '',
        '',
        '',
        '',
        42,
        20,
        16,
        700,
        400,
        400,
        16,
        600,
        15,
        500,
        '0.1,0.1,0.1,1.0',
        '0.3,0.3,0.3,1.0',
        '0.2,0.2,0.2,1.0',
        '0.00,0.00,0.00,0.00',
        '0.07,0.07,0.07,1.00',
        '0.8,0.4,0.5,1.0',
        '0.8,0.4,0.5,1.0',
        '1.0,1.0,1.0,1.0',
        60,
        1,
        800,
        1000,
        40,
        3,
        '',
        'scraped_images/test_nike_fixed_1768203996/img_7.png',
        FALSE
    );


    -- Section 9: Resources
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
        10,
        'Resources',
        'resources',
        577,
        5524,
        'Resources',
        '',
        'Resources Find A Store Become A Member',
        '',
        '',
        14,
        20,
        14,
        500,
        400,
        500,
        16,
        600,
        15,
        500,
        '0.07,0.07,0.07,1.00',
        '0.3,0.3,0.3,1.0',
        '0.07,0.07,0.07,1.00',
        '1.00,1.00,1.00,1.00',
        '0.07,0.07,0.07,1.00',
        '0.8,0.4,0.5,1.0',
        '0.8,0.4,0.5,1.0',
        '1.0,1.0,1.0,1.0',
        60,
        1,
        300,
        250,
        20,
        3,
        '',
        '',
        FALSE
    );

END $$;


-- Enhanced data for Section 1
UPDATE sections
SET type_name = 'text-stack',
    use_legacy_type = FALSE
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'test_nike_fixed_1768203996')
  AND section_order = 0;


-- Enhanced data for Section 2
UPDATE sections
SET type_name = 'text-stack',
    use_legacy_type = FALSE
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'test_nike_fixed_1768203996')
  AND section_order = 1;


-- Enhanced data for Section 3
UPDATE sections
SET type_name = 'text-stack',
    use_legacy_type = FALSE
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'test_nike_fixed_1768203996')
  AND section_order = 2;


-- Enhanced data for Section 4
UPDATE sections
SET type_name = 'text-stack',
    use_legacy_type = FALSE
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'test_nike_fixed_1768203996')
  AND section_order = 3;


-- Enhanced data for Section 5
UPDATE sections
SET type_name = 'text-stack',
    use_legacy_type = FALSE
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'test_nike_fixed_1768203996')
  AND section_order = 4;


-- Enhanced data for Section 6
UPDATE sections
SET type_name = 'text-stack',
    use_legacy_type = FALSE
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'test_nike_fixed_1768203996')
  AND section_order = 5;


-- Enhanced data for Section 7
UPDATE sections
SET type_name = 'text-stack',
    use_legacy_type = FALSE
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'test_nike_fixed_1768203996')
  AND section_order = 6;


-- Enhanced data for Section 8
UPDATE sections
SET type_name = 'image-stack',
    use_legacy_type = FALSE
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'test_nike_fixed_1768203996')
  AND section_order = 7;


-- Enhanced data for Section 9
UPDATE sections
SET type_name = 'text-stack',
    use_legacy_type = FALSE
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'test_nike_fixed_1768203996')
  AND section_order = 8;

COMMIT;


-- Template import complete!
-- Template name: test_nike_fixed_1768203996
-- Total sections: 9
--
-- To verify the import:
-- SELECT * FROM templates WHERE template_name = 'test_nike_fixed_1768203996';
-- SELECT COUNT(*) FROM sections WHERE template_id = (SELECT id FROM templates WHERE template_name = 'test_nike_fixed_1768203996');
