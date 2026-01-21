-- ============================================================================
-- Sipher Web E-Commerce Agency Template (Simplified)
-- ============================================================================

USE website_builder;

-- Insert main template record
INSERT INTO templates (
    template_name,
    description,
    project_name,
    created_date
) VALUES (
    'Sipher Web - E-Commerce Agency',
    'Professional tech agency website with glass morphism design. Features hero section, feature cards, and modern navigation. Perfect for tech companies and digital agencies.',
    'Sipher Web Template',
    NOW()
);

-- Get the template ID
SET @template_id = LAST_INSERT_ID();

-- ============================================================================
-- Section 1: Top Announcement Bar
-- ============================================================================
INSERT INTO sections (
    template_id, section_order, type, name, section_id,
    height, padding, text_align,
    title, subtitle, content,
    title_font_size, title_font_weight,
    title_color, subtitle_color, content_color,
    bg_color, text_color, accent_color,
    use_bg_image, bg_overlay_opacity
) VALUES (
    @template_id, 1, 0, 'Top Announcement Bar', 'top-bar',
    50, 12, 1,
    'Trusted by 100+ Enterprise Clients Worldwide  •  Delivering Innovation & Excellence Since 2022  •  Contact Us: +91 8318230713',
    '', '',
    14, 400,
    '1.0,1.0,1.0,1.0', '1.0,1.0,1.0,0.9', '1.0,1.0,1.0,0.8',
    '0.102,0.102,0.302,1.0', '1.0,1.0,1.0,1.0', '1.0,0.549,0.0,1.0',
    0, 0.50
);

-- ============================================================================
-- Section 2: Navigation Bar
-- ============================================================================
INSERT INTO sections (
    template_id, section_order, type, name, section_id,
    height, padding, text_align,
    title, subtitle, content,
    title_font_size, title_font_weight,
    nav_font_size, nav_font_weight,
    title_color, subtitle_color, content_color,
    bg_color, text_color, accent_color,
    use_bg_image, bg_overlay_opacity
) VALUES (
    @template_id, 2, 1, 'Navigation Bar', 'navbar',
    80, 20, 0,
    'Sipher Web Pvt. Ltd.', '', '',
    24, 700,
    16, 500,
    '0.051,0.051,0.227,1.0', '0.3,0.3,0.3,1.0', '0.2,0.2,0.2,1.0',
    '1.0,1.0,1.0,1.0', '0.051,0.051,0.227,1.0', '1.0,0.549,0.0,1.0',
    0, 0.50
);

-- ============================================================================
-- Section 3: Hero Section - E-Commerce Excellence
-- ============================================================================
INSERT INTO sections (
    template_id, section_order, type, name, section_id,
    height, padding, text_align,
    title, subtitle, content,
    button_text, button_link,
    title_font_size, title_font_weight,
    subtitle_font_size, subtitle_font_weight,
    content_font_size, content_font_weight,
    button_font_size, button_font_weight,
    title_color, subtitle_color, content_color,
    bg_color, text_color, accent_color,
    button_bg_color, button_text_color,
    background_image, use_bg_image, bg_overlay_opacity
) VALUES (
    @template_id, 3, 0, 'Hero - E-Commerce Excellence', 'hero',
    850, 120, 1,
    'E-Commerce Excellence',
    'Powerful e-commerce solutions with seamless payment processing, inventory management, and customer analytics.',
    'Transform your online store with our cutting-edge technology platform.',
    'Transform Your Store →', '#transform',
    56, 700,
    20, 400,
    18, 400,
    18, 600,
    '1.0,1.0,1.0,1.0', '1.0,1.0,1.0,0.9', '1.0,1.0,1.0,0.8',
    '0.051,0.051,0.227,1.0', '1.0,1.0,1.0,1.0', '1.0,0.549,0.0,1.0',
    '1.0,1.0,1.0,1.0', '0.051,0.051,0.227,1.0',
    '', 0, 0.85
);

-- ============================================================================
-- Section 4: Services/Features (Cards will be added manually in UI)
-- ============================================================================
INSERT INTO sections (
    template_id, section_order, type, name, section_id,
    height, padding, text_align,
    title, subtitle, content,
    title_font_size, title_font_weight,
    subtitle_font_size, subtitle_font_weight,
    content_font_size, content_font_weight,
    title_color, subtitle_color, content_color,
    bg_color, text_color, accent_color,
    cards_per_row, card_spacing,
    use_bg_image, bg_overlay_opacity
) VALUES (
    @template_id, 4, 3, 'Features & Services', 'features',
    450, 80, 1,
    'Why Choose Us',
    'Built for the modern digital economy',
    'Add three cards: Secure (Protected Payments), Analytics (Data Insights), Scalable (Growth Ready)',
    42, 700,
    20, 400,
    16, 400,
    '1.0,1.0,1.0,1.0', '1.0,1.0,1.0,0.8', '1.0,1.0,1.0,0.7',
    '0.051,0.051,0.227,1.0', '1.0,1.0,1.0,1.0', '1.0,0.549,0.0,1.0',
    3, 30,
    0, 0.50
);

-- ============================================================================
-- Verify the insertion
-- ============================================================================
SELECT '=== Template Created Successfully ===';

SELECT
    id AS 'Template ID',
    template_name AS 'Template Name',
    created_date AS 'Created'
FROM templates
WHERE template_name = 'Sipher Web - E-Commerce Agency';

SELECT '=== Sections Created ===';

SELECT
    section_order AS '#',
    name AS 'Section Name',
    type AS 'Type',
    height AS 'Height',
    LEFT(title, 50) AS 'Title Preview'
FROM sections
WHERE template_id = @template_id
ORDER BY section_order;

SELECT CONCAT('Template ID: ', @template_id) AS 'Use This ID';
