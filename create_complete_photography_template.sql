-- Complete Photography Portfolio Template
-- Created: 2026-01-19
-- Sections: Hero, About, Gallery, Services, Contact, Footer

BEGIN;

-- Insert the template
INSERT INTO templates (template_name, description, project_name, created_date)
VALUES (
    'complete_photography_portfolio',
    'Professional Photography Portfolio - Complete multi-section template with Hero, About, Gallery, Services, Contact and Footer sections. Perfect for photographers, videographers, and creative professionals.',
    'Complete Photography Portfolio',
    NOW()
);

-- Get the template ID
DO $$
DECLARE
    template_id_var integer;
BEGIN
    SELECT id INTO template_id_var FROM templates WHERE template_name = 'complete_photography_portfolio';

    -- Section 1: Navbar
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
        template_id_var, 0, 1, 'Navigation', 'navbar',
        80, 0,
        'Photography Studio', '', '', '', '',
        24, 16, 16,
        700, 400, 400,
        16, 600, 16, 500,
        '1.00,1.00,1.00,1.00', '0.80,0.80,0.80,1.00', '0.60,0.60,0.60,1.00',
        '0.02,0.02,0.05,0.95', '1.00,1.00,1.00,1.00',
        '0.27,0.51,0.71,1.00', '0.27,0.51,0.71,1.00', '1.00,1.00,1.00,1.00',
        '0.02,0.02,0.05,0.95', '1.00,1.00,1.00,1.00',
        20, 1, 300, 250, 20, 3,
        'none', '', FALSE,
        '{"button": {"borderRadius": "4px", "borderWidth": "0px"}, "section": {"boxShadow": "0px 2px 8px rgba(0,0,0,0.1)"}}',
        '{"nav_items": [{"text": "Home", "href": "#hero"}, {"text": "About", "href": "#about"}, {"text": "Gallery", "href": "#gallery"}, {"text": "Services", "href": "#services"}, {"text": "Contact", "href": "#contact"}]}',
        '{"position": {"position": "fixed", "top": "0px", "left": "0px", "right": "0px", "zIndex": "1000"}}'
    );

    -- Section 2: Hero
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
        template_id_var, 1, 0, 'Hero', 'hero',
        600, 80,
        'Capturing Life''s Beautiful Moments', 'Professional Photography & Videography',
        'Transform your vision into stunning visual stories. Award-winning photographer specializing in portraits, weddings, and commercial projects.',
        'View Portfolio', '#gallery',
        56, 24, 18,
        700, 400, 300,
        18, 600, 16, 500,
        '1.00,1.00,1.00,1.00', '0.90,0.90,0.90,1.00', '0.85,0.85,0.85,1.00',
        '0.05,0.05,0.08,0.85', '1.00,1.00,1.00,1.00',
        '0.27,0.51,0.71,1.00', '0.27,0.51,0.71,1.00', '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,0.00', '1.00,1.00,1.00,1.00',
        80, 2, 300, 250, 20, 3,
        'none', '', TRUE,
        '{"button": {"borderRadius": "30px", "padding": "15px 40px", "boxShadow": "0px 4px 15px rgba(39, 130, 181, 0.4)"}, "section": {"backgroundSize": "cover", "backgroundPosition": "center"}}',
        '{"buttons": [{"text": "View Portfolio", "href": "#gallery", "style": "primary"}, {"text": "Get in Touch", "href": "#contact", "style": "outline"}]}',
        '{"display": "flex", "flexDirection": "column", "justifyContent": "center", "alignItems": "center", "textAlign": "center"}'
    );

    -- Section 3: About
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
        template_id_var, 2, 2, 'About', 'about',
        500, 680,
        'About the Studio', 'Creating Timeless Visual Stories',
        'With over 10 years of experience in professional photography, I specialize in capturing authentic moments that tell compelling stories. My approach combines technical expertise with artistic vision to deliver stunning imagery that exceeds expectations. From intimate portraits to grand events, every project receives the same dedication and attention to detail.',
        'Learn More', '#services',
        42, 22, 18,
        700, 400, 300,
        18, 600, 16, 500,
        '0.10,0.10,0.15,1.00', '0.27,0.51,0.71,1.00', '0.30,0.30,0.35,1.00',
        '0.98,0.98,0.99,1.00', '0.20,0.20,0.25,1.00',
        '0.27,0.51,0.71,1.00', '0.27,0.51,0.71,1.00', '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,0.00', '0.20,0.20,0.25,1.00',
        80, 1, 300, 250, 20, 3,
        'none', '', FALSE,
        '{"section": {"borderTop": "1px solid rgba(0,0,0,0.1)"}}',
        '{}',
        '{"display": "grid", "gridTemplateColumns": "1fr 1fr", "gap": "60px", "alignItems": "center"}'
    );

    -- Section 4: Gallery
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
        template_id_var, 3, 4, 'Gallery', 'gallery',
        800, 1180,
        'Portfolio Gallery', 'Selected Works',
        'Browse through my collection of recent projects showcasing various photography styles and techniques.',
        'View All', '/gallery',
        42, 22, 16,
        700, 400, 300,
        16, 600, 16, 500,
        '0.10,0.10,0.15,1.00', '0.27,0.51,0.71,1.00', '0.30,0.30,0.35,1.00',
        '0.96,0.96,0.97,1.00', '0.20,0.20,0.25,1.00',
        '0.27,0.51,0.71,1.00', '0.27,0.51,0.71,1.00', '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,0.00', '0.20,0.20,0.25,1.00',
        60, 2, 380, 450, 20, 3,
        'none', '', FALSE,
        '{"section": {"backgroundColor": "#F6F6F7"}}',
        '{"gallery_items": [
            {"image": "photo1.jpg", "caption": "Wedding Photography", "category": "weddings"},
            {"image": "photo2.jpg", "caption": "Portrait Session", "category": "portraits"},
            {"image": "photo3.jpg", "caption": "Commercial Shoot", "category": "commercial"},
            {"image": "photo4.jpg", "caption": "Event Coverage", "category": "events"},
            {"image": "photo5.jpg", "caption": "Fashion Editorial", "category": "fashion"},
            {"image": "photo6.jpg", "caption": "Landscape", "category": "nature"}
        ]}',
        '{"display": "grid", "gridTemplateColumns": "repeat(3, 1fr)", "gap": "20px"}'
    );

    -- Section 5: Services (Cards)
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
        template_id_var, 4, 3, 'Services', 'services',
        650, 1980,
        'Services & Packages', 'What I Offer',
        'Professional photography services tailored to your needs. Choose from our packages or let''s create a custom solution together.',
        '', '',
        42, 22, 16,
        700, 400, 300,
        16, 600, 16, 500,
        '0.10,0.10,0.15,1.00', '0.27,0.51,0.71,1.00', '0.30,0.30,0.35,1.00',
        '1.00,1.00,1.00,1.00', '0.20,0.20,0.25,1.00',
        '0.27,0.51,0.71,1.00', '0.27,0.51,0.71,1.00', '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,0.00', '0.20,0.20,0.25,1.00',
        80, 2, 350, 420, 30, 3,
        'none', '', FALSE,
        '{"card": {"borderRadius": "8px", "boxShadow": "0px 4px 20px rgba(0,0,0,0.08)", "backgroundColor": "#FFFFFF"}}',
        '{"cards": [
            {"title": "Wedding Photography", "description": "Complete wedding day coverage with two photographers, engagement session, and premium album. Capture every precious moment of your special day.", "icon": "camera", "price": "$2,500+", "features": ["8 Hours Coverage", "Two Photographers", "Engagement Session", "Premium Album", "Digital Gallery"]},
            {"title": "Portrait Sessions", "description": "Professional portrait photography for individuals, families, and corporate headshots. Studio or location shooting available.", "icon": "user", "price": "$350+", "features": ["1 Hour Session", "Multiple Outfits", "20+ Edited Photos", "Digital Download", "Print Rights"]},
            {"title": "Commercial Projects", "description": "High-quality commercial photography for businesses, products, and marketing campaigns. Licensing and usage rights included.", "icon": "briefcase", "price": "$800+", "features": ["Half Day Shoot", "Product Photography", "Lifestyle Images", "Commercial License", "Fast Turnaround"]}
        ]}',
        '{"display": "grid", "gridTemplateColumns": "repeat(3, 1fr)", "gap": "30px"}'
    );

    -- Section 6: Contact
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
        template_id_var, 5, 9, 'Contact', 'contact',
        600, 2630,
        'Get in Touch', 'Let''s Create Something Amazing',
        'Ready to start your next project? Fill out the form below or reach out directly. I typically respond within 24 hours.',
        'Send Message', '/submit-contact',
        42, 22, 16,
        700, 400, 300,
        18, 600, 16, 500,
        '0.10,0.10,0.15,1.00', '0.27,0.51,0.71,1.00', '0.30,0.30,0.35,1.00',
        '0.98,0.98,0.99,1.00', '0.20,0.20,0.25,1.00',
        '0.27,0.51,0.71,1.00', '0.27,0.51,0.71,1.00', '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,0.00', '0.20,0.20,0.25,1.00',
        80, 2, 300, 250, 20, 3,
        'none', '', FALSE,
        '{"section": {"borderTop": "1px solid rgba(0,0,0,0.1)"}}',
        '{"form": {"fields": [
            {"name": "name", "type": "text", "label": "Your Name", "required": true, "placeholder": "John Doe"},
            {"name": "email", "type": "email", "label": "Email Address", "required": true, "placeholder": "john@example.com"},
            {"name": "phone", "type": "tel", "label": "Phone Number", "required": false, "placeholder": "(555) 123-4567"},
            {"name": "service", "type": "select", "label": "Service Interested In", "required": true, "options": ["Wedding Photography", "Portrait Session", "Commercial Project", "Other"]},
            {"name": "date", "type": "date", "label": "Event Date (if applicable)", "required": false},
            {"name": "message", "type": "textarea", "label": "Tell me about your project", "required": true, "placeholder": "Describe your vision, timeline, and any specific requirements..."}
        ]}, "contact_info": [
            {"type": "email", "value": "hello@photographystudio.com", "icon": "envelope"},
            {"type": "phone", "value": "+1 (555) 123-4567", "icon": "phone"},
            {"type": "location", "value": "New York, NY", "icon": "map-marker"}
        ]}',
        '{"display": "grid", "gridTemplateColumns": "1fr 1fr", "gap": "60px"}'
    );

    -- Section 7: Footer
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
        template_id_var, 6, 10, 'Footer', 'footer',
        200, 3230,
        '', '',
        '© 2026 Photography Studio. All rights reserved. | Capturing moments, creating memories.',
        '', '',
        16, 14, 14,
        400, 400, 400,
        14, 500, 14, 500,
        '0.70,0.70,0.75,1.00', '0.60,0.60,0.65,1.00', '0.70,0.70,0.75,1.00',
        '0.08,0.08,0.12,1.00', '0.70,0.70,0.75,1.00',
        '0.27,0.51,0.71,1.00', '0.20,0.20,0.25,1.00', '0.70,0.70,0.75,1.00',
        '0.00,0.00,0.00,0.00', '0.70,0.70,0.75,1.00',
        40, 2, 300, 250, 20, 3,
        'none', '', FALSE,
        '{"section": {"borderTop": "1px solid rgba(255,255,255,0.1)"}}',
        '{"footer_links": [
            {"text": "Privacy Policy", "href": "/privacy"},
            {"text": "Terms of Service", "href": "/terms"},
            {"text": "FAQ", "href": "/faq"}
        ], "social_links": [
            {"platform": "instagram", "href": "https://instagram.com/photographystudio", "icon": "instagram"},
            {"platform": "facebook", "href": "https://facebook.com/photographystudio", "icon": "facebook"},
            {"platform": "pinterest", "href": "https://pinterest.com/photographystudio", "icon": "pinterest"}
        ]}',
        '{"display": "flex", "flexDirection": "column", "justifyContent": "center", "alignItems": "center"}'
    );

END $$;

COMMIT;

-- Template complete!
-- Total sections: 7 (Navbar, Hero, About, Gallery, Services, Contact, Footer)
