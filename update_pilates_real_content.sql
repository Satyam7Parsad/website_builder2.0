-- Update Pilates Studio Template with ACTUAL Wix Content
-- This updates the template with the real text and design from the Wix template

BEGIN;

-- First, delete the old Pilates Studio template and its sections
DELETE FROM templates WHERE template_name = 'Pilates Studio';

-- Insert the updated template with real Wix content
INSERT INTO templates (template_name, description, project_name, created_date)
VALUES (
    'Pilates Studio - L. Carter',
    'Authentic Pilates Studio Website - Exact replica of Wix template',
    'L. Carter Pilates',
    '2026-01-08 14:30:00'
)
RETURNING id;

-- Get the template ID
DO $$
DECLARE
    template_id_var integer;
BEGIN
    SELECT id INTO template_id_var FROM templates WHERE template_name = 'Pilates Studio - L. Carter';

    -- Section 1: Hero Section - "Discover the Power of Pilates"
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
        template_id_var, 0, 0, 'Hero Section', 'hero', 600, 0,
        'Discover the Power of Pilates',
        '',
        'Welcome to our Pilates studio, where strength and flexibility come together. Join us for personalized sessions in a supportive environment.',
        'Book Now', '#contact',
        48, 20, 16, 700, 400, 400, 16, 600, 15, 500,
        '0.15,0.15,0.15,1.0', '0.25,0.25,0.25,1.0', '0.35,0.35,0.35,1.0',
        '0.95,0.93,0.91,1.0', '0.15,0.15,0.15,1.0',
        '0.2,0.25,0.2,1.0', '0.15,0.2,0.15,1.0', '0.95,0.95,0.95,1.0',
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
        template_id_var, 1, 1, 'Navigation', 'nav', 70, 600,
        'L. Carter', '', '', '', '',
        20, 16, 14, 400, 400, 400, 14, 500, 14, 400,
        '0.15,0.15,0.15,1.0', '0.15,0.15,0.15,1.0', '0.15,0.15,0.15,1.0',
        '0.98,0.98,0.98,1.0', '0.15,0.15,0.15,1.0',
        '0.2,0.25,0.2,1.0', '0.15,0.2,0.15,1.0', '0.95,0.95,0.95,1.0',
        20, 1, 300, 250, 20, 3
    );

    -- Section 3: Book Your Session - Gallery Section
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
        template_id_var, 2, 8, 'Book Your Session', 'book-session', 500, 670,
        'Book Your Session', '', '', '', '',
        42, 18, 16, 400, 400, 400, 16, 600, 15, 500,
        '0.15,0.15,0.15,1.0', '0.25,0.25,0.25,1.0', '0.35,0.35,0.35,1.0',
        '0.96,0.95,0.94,1.0', '0.15,0.15,0.15,1.0',
        '0.2,0.25,0.2,1.0', '0.15,0.2,0.15,1.0', '0.95,0.95,0.95,1.0',
        60, 1, 380, 320, 25, 3
    );

    -- Section 4: About Our Pilates Studio
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
        template_id_var, 3, 2, 'About Our Pilates Studio', 'about', 550, 1170,
        'About Our Pilates Studio',
        'Our Story',
        'At our Pilates studio, we are dedicated to enhancing your physical and mental well-being through mindful movement.

Our Mission: We strive to create a welcoming and inclusive space where individuals of all fitness levels can experience the transformative benefits of Pilates. Our certified instructors are committed to guiding you on your journey to improved health and vitality.',
        'Learn More', '#about',
        36, 20, 15, 400, 600, 400, 15, 600, 15, 500,
        '0.2,0.25,0.2,1.0', '0.2,0.25,0.2,1.0', '0.2,0.25,0.2,1.0',
        '0.82,0.87,0.84,1.0', '0.2,0.25,0.2,1.0',
        '0.2,0.3,0.2,1.0', '0.2,0.3,0.2,1.0', '0.95,0.95,0.95,1.0',
        70, 0, 300, 250, 20, 2
    );

    -- Section 5: Client Testimonials
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
        template_id_var, 4, 7, 'Client Testimonials', 'testimonials', 480, 1720,
        'Client Testimonials',
        '',
        'In just a few sessions, you can also feel a remarkable difference in my posture and overall strength.

