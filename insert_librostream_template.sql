-- ============================================================================
-- LibroStream - Library Management System Template
-- Converted from HTML/Tailwind CSS
-- ============================================================================

USE website_builder;

-- Insert main template record
INSERT INTO templates (
    template_name,
    description,
    project_name,
    created_date
) VALUES (
    'LibroStream - Library Management',
    'Modern library management system with book catalog, search functionality, and reservation system. Clean blue and white design with book cards and status badges. Perfect for libraries, bookstores, and reading platforms.',
    'LibroStream Template',
    NOW()
);

-- Get the template ID
SET @template_id = LAST_INSERT_ID();

-- ============================================================================
-- Section 1: Navigation Bar
-- ============================================================================
INSERT INTO sections (
    template_id, section_order, type, name, section_id,
    height, padding, text_align,
    title, subtitle, content,
    button_text, button_link,
    title_font_size, title_font_weight,
    nav_font_size, nav_font_weight,
    button_font_size, button_font_weight,
    title_color, subtitle_color, content_color,
    bg_color, text_color, accent_color,
    button_bg_color, button_text_color,
    use_bg_image, bg_overlay_opacity
) VALUES (
    @template_id, 1, 1, 'Navigation Bar', 'navbar',
    70, 16, 0,
    'LibroStream', '', '',
    'Login', '#login',
    24, 700,
    16, 400,
    16, 600,
    '1.0,1.0,1.0,1.0', '1.0,1.0,1.0,0.9', '1.0,1.0,1.0,0.8',
    '0.114,0.306,0.847,1.0', '1.0,1.0,1.0,1.0', '0.145,0.388,0.922,1.0',
    '1.0,1.0,1.0,1.0', '0.114,0.306,0.847,1.0',
    0, 0.50
);
-- Note: Navigation items (Catalog, My Books) will be added manually in the builder
-- bg-blue-700: RGB(29, 78, 216) = 0.114, 0.306, 0.847
-- button bg: white, text: blue-700

-- ============================================================================
-- Section 2: Hero/Header with Search
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
    @template_id, 2, 0, 'Hero - Find Your Next Adventure', 'hero-search',
    300, 48, 1,
    'Find Your Next Adventure',
    'Search by title, author, or ISBN...',
    'Discover thousands of books in our digital library',
    'Search', '#search',
    36, 700,
    16, 400,
    16, 400,
    16, 600,
    '0.122,0.161,0.216,1.0', '0.420,0.447,0.502,1.0', '0.420,0.447,0.502,1.0',
    '1.0,1.0,1.0,1.0', '0.122,0.161,0.216,1.0', '0.145,0.388,0.922,1.0',
    '0.145,0.388,0.922,1.0', '1.0,1.0,1.0,1.0',
    '', 0, 0.50
);
-- bg-white: RGB(255, 255, 255)
-- text-gray-800: RGB(31, 41, 55) = 0.122, 0.161, 0.216
-- bg-blue-600: RGB(37, 99, 235) = 0.145, 0.388, 0.922

-- ============================================================================
-- Section 3: Featured Books (Cards Section)
-- ============================================================================
INSERT INTO sections (
    template_id, section_order, type, name, section_id,
    height, padding, text_align,
    title, subtitle, content,
    title_font_size, title_font_weight,
    subtitle_font_size, subtitle_font_weight,
    content_font_size, content_font_weight,
    button_font_size, button_font_weight,
    title_color, subtitle_color, content_color,
    bg_color, text_color, accent_color,
    button_bg_color, button_text_color,
    cards_per_row, card_spacing, card_width, card_height,
    use_bg_image, bg_overlay_opacity
) VALUES (
    @template_id, 3, 4, 'Featured Books', 'featured-books',
    600, 40, 0,
    'Featured Books',
    'Browse our collection of popular titles',
    'All books available for reservation',
    24, 600,
    18, 400,
    16, 400,
    16, 600,
    '0.278,0.322,0.376,1.0', '0.420,0.447,0.502,1.0', '0.420,0.447,0.502,1.0',
    '0.976,0.980,0.984,1.0', '0.122,0.161,0.216,1.0', '0.145,0.388,0.922,1.0',
    '0.122,0.161,0.216,1.0', '1.0,1.0,1.0,1.0',
    4, 32, 280, 380,
    0, 0.50
);
-- bg-gray-50: RGB(249, 250, 251) = 0.976, 0.980, 0.984
-- text-gray-700: RGB(71, 85, 105) = 0.278, 0.322, 0.376
-- button bg-gray-800: RGB(31, 41, 55)

