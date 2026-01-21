-- Import Scraped Template: stripe_flexbox_test
-- Generated: 2026-01-10 22:45:28
-- Source: https://stripe.com
-- Sections: 27
--
-- Run this script to import the template into PostgreSQL:
-- psql -d website_builder < stripe_flexbox_test.sql
--


BEGIN;

-- Insert the template
INSERT INTO templates (template_name, description, project_name, created_date)
VALUES (
    'stripe_flexbox_test',
    'Imported from stripe.com',
    'Stripe Flexbox Test',
    '2026-01-10 22:45:28'
);


-- Get the template ID
DO $$
DECLARE
    template_id_var integer;
BEGIN
    SELECT id INTO template_id_var FROM templates WHERE template_name = 'stripe_flexbox_test';


    -- Section 1: Financial infrastructure to grow your revenue
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
        0,
        'Financial infrastructure to grow your revenue',
        'financial-infrastructure-to-grow-your-revenue',
        901,
        0,
        'Financial infrastructure to grow your revenue',
        '',
        '',
        '',
        '',
        94,
        20,
        16,
        500,
        400,
        400,
        16,
        600,
        15,
        500,
        '0.74,0.78,0.82,1.00',
        '0.3,0.3,0.3,1.0',
        '0.2,0.2,0.2,1.0',
        '0.00,0.00,0.00,0.00',
        '0.26,0.33,0.40,1.00',
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


    -- Section 2: Stripe logo
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
        'Stripe logo',
        'stripe-logo',
        68,
        0,
        'Stripe logo',
        'More',
        'Online payments In-person payments Fraud prevention',
        '',
        '',
        32,
        13,
        16,
        700,
        425,
        300,
        16,
        600,
        15,
        500,
        '0.26,0.33,0.40,1.00',
        '0.04,0.15,0.25,1.00',
        '0.04,0.15,0.25,1.00',
        '0.00,0.00,0.00,0.00',
        '0.26,0.33,0.40,1.00',
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
        3,
        '',
        '',
        250,
        901,
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
        '0.26,0.33,0.40,1.00',
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


    -- Section 4: Support for any business type
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
        'Support for any business type',
        'support-for-any-business-type',
        4452,
        1151,
        'Support for any business type',
        '',
        '',
        '',
        '',
        56,
        20,
        16,
        500,
        400,
        400,
        16,
        600,
        15,
        500,
        '0.04,0.15,0.25,1.00',
        '0.3,0.3,0.3,1.0',
        '0.2,0.2,0.2,1.0',
        '0.00,0.00,0.00,0.00',
        '0.26,0.33,0.40,1.00',
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


    -- Section 5: Ready to get started?
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
        'Ready to get started?',
        'ready-to-get-started',
        4452,
        1151,
        'Ready to get started?',
        '',
        'Create an account instantly to get started or contact us to design a custom package for your business.',
        '',
        '',
        56,
        20,
        16,
        500,
        400,
        300,
        16,
        600,
        15,
        500,
        '0.04,0.15,0.25,1.00',
        '0.3,0.3,0.3,1.0',
        '0.04,0.15,0.25,1.00',
        '0.00,0.00,0.00,0.00',
        '0.26,0.33,0.40,1.00',
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


    -- Section 6: 
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
        '',
        '',
        434,
        1310,
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
        '1.00,1.00,1.00,1.00',
        '0.26,0.33,0.40,1.00',
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


    -- Section 7: 
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
        '',
        '',
        434,
        1310,
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
        '1.00,1.00,1.00,1.00',
        '0.26,0.33,0.40,1.00',
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
        2,
        '',
        '',
        217,
        1395,
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
        '0.26,0.33,0.40,1.00',
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


    -- Section 9: 
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
        2,
        '',
        '',
        217,
        1395,
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
        '0.26,0.33,0.40,1.00',
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


    -- Section 10: 
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
        2,
        '',
        '',
        217,
        1395,
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
        '0.26,0.33,0.40,1.00',
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


    -- Section 11: 
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
        2,
        '',
        '',
        217,
        1395,
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
        '0.26,0.33,0.40,1.00',
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
        2,
        '',
        '',
        217,
        1395,
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
        '0.26,0.33,0.40,1.00',
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


    -- Section 13: 
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
        12,
        2,
        '',
        '',
        217,
        1395,
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
        '0.26,0.33,0.40,1.00',
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


    -- Section 14: 
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
        13,
        2,
        '',
        '',
        217,
        1395,
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
        '0.26,0.33,0.40,1.00',
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


    -- Section 15: 
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
        14,
        2,
        '',
        '',
        217,
        1395,
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
        '0.26,0.33,0.40,1.00',
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


    -- Section 16: 
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
        15,
        2,
        '',
        '',
        217,
        1395,
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
        '0.26,0.33,0.40,1.00',
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


    -- Section 17: 
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
        16,
        2,
        '',
        '',
        217,
        1395,
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
        '0.26,0.33,0.40,1.00',
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


    -- Section 18: 
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
        17,
        2,
        '',
        '',
        217,
        1395,
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
        '0.26,0.33,0.40,1.00',
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


    -- Section 19: 
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
        18,
        2,
        '',
        '',
        217,
        1395,
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
        '0.26,0.33,0.40,1.00',
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


    -- Section 20: The backbone for global commerce
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
        19,
        3,
        'The backbone for global commerce',
        'the-backbone-for-global-commerce',
        911,
        5399,
        'The backbone for global commerce',
        'Global scale',
        '',
        '',
        '',
        56,
        18,
        16,
        500,
        500,
        400,
        16,
        600,
        15,
        500,
        '0.04,0.15,0.25,1.00',
        '0.39,0.36,1.00,1.00',
        '0.2,0.2,0.2,1.0',
        '0.00,0.00,0.00,0.00',
        '0.68,0.74,0.80,1.00',
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


    -- Section 21: Bring agility to your enterprise
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
        20,
        3,
        'Bring agility to your enterprise',
        'bring-agility-to-your-enterprise',
        1163,
        7202,
        'Bring agility to your enterprise',
        'Enterprise reinvention',
        'Quickly build great payments experiences, improve performance, expand into new markets, and engage customers with subscriptions and marketplaces. Get expert integration guidance from ourprofessional servicesteam andcertified partners, and connect Stripe to Salesforce, SAP, and more through theStripe App Marketplace.',
        '',
        '',
        56,
        18,
        16,
        500,
        500,
        300,
        16,
        600,
        15,
        500,
        '0.04,0.15,0.25,1.00',
        '0.39,0.36,1.00,1.00',
        '0.04,0.15,0.25,1.00',
        '0.00,0.00,0.00,0.00',
        '0.26,0.33,0.40,1.00',
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
        'scraped_images/stripe_flexbox_test/img_20.png',
        FALSE
    );


    -- Section 22: 
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
        21,
        2,
        '',
        '',
        272,
        8993,
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
        '1.00,1.00,1.00,1.00',
        '0.26,0.33,0.40,1.00',
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
        'scraped_images/stripe_flexbox_test/img_21.png',
        FALSE
    );


    -- Section 23: Cloud token
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
        22,
        3,
        'Cloud token',
        'cloud-token',
        277,
        9412,
        'Cloud token',
        'Previous period',
        '',
        '',
        '',
        18,
        10,
        16,
        500,
        300,
        400,
        16,
        600,
        15,
        500,
        '0.04,0.15,0.25,1.00',
        '0.31,0.36,0.46,1.00',
        '0.2,0.2,0.2,1.0',
        '1.00,1.00,1.00,1.00',
        '0.26,0.33,0.40,1.00',
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


    -- Section 24: 
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
        23,
        3,
        '',
        '',
        363,
        9579,
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
        '1.00,1.00,1.00,1.00',
        '0.26,0.33,0.40,1.00',
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


    -- Section 25: Ship faster with powerful and easy-to-use APIs
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
        24,
        3,
        'Ship faster with powerful and easy-to-use APIs',
        'ship-faster-with-powerful-and-easy-to-use-apis',
        1361,
        10145,
        'Ship faster with powerful and easy-to-use APIs',
        'Designed for developers',
        '',
        '',
        '',
        56,
        18,
        16,
        500,
        500,
        400,
        16,
        600,
        15,
        500,
        '0.04,0.15,0.25,1.00',
        '0.39,0.36,1.00,1.00',
        '0.2,0.2,0.2,1.0',
        '0.00,0.00,0.00,0.00',
        '0.68,0.74,0.80,1.00',
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


    -- Section 26: Low- and no-code options for getting started
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
        25,
        3,
        'Low- and no-code options for getting started',
        'low-and-no-code-options-for-getting-started',
        1235,
        11302,
        'Low- and no-code options for getting started',
        'Launch with ease',
        '',
        '',
        '',
        56,
        18,
        16,
        500,
        500,
        400,
        16,
        600,
        15,
        500,
        '0.04,0.15,0.25,1.00',
        '0.39,0.36,1.00,1.00',
        '0.2,0.2,0.2,1.0',
        '0.00,0.00,0.00,0.00',
        '0.26,0.33,0.40,1.00',
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
        'scraped_images/stripe_flexbox_test/img_25.jpg',
        FALSE
    );


    -- Section 27: Products & pricing
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
        26,
        1,
        'Products & pricing',
        'products-pricing',
        1387,
        12946,
        'Products & pricing',
        '',
        '',
        '',
        '',
        15,
        20,
        16,
        425,
        400,
        400,
        16,
        600,
        15,
        500,
        '0.04,0.15,0.25,1.00',
        '0.3,0.3,0.3,1.0',
        '0.2,0.2,0.2,1.0',
        '0.00,0.00,0.00,0.00',
        '0.04,0.15,0.25,1.00',
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
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_flexbox_test')
  AND section_order = 0;