"I highly recommend this studio to anyone looking to enhance their fitness journey and well-being." - Liam',
        '', '',
        36, 18, 15, 400, 400, 400, 16, 600, 15, 500,
        '0.2,0.25,0.2,1.0', '0.25,0.3,0.25,1.0', '0.2,0.25,0.2,1.0',
        '0.84,0.87,0.85,1.0', '0.2,0.25,0.2,1.0',
        '0.2,0.3,0.2,1.0', '0.2,0.3,0.2,1.0', '0.95,0.95,0.95,1.0',
        70, 1, 600, 250, 30, 2
    );

    -- Section 6: Why Us? (Dark green background)
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
        template_id_var, 5, 14, 'Why Us?', 'why-us', 550, 2200,
        'Why Us?',
        '',
        'Our studio offers a holistic approach to health and wellness, focusing on building strength, flexibility, and mindfulness.

We prioritize personalized attention and tailor our sessions to meet your specific needs and goals.

Individualized Training: Our individualized training programs are designed to help you achieve your fitness objectives effectively and safely, ensuring a rewarding Pilates experience.

Certified Professionals: Our certified instructors bring a wealth of knowledge and expertise to every session, ensuring you receive top-quality instruction and guidance.',
        '', '',
        34, 18, 14, 400, 400, 400, 15, 600, 15, 500,
        '0.92,0.94,0.92,1.0', '0.88,0.9,0.88,1.0', '0.85,0.88,0.85,1.0',
        '0.15,0.25,0.18,1.0', '0.92,0.94,0.92,1.0',
        '0.25,0.35,0.28,1.0', '0.25,0.35,0.28,1.0', '0.95,0.95,0.95,1.0',
        70, 0, 500, 280, 40, 2
    );

    -- Section 7: Get in Touch With Us - Contact Form
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
        template_id_var, 6, 9, 'Get in Touch With Us', 'contact', 500, 2750,
        'Get in Touch With Us',
        '',
        'Contact us to book your session or ask any questions.',
        'Submit', '#',
        34, 18, 14, 400, 400, 400, 15, 600, 15, 500,
        '0.2,0.25,0.2,1.0', '0.25,0.3,0.25,1.0', '0.2,0.25,0.2,1.0',
        '0.88,0.91,0.89,1.0', '0.2,0.25,0.2,1.0',
        '0.2,0.3,0.2,1.0', '0.2,0.35,0.22,1.0', '0.95,0.95,0.95,1.0',
        70, 1, 500, 350, 30, 1
    );

    -- Section 8: Footer
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
        template_id_var, 7, 10, 'Footer', 'footer', 280, 3250,
        'L. Carter',
        '',
        '123-456-7890
info@mysite.com
500 Terry Francine St, San Francisco, CA 94158

Privacy Policy | Accessibility Statement',
        '', '',
        18, 14, 13, 400, 400, 400, 14, 500, 13, 400,
        '0.2,0.25,0.2,1.0', '0.25,0.3,0.25,1.0', '0.25,0.3,0.25,1.0',
        '0.92,0.93,0.91,1.0', '0.2,0.25,0.2,1.0',
        '0.2,0.3,0.2,1.0', '0.2,0.3,0.2,1.0', '0.95,0.95,0.95,1.0',
        50, 0, 300, 200, 20, 3
    );

END $$;

COMMIT;

-- Verify update
SELECT 'Template updated with real Wix content!' as message;
SELECT template_name, description FROM templates WHERE template_name = 'Pilates Studio - L. Carter';
SELECT COUNT(*) as section_count FROM sections WHERE template_id = (SELECT id FROM templates WHERE template_name = 'Pilates Studio - L. Carter');