-- Get the section ID for featured books cards
SET @books_section_id = LAST_INSERT_ID();

-- ============================================================================
-- Book Card Components (Sample Books)
-- ============================================================================

-- Book 1: The Great Gatsby (Available)
INSERT INTO template_components (
    template_id,
    component_order,
    type,
    custom_text,
    bg_color_r, bg_color_g, bg_color_b, bg_color_a,
    text_color_r, text_color_g, text_color_b, text_color_a,
    font_size, font_weight,
    border_radius
) VALUES (
    @template_id,
    1,
    0, -- Card type
    'The Great Gatsby|F. Scott Fitzgerald|Available|Reserve Book',
    1.0, 1.0, 1.0, 1.0, -- White background
    0.122, 0.161, 0.216, 1.0, -- Gray-800 text
    18, 700,
    12
);

-- Book 2: Atomic Habits (Borrowed)
INSERT INTO template_components (
    template_id,
    component_order,
    type,
    custom_text,
    bg_color_r, bg_color_g, bg_color_b, bg_color_a,
    text_color_r, text_color_g, text_color_b, text_color_a,
    font_size, font_weight,
    border_radius
) VALUES (
    @template_id,
    2,
    0, -- Card type
    'Atomic Habits|James Clear|Borrowed|Waitlist',
    1.0, 1.0, 1.0, 1.0, -- White background
    0.122, 0.161, 0.216, 1.0, -- Gray-800 text
    18, 700,
    12
);

-- Book 3: To Kill a Mockingbird (Available)
INSERT INTO template_components (
    template_id,
    component_order,
    type,
    custom_text,
    bg_color_r, bg_color_g, bg_color_b, bg_color_a,
    text_color_r, text_color_g, text_color_b, text_color_a,
    font_size, font_weight,
    border_radius
) VALUES (
    @template_id,
    3,
    0,
    'To Kill a Mockingbird|Harper Lee|Available|Reserve Book',
    1.0, 1.0, 1.0, 1.0,
    0.122, 0.161, 0.216, 1.0,
    18, 700,
    12
);

-- Book 4: 1984 (Available)
INSERT INTO template_components (
    template_id,
    component_order,
    type,
    custom_text,
    bg_color_r, bg_color_g, bg_color_b, bg_color_a,
    text_color_r, text_color_g, text_color_b, text_color_a,
    font_size, font_weight,
    border_radius
) VALUES (
    @template_id,
    4,
    0,
    '1984|George Orwell|Available|Reserve Book',
    1.0, 1.0, 1.0, 1.0,
    0.122, 0.161, 0.216, 1.0,
    18, 700,
    12
);

-- ============================================================================
-- Verify the insertion
-- ============================================================================
SELECT '=== LibroStream Template Created Successfully ===';

SELECT
    id AS 'Template ID',
    template_name AS 'Template Name',
    description AS 'Description',
    created_date AS 'Created'
FROM templates
WHERE template_name = 'LibroStream - Library Management';

SELECT '=== Sections Created ===';

SELECT
    section_order AS '#',
    name AS 'Section Name',
    type AS 'Type',
    height AS 'Height',
    LEFT(title, 40) AS 'Title'
FROM sections
WHERE template_id = @template_id
ORDER BY section_order;

SELECT '=== Book Components Created ===';

SELECT
    component_order AS '#',
    LEFT(custom_text, 60) AS 'Book Data'
FROM template_components
WHERE template_id = @template_id
ORDER BY component_order;

SELECT CONCAT('Template ID: ', @template_id, ' - Ready to load!') AS 'Status';