-- Enhanced data for Section 2
UPDATE sections
SET type_name = 'text-stack',
    use_legacy_type = FALSE
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_flexbox_test')
  AND section_order = 1;


-- Enhanced data for Section 3
UPDATE sections
SET type_name = 'custom-stack',
    use_legacy_type = FALSE
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_flexbox_test')
  AND section_order = 2;


-- Enhanced data for Section 4
UPDATE sections
SET type_name = 'text-stack',
    use_legacy_type = FALSE
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_flexbox_test')
  AND section_order = 3;


INSERT INTO interactive_elements (
    section_id, element_index, element_type, carousel_images, carousel_auto_play_speed
) VALUES (
    (SELECT id FROM sections
     WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_flexbox_test')
     AND section_order = 3),
    0,
    2,  -- INTERACT_CAROUSEL
    '[]',
    3.0
);


-- Enhanced data for Section 5
UPDATE sections
SET type_name = 'text-stack',
    use_legacy_type = FALSE
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_flexbox_test')
  AND section_order = 4;


-- Enhanced data for Section 6
UPDATE sections
SET type_name = 'cards-4-grid-3col',
    use_legacy_type = FALSE
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_flexbox_test')
  AND section_order = 5;


INSERT INTO section_layout_properties (
    section_id, layout_mode, flex_direction, justify_content, align_items,
    flex_gap, grid_template_columns, grid_template_rows, grid_gap
) VALUES (
    (SELECT id FROM sections
     WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_flexbox_test')
     AND section_order = 5),
    2,
    'row',
    'normal',
    'normal',
    0.0,
    '276px',
    '432px',
    0.0
);


