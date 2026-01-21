-- Pilates Studio Template - Database Insert
-- Run this SQL script to add the Pilates Studio template to your database

-- Insert Pilates Studio Template
INSERT INTO website_templates (
    template_name,
    description,
    author,
    section_count,
    sections_json,
    page_count,
    tags,
    category
) VALUES (
    'Pilates Studio',
    'Professional Pilates Studio Website Template - Energetic and Modern',
    'Claude Code',
    9,
    '[
        {
                "id": 1,
                "type": 0,
                "name": "Hero Section",
                "section_id": "hero",
                "y_position": 0,
                "height": 650,
                "selected": false,
                "title": "Transform Your Body & Mind",
                "subtitle": "Professional Pilates Studio",
                "content": "Discover the power of Pilates with our expert instructors. Join us for energizing classes that will strengthen, tone, and revitalize your body.",
                "button_text": "Book a Class",
                "button_link": "#contact",
                "title_font_size": 56,
                "subtitle_font_size": 24,
                "content_font_size": 18,
                "title_font_weight": 700,
                "subtitle_font_weight": 400,
                "content_font_weight": 400,
                "title_color": [
                        0.95,
                        0.95,
                        0.95,
                        1.0
                ],
                "subtitle_color": [
                        0.9,
                        0.9,
                        0.9,
                        1.0
                ],
                "content_color": [
                        0.85,
                        0.85,
                        0.85,
                        1.0
                ],
                "background_image": "",
                "section_image": "",
                "bg_texture_id": 0,
                "img_texture_id": 0,
                "use_bg_image": false,
                "bg_overlay_opacity": 0.5,
                "bg_color": [
                        0.18,
                        0.22,
                        0.25,
                        1.0
                ],
                "text_color": [
                        0.95,
                        0.95,
                        0.95,
                        1.0
                ],
                "accent_color": [
                        0.8,
                        0.4,
                        0.5,
                        1.0
                ],
                "button_bg_color": [
                        0.8,
                        0.4,
                        0.5,
                        1.0
                ],
                "button_text_color": [
                        1.0,
                        1.0,
                        1.0,
                        1.0
                ],
                "button_font_size": 18,
                "button_font_weight": 600,
                "padding": 80,
                "text_align": 1,
                "nav_font_size": 15,
                "nav_font_weight": 500,
                "card_width": 300,
                "card_height": 250,
                "card_spacing": 20,
                "cards_per_row": 3
        },
        {
                "id": 2,
                "type": 1,
                "name": "Navigation",
                "section_id": "nav",
                "y_position": 650,
                "height": 70,
                "selected": false,
                "title": "Pilates Studio",
                "subtitle": "",
                "content": "",
                "button_text": "",
                "button_link": "",
                "title_font_size": 24,
                "subtitle_font_size": 20,
                "content_font_size": 16,
                "title_font_weight": 700,
                "subtitle_font_weight": 400,
                "content_font_weight": 400,
                "title_color": [
                        0.1,
                        0.1,
                        0.1,
                        1.0
                ],
                "subtitle_color": [
                        0.3,
                        0.3,
                        0.3,
                        1.0
                ],
                "content_color": [
                        0.2,
                        0.2,
                        0.2,
                        1.0
                ],
                "background_image": "",
                "section_image": "",
                "bg_texture_id": 0,
                "img_texture_id": 0,
                "use_bg_image": false,
                "bg_overlay_opacity": 0.5,
                "bg_color": [
                        1.0,
                        1.0,
                        1.0,
                        1.0
                ],
                "text_color": [
                        0.1,
                        0.1,
                        0.1,
                        1.0
                ],
                "accent_color": [
                        0.8,
                        0.4,
                        0.5,
                        1.0
                ],
                "button_bg_color": [
                        0.8,
                        0.4,
                        0.5,
                        1.0
                ],
                "button_text_color": [
                        1.0,
                        1.0,
                        1.0,
                        1.0
                ],
                "button_font_size": 16,
                "button_font_weight": 600,
                "padding": 20,
                "text_align": 1,
                "nav_font_size": 15,
                "nav_font_weight": 500,
                "card_width": 300,
                "card_height": 250,
                "card_spacing": 20,
                "cards_per_row": 3
        },
        {
                "id": 3,
                "type": 2,
                "name": "About Section",
                "section_id": "about",
                "y_position": 720,
                "height": 450,
                "selected": false,
                "title": "About Our Studio",
                "subtitle": "Your Journey to Wellness Starts Here",
                "content": "We are a dedicated team of certified Pilates instructors passionate about helping you achieve your fitness goals. Our state-of-the-art studio offers a welcoming environment where you can focus on building strength, flexibility, and mindfulness.",
                "button_text": "Learn More",
                "button_link": "#about",
                "title_font_size": 42,
                "subtitle_font_size": 20,
                "content_font_size": 16,
                "title_font_weight": 700,
                "subtitle_font_weight": 400,
                "content_font_weight": 400,
                "title_color": [
                        0.1,
                        0.1,
                        0.1,
                        1.0
                ],
                "subtitle_color": [
                        0.3,
                        0.3,
                        0.3,
                        1.0
                ],
                "content_color": [
                        0.2,
                        0.2,
                        0.2,
                        1.0
                ],
                "background_image": "",
                "section_image": "",
                "bg_texture_id": 0,
                "img_texture_id": 0,
                "use_bg_image": false,
                "bg_overlay_opacity": 0.5,
                "bg_color": [
                        0.98,
                        0.98,
                        0.98,
                        1.0
                ],
                "text_color": [
                        0.1,
                        0.1,
                        0.1,
                        1.0
                ],
                "accent_color": [
                        0.8,
                        0.4,
                        0.5,
                        1.0
                ],
                "button_bg_color": [
                        0.8,
                        0.4,
                        0.5,
                        1.0
                ],
                "button_text_color": [
                        1.0,
                        1.0,
                        1.0,
                        1.0
                ],
                "button_font_size": 16,
                "button_font_weight": 600,
                "padding": 60,
                "text_align": 1,
                "nav_font_size": 15,
                "nav_font_weight": 500,
                "card_width": 300,
                "card_height": 250,
                "card_spacing": 20,
                "cards_per_row": 3
        },
        {
                "id": 4,
                "type": 3,
                "name": "Services",
                "section_id": "services",
                "y_position": 1170,
                "height": 500,
                "selected": false,
                "title": "Our Classes",
                "subtitle": "Find Your Perfect Workout",
                "content": "",
                "button_text": "",
                "button_link": "",
                "title_font_size": 42,
                "subtitle_font_size": 20,
                "content_font_size": 16,
                "title_font_weight": 700,
                "subtitle_font_weight": 400,
                "content_font_weight": 400,
                "title_color": [
                        0.1,
                        0.1,
                        0.1,
                        1.0
                ],
                "subtitle_color": [
                        0.3,
                        0.3,
                        0.3,
                        1.0
                ],
                "content_color": [
                        0.2,
                        0.2,
                        0.2,
                        1.0
                ],
                "background_image": "",
                "section_image": "",
                "bg_texture_id": 0,
                "img_texture_id": 0,
                "use_bg_image": false,
                "bg_overlay_opacity": 0.5,
                "bg_color": [
                        1.0,
                        1.0,
                        1.0,
                        1.0
                ],
                "text_color": [
                        0.1,
                        0.1,
                        0.1,
                        1.0
                ],
                "accent_color": [
                        0.8,
                        0.4,
                        0.5,
                        1.0
                ],
                "button_bg_color": [
                        0.8,
                        0.4,
                        0.5,
                        1.0
                ],
                "button_text_color": [
                        1.0,
                        1.0,
                        1.0,
                        1.0
                ],
                "button_font_size": 16,
                "button_font_weight": 600,
                "padding": 60,
                "text_align": 1,
                "nav_font_size": 15,
                "nav_font_weight": 500,
                "card_width": 320,
                "card_height": 280,
                "card_spacing": 30,
                "cards_per_row": 3
        },
        {
                "id": 5,
                "type": 6,
                "name": "Pricing",
                "section_id": "pricing",
                "y_position": 1670,
                "height": 550,
                "selected": false,
                "title": "Membership Plans",
                "subtitle": "Choose the plan that works for you",
                "content": "",
                "button_text": "",
                "button_link": "",
                "title_font_size": 42,
                "subtitle_font_size": 20,
                "content_font_size": 16,
                "title_font_weight": 700,
                "subtitle_font_weight": 400,
                "content_font_weight": 400,
                "title_color": [
                        0.1,
                        0.1,
                        0.1,
                        1.0
                ],
                "subtitle_color": [
                        0.3,
                        0.3,
                        0.3,
                        1.0
                ],
                "content_color": [
                        0.2,
                        0.2,
                        0.2,
                        1.0
                ],
                "background_image": "",
                "section_image": "",
                "bg_texture_id": 0,
                "img_texture_id": 0,
                "use_bg_image": false,
                "bg_overlay_opacity": 0.5,
                "bg_color": [
                        0.98,
                        0.98,
                        0.98,
                        1.0
                ],
                "text_color": [
                        0.1,
                        0.1,
                        0.1,
                        1.0
                ],
                "accent_color": [
                        0.8,
                        0.4,
                        0.5,
                        1.0
                ],
                "button_bg_color": [
                        0.8,
                        0.4,
                        0.5,
                        1.0
                ],
                "button_text_color": [
                        1.0,
                        1.0,
                        1.0,
                        1.0
                ],
                "button_font_size": 16,
                "button_font_weight": 600,
                "padding": 60,
                "text_align": 1,
                "nav_font_size": 15,
                "nav_font_weight": 500,
                "card_width": 300,
                "card_height": 400,
                "card_spacing": 30,
                "cards_per_row": 3
        },
        {
                "id": 6,
                "type": 5,
                "name": "Team",
                "section_id": "team",
                "y_position": 2220,
                "height": 500,
                "selected": false,
                "title": "Meet Our Instructors",
                "subtitle": "Expert guidance from certified professionals",
                "content": "",
                "button_text": "",
                "button_link": "",
                "title_font_size": 42,
                "subtitle_font_size": 20,
                "content_font_size": 16,
                "title_font_weight": 700,
                "subtitle_font_weight": 400,
                "content_font_weight": 400,
                "title_color": [
                        0.1,
                        0.1,
                        0.1,
                        1.0
                ],
                "subtitle_color": [
                        0.3,
                        0.3,
                        0.3,
                        1.0
                ],
                "content_color": [
                        0.2,
                        0.2,
                        0.2,
                        1.0
                ],
                "background_image": "",
                "section_image": "",
                "bg_texture_id": 0,
                "img_texture_id": 0,
                "use_bg_image": false,
                "bg_overlay_opacity": 0.5,
                "bg_color": [
                        1.0,
                        1.0,
                        1.0,
                        1.0
                ],
                "text_color": [
                        0.1,
                        0.1,
                        0.1,
                        1.0
                ],
                "accent_color": [
                        0.8,
                        0.4,
                        0.5,
                        1.0
                ],
                "button_bg_color": [
                        0.8,
                        0.4,
                        0.5,
                        1.0
                ],
                "button_text_color": [
                        1.0,
                        1.0,
                        1.0,
                        1.0
                ],
                "button_font_size": 16,
                "button_font_weight": 600,
                "padding": 60,
                "text_align": 1,
                "nav_font_size": 15,
                "nav_font_weight": 500,
                "card_width": 280,
                "card_height": 320,
                "card_spacing": 30,
                "cards_per_row": 4
        },
        {
                "id": 7,
                "type": 8,
                "name": "Gallery",
                "section_id": "gallery",
                "y_position": 2720,
                "height": 450,
                "selected": false,
                "title": "Studio Gallery",
                "subtitle": "Take a look at our beautiful space",
                "content": "",
                "button_text": "",
                "button_link": "",
                "title_font_size": 42,
                "subtitle_font_size": 20,
                "content_font_size": 16,
                "title_font_weight": 700,
                "subtitle_font_weight": 400,
                "content_font_weight": 400,
                "title_color": [
                        0.1,
                        0.1,
                        0.1,
                        1.0
                ],
                "subtitle_color": [
                        0.3,
                        0.3,
                        0.3,
                        1.0
                ],
                "content_color": [
                        0.2,
                        0.2,
                        0.2,
                        1.0
                ],
                "background_image": "",
                "section_image": "",
                "bg_texture_id": 0,
                "img_texture_id": 0,
                "use_bg_image": false,
                "bg_overlay_opacity": 0.5,
                "bg_color": [
                        0.98,
                        0.98,
                        0.98,
                        1.0
                ],
                "text_color": [
                        0.1,
                        0.1,
                        0.1,
                        1.0
                ],
                "accent_color": [
                        0.8,
                        0.4,
                        0.5,
                        1.0
                ],
                "button_bg_color": [
                        0.8,
                        0.4,
                        0.5,
                        1.0
                ],
                "button_text_color": [
                        1.0,
                        1.0,
                        1.0,
                        1.0
                ],
                "button_font_size": 16,
                "button_font_weight": 600,
                "padding": 60,
                "text_align": 1,
                "nav_font_size": 15,
                "nav_font_weight": 500,
                "card_width": 350,
                "card_height": 250,
                "card_spacing": 20,
                "cards_per_row": 4
        },
        {
                "id": 8,
                "type": 9,
                "name": "Contact",
                "section_id": "contact",
                "y_position": 3170,
                "height": 500,
                "selected": false,
                "title": "Get In Touch",
                "subtitle": "Book your first class today",
                "content": "Ready to start your Pilates journey? Contact us to schedule your first session or ask any questions you may have.",
                "button_text": "Contact Us",
                "button_link": "#contact",
                "title_font_size": 42,
                "subtitle_font_size": 20,
                "content_font_size": 16,
                "title_font_weight": 700,
                "subtitle_font_weight": 400,
                "content_font_weight": 400,
                "title_color": [
                        0.1,
                        0.1,
                        0.1,
                        1.0
                ],
                "subtitle_color": [
                        0.3,
                        0.3,
                        0.3,
                        1.0
                ],
                "content_color": [
                        0.2,
                        0.2,
                        0.2,
                        1.0
                ],
                "background_image": "",
                "section_image": "",
                "bg_texture_id": 0,
                "img_texture_id": 0,
                "use_bg_image": false,
                "bg_overlay_opacity": 0.5,
                "bg_color": [
                        1.0,
                        1.0,
                        1.0,
                        1.0
                ],
                "text_color": [
                        0.1,
                        0.1,
                        0.1,
                        1.0
                ],
                "accent_color": [
                        0.8,
                        0.4,
                        0.5,
                        1.0
                ],
                "button_bg_color": [
                        0.8,
                        0.4,
                        0.5,
                        1.0
                ],
                "button_text_color": [
                        1.0,
                        1.0,
                        1.0,
                        1.0
                ],
                "button_font_size": 16,
                "button_font_weight": 600,
                "padding": 60,
                "text_align": 1,
                "nav_font_size": 15,
                "nav_font_weight": 500,
                "card_width": 300,
                "card_height": 250,
                "card_spacing": 20,
                "cards_per_row": 3
        },
        {
                "id": 9,
                "type": 10,
                "name": "Footer",
                "section_id": "footer",
                "y_position": 3670,
                "height": 250,
                "selected": false,
                "title": "",
                "subtitle": "",
                "content": "2026 Pilates Studio. All rights reserved.",
                "button_text": "",
                "button_link": "",
                "title_font_size": 18,
                "subtitle_font_size": 16,
                "content_font_size": 14,
                "title_font_weight": 600,
                "subtitle_font_weight": 400,
                "content_font_weight": 400,
                "title_color": [
                        0.8,
                        0.8,
                        0.8,
                        1.0
                ],
                "subtitle_color": [
                        0.7,
                        0.7,
                        0.7,
                        1.0
                ],
                "content_color": [
                        0.6,
                        0.6,
                        0.6,
                        1.0
                ],
                "background_image": "",
                "section_image": "",
                "bg_texture_id": 0,
                "img_texture_id": 0,
                "use_bg_image": false,
                "bg_overlay_opacity": 0.5,
                "bg_color": [
                        0.15,
                        0.15,
                        0.15,
                        1.0
                ],
                "text_color": [
                        0.8,
                        0.8,
                        0.8,
                        1.0
                ],
                "accent_color": [
                        0.8,
                        0.4,
                        0.5,
                        1.0
                ],
                "button_bg_color": [
                        0.8,
                        0.4,
                        0.5,
                        1.0
                ],
                "button_text_color": [
                        1.0,
                        1.0,
                        1.0,
                        1.0
                ],
                "button_font_size": 16,
                "button_font_weight": 600,
                "padding": 40,
                "text_align": 1,
                "nav_font_size": 15,
                "nav_font_weight": 500,
                "card_width": 300,
                "card_height": 250,
                "card_spacing": 20,
                "cards_per_row": 3
        }
]',
    1,
    'fitness,pilates,wellness,studio,health',
    'Fitness & Wellness'
);
