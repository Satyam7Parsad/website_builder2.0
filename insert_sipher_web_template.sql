-- ============================================================================
-- Sipher Web E-Commerce Agency Template
-- Insert into website_builder database
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
    'Professional tech agency website with glass morphism design. Features hero section with coding background, feature cards, modern navigation, and clean typography. Perfect for tech companies, SaaS platforms, and digital agencies.',
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
    subtitle_font_size, subtitle_font_weight,
    content_font_size, content_font_weight,
    title_color, subtitle_color, content_color,
    bg_color, text_color, accent_color,
    use_bg_image, bg_overlay_opacity
) VALUES (
    @template_id, 1, 0, 'Top Announcement Bar', 'top-bar',
    50, 12, 1,
    'Trusted by 100+ Enterprise Clients Worldwide  •  Delivering Innovation & Excellence Since 2022  •  Contact Us: +91 8318230713',
    '', '',
    14, 400,
    16, 400,
    16, 400,
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
    button_bg_color, button_text_color,
    use_bg_image, bg_overlay_opacity
) VALUES (
    @template_id, 2, 1, 'Navigation Bar', 'navbar',
    80, 20, 0,
    'Sipher Web Pvt. Ltd.', '', '',
    24, 700,
    16, 500,
    '0.051,0.051,0.227,1.0', '0.3,0.3,0.3,1.0', '0.2,0.2,0.2,1.0',
    '1.0,1.0,1.0,1.0', '0.051,0.051,0.227,1.0', '1.0,0.549,0.0,1.0',
    '1.0,0.549,0.0,1.0', '1.0,1.0,1.0,1.0',
    0, 0.50
);

-- Navigation items will be added programmatically or via nav_items JSON field if supported

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
    'Transform your online store with our cutting-edge technology platform designed for growth and scalability.',
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
-- Note: Upload a coding background image after template loads

-- ============================================================================
-- Section 4: Feature Cards
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
    button_bg_color, button_text_color,
    cards_per_row, card_spacing,
    use_bg_image, bg_overlay_opacity
) VALUES (
    @template_id, 4, 4, 'Feature Cards', 'features',
    400, 80, 1,
    'Why Choose Us',
    'Built for the modern digital economy',
    '',
    42, 700,
    20, 400,
    16, 400,
    '1.0,1.0,1.0,1.0', '1.0,1.0,1.0,0.8', '1.0,1.0,1.0,0.7',
    '0.051,0.051,0.227,1.0', '1.0,1.0,1.0,1.0', '1.0,0.549,0.0,1.0',
    '1.0,0.549,0.0,1.0', '1.0,1.0,1.0,1.0',
    3, 30,
    0, 0.50
);

-- Get the section ID for feature cards
SET @feature_section_id = LAST_INSERT_ID();

-- Insert the three feature cards as components
-- Card 1: Secure
INSERT INTO template_components (
    section_id,
    component_order,
    component_type,
    title,
    description,
    icon,
    bg_color,
    text_color
) VALUES (
    @feature_section_id,
    1,
    'card',
    'Secure',
    'Protected Payments',
    '🛡️',
    '0.102,0.102,0.302,0.5',
    '1.0,1.0,1.0,1.0'
);

-- Card 2: Analytics
INSERT INTO template_components (
    section_id,
    component_order,
    component_type,
    title,
    description,
    icon,
    bg_color,
    text_color
) VALUES (
    @feature_section_id,
    2,
    'card',
    'Analytics',
    'Data Insights',
    '📊',
    '0.102,0.102,0.302,0.5',
    '1.0,1.0,1.0,1.0'
);

-- Card 3: Scalable
INSERT INTO template_components (
    section_id,
    component_order,
    component_type,
    title,
    description,
    icon,
    bg_color,
    text_color
) VALUES (
    @feature_section_id,
    3,
    'card',
    'Scalable',
    'Growth Ready',
    '🚀',
    '0.102,0.102,0.302,0.5',
    '1.0,1.0,1.0,1.0'
);

-- ============================================================================
-- Verify the insertion
-- ============================================================================
SELECT
    t.id AS template_id,
    t.template_name,
    COUNT(s.id) AS section_count,
    t.created_date
FROM templates t
LEFT JOIN sections s ON t.id = s.template_id
WHERE t.template_name = 'Sipher Web - E-Commerce Agency'
GROUP BY t.id, t.template_name, t.created_date;

-- Show all sections
SELECT
    section_order,
    name,
    type,
    height,
    title
FROM sections
WHERE template_id = @template_id
ORDER BY section_order;
