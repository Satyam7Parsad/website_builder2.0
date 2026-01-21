-- Import Scraped Template: test_wix_1768360845
-- Generated: 2026-01-14 08:51:30
-- Source: https://www.wix.com/website/templates
-- Sections: 4
--
-- Run this script to import the template into PostgreSQL:
-- psql -d website_builder < test_wix_1768360845.sql
--


BEGIN;

-- Insert the template
INSERT INTO templates (template_name, description, project_name, created_date)
VALUES (
    'test_wix_1768360845',
    'Imported from https://www.wix.com/website/templates',
    'Test Wix 1768360845',
    '2026-01-14 08:51:30'
);


-- Get the template ID
DO $$
DECLARE
    template_id_var integer;
BEGIN
    SELECT id INTO template_id_var FROM templates WHERE template_name = 'test_wix_1768360845';


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
        71,
        0,
        '',
        'Description:',
        'Good For: High-Tech startups and mobility companies Description:',
        '',
        'https://www.wix.com/',
        36,
        24,
        14,
        400,
        400,
        700,
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
        '0.00,0.00,0.00,1.00',
        80,
        1,
        300,
        250,
        20,
        3,
        '',
        'scraped_images/test_wix_1768360845/img_1.jpg',
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
        8,
        '',
        '',
        54,
        330,
        '',
        '',
        '',
        'All TemplatesAll',
        'https://www.wix.com/website/templates',
        42,
        30,
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
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.30,0.20,0.87,1.00',
        240,
        1,
        300,
        250,
        80,
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
        8,
        '',
        '',
        172,
        2196,
        '',
        '',
        '',
        '2',
        'https://www.wix.com/website/templates/html/all/2',
        42,
        30,
        16,
        700,
        400,
        400,
        24,
        400,
        15,
        500,
        '0.00,0.00,0.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.00,0.00,0.00,1.00',
        240,
        1,
        300,
        250,
        80,
        3,
        '',
        '',
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
        620,
        2368,
        '',
        '',
        'Product Solutions Learn',
        'Website Templates',
        'https://www.wix.com/website/templates',
        42,
        30,
        16,
        700,
        400,
        500,
        14,
        400,
        15,
        500,
        '0.00,0.00,0.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.00,0.00,0.00,1.00',
        240,
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
-- Template name: test_wix_1768360845
-- Total sections: 4
--
-- To verify the import:
-- SELECT * FROM templates WHERE template_name = 'test_wix_1768360845';
-- SELECT COUNT(*) FROM sections WHERE template_id = (SELECT id FROM templates WHERE template_name = 'test_wix_1768360845');

-- Update sections with BYTEA image data


UPDATE sections
SET section_image_data = E'\\x47494638396101000100800000ffffff00000021f90409000001002c00000000010001000002024c01003b'
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'test_wix_1768360845')
  AND section_order = 0;