-- Enhanced data for Section 7
UPDATE sections
SET type_name = 'cards-4-grid-3col',
    use_legacy_type = FALSE
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_flexbox_test')
  AND section_order = 6;


INSERT INTO section_layout_properties (
    section_id, layout_mode, flex_direction, justify_content, align_items,
    flex_gap, grid_template_columns, grid_template_rows, grid_gap
) VALUES (
    (SELECT id FROM sections
     WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_flexbox_test')
     AND section_order = 6),
    2,
    'row',
    'normal',
    'normal',
    0.0,
    '276px',
    '432px',
    0.0
);


-- Enhanced data for Section 8
UPDATE sections
SET type_name = 'custom-stack',
    use_legacy_type = FALSE
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_flexbox_test')
  AND section_order = 7;


-- Enhanced data for Section 9
UPDATE sections
SET type_name = 'custom-stack',
    use_legacy_type = FALSE
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_flexbox_test')
  AND section_order = 8;


-- Enhanced data for Section 10
UPDATE sections
SET type_name = 'custom-stack',
    use_legacy_type = FALSE
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_flexbox_test')
  AND section_order = 9;


-- Enhanced data for Section 11
UPDATE sections
SET type_name = 'custom-stack',
    use_legacy_type = FALSE
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_flexbox_test')
  AND section_order = 10;


-- Enhanced data for Section 12
UPDATE sections
SET type_name = 'custom-stack',
    use_legacy_type = FALSE
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_flexbox_test')
  AND section_order = 11;


-- Enhanced data for Section 13
UPDATE sections
SET type_name = 'custom-stack',
    use_legacy_type = FALSE
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_flexbox_test')
  AND section_order = 12;


-- Enhanced data for Section 14
UPDATE sections
SET type_name = 'custom-stack',
    use_legacy_type = FALSE
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_flexbox_test')
  AND section_order = 13;


-- Enhanced data for Section 15
UPDATE sections
SET type_name = 'custom-stack',
    use_legacy_type = FALSE
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_flexbox_test')
  AND section_order = 14;


-- Enhanced data for Section 16
UPDATE sections
SET type_name = 'custom-stack',
    use_legacy_type = FALSE
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_flexbox_test')
  AND section_order = 15;


-- Enhanced data for Section 17
UPDATE sections
SET type_name = 'custom-stack',
    use_legacy_type = FALSE
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_flexbox_test')
  AND section_order = 16;


