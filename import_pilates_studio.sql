-- Import Pilates Studio Template into Database
-- This script creates the template and all its sections

BEGIN;

-- Insert the template
INSERT INTO templates (template_name, description, project_name, created_date)
VALUES (
    'Pilates Studio',
    'Professional Pilates Studio Website Template - Energetic and Modern',
    'Pilates Studio',
    '2026-01-08 14:05:00'
)
RETURNING id;

-- Get the template ID (will be used in sections)
DO $$
DECLARE
    template_id_var integer;
BEGIN
    SELECT id INTO template_id_var FROM templates WHERE template_name = 'Pilates Studio';

    -- Section 1: Hero Section
    INSERT INTO sections (
        template_id, section_order, type, name, section_id, height, y_position,
        title, subtitle, content, button_text, button_link,
        title_font_size, subtitle_font_size, content_font_size,
        title_font_weight, subtitle_font_weight, content_font_weight,
        button_font_size, button_font_weight, nav_font_size, nav_font_weight,
        title_color, subtitle_color, content_color, bg_color, text_color,
        accent_color, button_bg_color, button_text_color,
        padding, text_align, card_width, card_height, card_spacing, cards_per_row
    ) VALUES (
        template_id_var, 0, 0, 'Hero Section', 'hero', 650, 0,
        'Transform Your Body & Mind', 'Professional Pilates Studio',
        'Discover the power of Pilates with our expert instructors. Join us for energizing classes that will strengthen, tone, and revitalize your body.',
        'Book a Class', '#contact',
        56, 24, 18, 700, 400, 400, 18, 600, 15, 500,
        '0.95,0.95,0.95,1.0', '0.9,0.9,0.9,1.0', '0.85,0.85,0.85,1.0',
        '0.18,0.22,0.25,1.0', '0.95,0.95,0.95,1.0',
        '0.8,0.4,0.5,1.0', '0.8,0.4,0.5,1.0', '1.0,1.0,1.0,1.0',
        80, 1, 300, 250, 20, 3
    );

    -- Section 2: Navigation
    INSERT INTO sections (
        template_id, section_order, type, name, section_id, height, y_position,
        title, subtitle, content, button_text, button_link,
        title_font_size, subtitle_font_size, content_font_size,
        title_font_weight, subtitle_font_weight, content_font_weight,
        button_font_size, button_font_weight, nav_font_size, nav_font_weight,
        title_color, subtitle_color, content_color, bg_color, text_color,
        accent_color, button_bg_color, button_text_color,
        padding, text_align, card_width, card_height, card_spacing, cards_per_row
    ) VALUES (
        template_id_var, 1, 1, 'Navigation', 'nav', 70, 650,
        'Pilates Studio', '', '', '', '',
        24, 20, 16, 700, 400, 400, 16, 600, 15, 500,
        '0.1,0.1,0.1,1.0', '0.3,0.3,0.3,1.0', '0.2,0.2,0.2,1.0',
        '1.0,1.0,1.0,1.0', '0.1,0.1,0.1,1.0',
        '0.8,0.4,0.5,1.0', '0.8,0.4,0.5,1.0', '1.0,1.0,1.0,1.0',
        20, 1, 300, 250, 20, 3
    );

    -- Section 3: About Section
    INSERT INTO sections (
        template_id, section_order, type, name, section_id, height, y_position,
        title, subtitle, content, button_text, button_link,
        title_font_size, subtitle_font_size, content_font_size,
        title_font_weight, subtitle_font_weight, content_font_weight,
        button_font_size, button_font_weight, nav_font_size, nav_font_weight,
        title_color, subtitle_color, content_color, bg_color, text_color,
        accent_color, button_bg_color, button_text_color,
        padding, text_align, card_width, card_height, card_spacing, cards_per_row
    ) VALUES (
        template_id_var, 2, 2, 'About Section', 'about', 450, 720,
        'About Our Studio', 'Your Journey to Wellness Starts Here',
        'We are a dedicated team of certified Pilates instructors passionate about helping you achieve your fitness goals. Our state-of-the-art studio offers a welcoming environment where you can focus on building strength, flexibility, and mindfulness.',
        'Learn More', '#about',
        42, 20, 16, 700, 400, 400, 16, 600, 15, 500,
        '0.1,0.1,0.1,1.0', '0.3,0.3,0.3,1.0', '0.2,0.2,0.2,1.0',
        '0.98,0.98,0.98,1.0', '0.1,0.1,0.1,1.0',
        '0.8,0.4,0.5,1.0', '0.8,0.4,0.5,1.0', '1.0,1.0,1.0,1.0',
        60, 1, 300, 250, 20, 3
    );

    -- Section 4: Services
    INSERT INTO sections (
        template_id, section_order, type, name, section_id, height, y_position,
        title, subtitle, content, button_text, button_link,
        title_font_size, subtitle_font_size, content_font_size,
        title_font_weight, subtitle_font_weight, content_font_weight,
        button_font_size, button_font_weight, nav_font_size, nav_font_weight,
        title_color, subtitle_color, content_color, bg_color, text_color,
        accent_color, button_bg_color, button_text_color,
        padding, text_align, card_width, card_height, card_spacing, cards_per_row
    ) VALUES (
        template_id_var, 3, 3, 'Services', 'services', 500, 1170,
        'Our Classes', 'Find Your Perfect Workout', '',
        '', '',
        42, 20, 16, 700, 400, 400, 16, 600, 15, 500,
        '0.1,0.1,0.1,1.0', '0.3,0.3,0.3,1.0', '0.2,0.2,0.2,1.0',
        '1.0,1.0,1.0,1.0', '0.1,0.1,0.1,1.0',
        '0.8,0.4,0.5,1.0', '0.8,0.4,0.5,1.0', '1.0,1.0,1.0,1.0',
        60, 1, 320, 280, 30, 3
    );

    -- Section 5: Pricing
    INSERT INTO sections (
        template_id, section_order, type, name, section_id, height, y_position,
        title, subtitle, content, button_text, button_link,
        title_font_size, subtitle_font_size, content_font_size,
        title_font_weight, subtitle_font_weight, content_font_weight,
        button_font_size, button_font_weight, nav_font_size, nav_font_weight,
        title_color, subtitle_color, content_color, bg_color, text_color,
        accent_color, button_bg_color, button_text_color,
        padding, text_align, card_width, card_height, card_spacing, cards_per_row
    ) VALUES (
        template_id_var, 4, 6, 'Pricing', 'pricing', 550, 1670,
        'Membership Plans', 'Choose the plan that works for you', '',
        '', '',
        42, 20, 16, 700, 400, 400, 16, 600, 15, 500,
        '0.1,0.1,0.1,1.0', '0.3,0.3,0.3,1.0', '0.2,0.2,0.2,1.0',
        '0.98,0.98,0.98,1.0', '0.1,0.1,0.1,1.0',
        '0.8,0.4,0.5,1.0', '0.8,0.4,0.5,1.0', '1.0,1.0,1.0,1.0',
        60, 1, 300, 400, 30, 3
    );

    -- Section 6: Team
    INSERT INTO sections (
        template_id, section_order, type, name, section_id, height, y_position,
        title, subtitle, content, button_text, button_link,
        title_font_size, subtitle_font_size, content_font_size,
        title_font_weight, subtitle_font_weight, content_font_weight,
        button_font_size, button_font_weight, nav_font_size, nav_font_weight,
        title_color, subtitle_color, content_color, bg_color, text_color,
        accent_color, button_bg_color, button_text_color,
        padding, text_align, card_width, card_height, card_spacing, cards_per_row
    ) VALUES (
        template_id_var, 5, 5, 'Team', 'team', 500, 2220,
        'Meet Our Instructors', 'Expert guidance from certified professionals', '',
        '', '',
        42, 20, 16, 700, 400, 400, 16, 600, 15, 500,
        '0.1,0.1,0.1,1.0', '0.3,0.3,0.3,1.0', '0.2,0.2,0.2,1.0',
        '1.0,1.0,1.0,1.0', '0.1,0.1,0.1,1.0',
        '0.8,0.4,0.5,1.0', '0.8,0.4,0.5,1.0', '1.0,1.0,1.0,1.0',
        60, 1, 280, 320, 30, 4
    );

    -- Section 7: Gallery
    INSERT INTO sections (
        template_id, section_order, type, name, section_id, height, y_position,
        title, subtitle, content, button_text, button_link,
        title_font_size, subtitle_font_size, content_font_size,
        title_font_weight, subtitle_font_weight, content_font_weight,
        button_font_size, button_font_weight, nav_font_size, nav_font_weight,
        title_color, subtitle_color, content_color, bg_color, text_color,
        accent_color, button_bg_color, button_text_color,
        padding, text_align, card_width, card_height, card_spacing, cards_per_row
    ) VALUES (
        template_id_var, 6, 8, 'Gallery', 'gallery', 450, 2720,
        'Studio Gallery', 'Take a look at our beautiful space', '',
        '', '',
        42, 20, 16, 700, 400, 400, 16, 600, 15, 500,
        '0.1,0.1,0.1,1.0', '0.3,0.3,0.3,1.0', '0.2,0.2,0.2,1.0',
        '0.98,0.98,0.98,1.0', '0.1,0.1,0.1,1.0',
        '0.8,0.4,0.5,1.0', '0.8,0.4,0.5,1.0', '1.0,1.0,1.0,1.0',
        60, 1, 350, 250, 20, 4
    );

    -- Section 8: Contact
    INSERT INTO sections (
        template_id, section_order, type, name, section_id, height, y_position,
        title, subtitle, content, button_text, button_link,
        title_font_size, subtitle_font_size, content_font_size,
        title_font_weight, subtitle_font_weight, content_font_weight,
        button_font_size, button_font_weight, nav_font_size, nav_font_weight,
        title_color, subtitle_color, content_color, bg_color, text_color,
        accent_color, button_bg_color, button_text_color,
        padding, text_align, card_width, card_height, card_spacing, cards_per_row
    ) VALUES (
        template_id_var, 7, 9, 'Contact', 'contact', 500, 3170,
        'Get In Touch', 'Book your first class today',
        'Ready to start your Pilates journey? Contact us to schedule your first session or ask any questions you may have.',
        'Contact Us', '#contact',
        42, 20, 16, 700, 400, 400, 16, 600, 15, 500,
        '0.1,0.1,0.1,1.0', '0.3,0.3,0.3,1.0', '0.2,0.2,0.2,1.0',
        '1.0,1.0,1.0,1.0', '0.1,0.1,0.1,1.0',
        '0.8,0.4,0.5,1.0', '0.8,0.4,0.5,1.0', '1.0,1.0,1.0,1.0',
        60, 1, 300, 250, 20, 3
    );

    -- Section 9: Footer
    INSERT INTO sections (
        template_id, section_order, type, name, section_id, height, y_position,
        title, subtitle, content, button_text, button_link,
        title_font_size, subtitle_font_size, content_font_size,
        title_font_weight, subtitle_font_weight, content_font_weight,
        button_font_size, button_font_weight, nav_font_size, nav_font_weight,
        title_color, subtitle_color, content_color, bg_color, text_color,
        accent_color, button_bg_color, button_text_color,
        padding, text_align, card_width, card_height, card_spacing, cards_per_row
    ) VALUES (
        template_id_var, 8, 10, 'Footer', 'footer', 250, 3670,
        '', '', '2026 Pilates Studio. All rights reserved.',
        '', '',
        18, 16, 14, 600, 400, 400, 16, 600, 15, 500,
        '0.8,0.8,0.8,1.0', '0.7,0.7,0.7,1.0', '0.6,0.6,0.6,1.0',
        '0.15,0.15,0.15,1.0', '0.8,0.8,0.8,1.0',
        '0.8,0.4,0.5,1.0', '0.8,0.4,0.5,1.0', '1.0,1.0,1.0,1.0',
        40, 1, 300, 250, 20, 3
    );

END $$;

COMMIT;

-- Verify insertion
SELECT 'Template inserted successfully!' as message;
SELECT template_name, description, project_name FROM templates WHERE template_name = 'Pilates Studio';
SELECT COUNT(*) as section_count FROM sections WHERE template_id = (SELECT id FROM templates WHERE template_name = 'Pilates Studio');