-- Enhanced data for Section 18
UPDATE sections
SET type_name = 'custom-stack',
    use_legacy_type = FALSE
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_flexbox_test')
  AND section_order = 17;


-- Enhanced data for Section 19
UPDATE sections
SET type_name = 'custom-stack',
    use_legacy_type = FALSE
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_flexbox_test')
  AND section_order = 18;


-- Enhanced data for Section 20
UPDATE sections
SET type_name = 'text-stack',
    use_legacy_type = FALSE
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_flexbox_test')
  AND section_order = 19;


-- Enhanced data for Section 21
UPDATE sections
SET type_name = 'text-stack',
    use_legacy_type = FALSE
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_flexbox_test')
  AND section_order = 20;


INSERT INTO interactive_elements (
    section_id, element_index, element_type, carousel_images, carousel_auto_play_speed
) VALUES (
    (SELECT id FROM sections
     WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_flexbox_test')
     AND section_order = 20),
    0,
    2,  -- INTERACT_CAROUSEL
    '["https://images.stripeassets.com/fzn2n1nzq965/1ctgMwd2p9euFW9pPSM7jR/451d5e987ca7fa14060526e6b1766a8b/bmw-portrait.png?q=80&w=1024", "https://images.stripeassets.com/fzn2n1nzq965/4zeFefnpB8yh7U3qSQRktP/d583ee93dd3d8910fa27296748699a0f/bmw-landscape.png?q=80&w=1836", "https://images.stripeassets.com/fzn2n1nzq965/5DaqGgXeMbxSIqQj9WSqSF/8142c0c6e15b27a8bb6c8a0f8a5d4dfb/home-enterprise-amazon-portrait.png?q=80&w=1024", "https://images.stripeassets.com/fzn2n1nzq965/4jq1Wguyus7CA7yc2kxMgn/cf7b01aadf305daef40ac8acab654510/home-enterprise-amazon.png?q=80&w=1836", "https://images.stripeassets.com/fzn2n1nzq965/7szA8TJHWKDIEuCbu6Yblm/4548db61648d063fb7e7dddfca04ab79/home-enterprise-maersk-portrait.png?q=80&w=1024", "https://images.stripeassets.com/fzn2n1nzq965/5F0uhf7cRg9vhR6NmgWzzI/664e14ddebb91375f89f8dcc75242dc0/home-enterprise-maersk.png?q=80&w=1836", "https://images.stripeassets.com/fzn2n1nzq965/6c56LuWUxcACbVkv4fqszI/d0a88e48d11a88b97daf896246ac40da/home-enterprise-twilio-portrait.png?q=80&w=1024", "https://images.stripeassets.com/fzn2n1nzq965/7jjWJlm9NHgLI7SV98B0Dg/ea1ae753f3764897fa4333311e41f496/home-enterprise-twilio.png?q=80&w=1836"]',
    3.0
);


-- Enhanced data for Section 22
UPDATE sections
SET type_name = 'image-stack',
    use_legacy_type = FALSE
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_flexbox_test')
  AND section_order = 21;


-- Enhanced data for Section 23
UPDATE sections
SET type_name = 'text-grid-3col',
    use_legacy_type = FALSE
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_flexbox_test')
  AND section_order = 22;


INSERT INTO section_layout_properties (
    section_id, layout_mode, flex_direction, justify_content, align_items,
    flex_gap, grid_template_columns, grid_template_rows, grid_gap
) VALUES (
    (SELECT id FROM sections
     WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_flexbox_test')
     AND section_order = 22),
    2,
    'row',
    'normal',
    'normal',
    0.0,
    '186px 186px',
    '22px 54.9531px 158px',
    0.0
);


-- Enhanced data for Section 24
UPDATE sections
SET type_name = 'custom-stack',
    use_legacy_type = FALSE
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_flexbox_test')
  AND section_order = 23;


-- Enhanced data for Section 25
UPDATE sections
SET type_name = 'text-stack',
    use_legacy_type = FALSE
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_flexbox_test')
  AND section_order = 24;


-- Enhanced data for Section 26
UPDATE sections
SET type_name = 'text-stack',
    use_legacy_type = FALSE
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_flexbox_test')
  AND section_order = 25;


-- Enhanced data for Section 27
UPDATE sections
SET type_name = 'text-stack',
    use_legacy_type = FALSE
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_flexbox_test')
  AND section_order = 26;

COMMIT;


-- Template import complete!
-- Template name: stripe_flexbox_test
-- Total sections: 27
--
-- To verify the import:
-- SELECT * FROM templates WHERE template_name = 'stripe_flexbox_test';
-- SELECT COUNT(*) FROM sections WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_flexbox_test');
