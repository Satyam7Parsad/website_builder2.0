-- ============================================================================
-- Website Builder v2.0 - Complete Enhancement Migration
-- Phases 1, 2, 3: Dynamic Types + Layout Engine + Interactive Elements
-- ============================================================================

BEGIN;

-- ============================================================================
-- PHASE 1: Dynamic Section Types
-- ============================================================================

-- Section type registry
CREATE TABLE IF NOT EXISTS section_types (
    id SERIAL PRIMARY KEY,
    type_name VARCHAR(100) UNIQUE NOT NULL,
    display_name VARCHAR(200) NOT NULL,
    description TEXT,
    is_builtin BOOLEAN DEFAULT FALSE,
    default_layout VARCHAR(50) DEFAULT 'stacked',
    preview_template VARCHAR(100),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Property definitions per type
CREATE TABLE IF NOT EXISTS property_definitions (
    id SERIAL PRIMARY KEY,
    section_type_id INTEGER NOT NULL,
    property_name VARCHAR(100) NOT NULL,
    display_name VARCHAR(200) NOT NULL,
    property_type VARCHAR(50) NOT NULL,
    default_value TEXT,
    min_value REAL,
    max_value REAL,
    category VARCHAR(100),
    display_order INTEGER DEFAULT 0,
    FOREIGN KEY (section_type_id) REFERENCES section_types(id) ON DELETE CASCADE,
    UNIQUE(section_type_id, property_name)
);

-- Custom property values for dynamic sections
CREATE TABLE IF NOT EXISTS section_custom_properties (
    id SERIAL PRIMARY KEY,
    section_id INTEGER NOT NULL,
    property_name VARCHAR(100) NOT NULL,
    property_value TEXT,
    FOREIGN KEY (section_id) REFERENCES sections(id) ON DELETE CASCADE,
    UNIQUE(section_id, property_name)
);

-- Update sections table for dynamic types
ALTER TABLE sections
ADD COLUMN IF NOT EXISTS type_name VARCHAR(100),
ADD COLUMN IF NOT EXISTS use_legacy_type BOOLEAN DEFAULT TRUE,
ADD COLUMN IF NOT EXISTS type_fingerprint JSONB;

-- ============================================================================
-- PHASE 2: Flexbox/Grid Layout Engine
-- ============================================================================

-- Layout properties for sections
CREATE TABLE IF NOT EXISTS section_layout_properties (
    id SERIAL PRIMARY KEY,
    section_id INTEGER NOT NULL UNIQUE,
    layout_mode INTEGER DEFAULT 0,  -- 0=stacked, 1=flexbox, 2=grid, 3=absolute

    -- Flexbox properties
    flex_direction VARCHAR(50) DEFAULT 'row',
    justify_content VARCHAR(50) DEFAULT 'flex-start',
    align_items VARCHAR(50) DEFAULT 'stretch',
    flex_wrap VARCHAR(50) DEFAULT 'nowrap',
    flex_gap REAL DEFAULT 0,

    -- Grid properties
    grid_template_columns TEXT,
    grid_template_rows TEXT,
    grid_gap REAL DEFAULT 20,
    row_gap REAL DEFAULT 20,
    column_gap REAL DEFAULT 20,
    grid_auto_flow VARCHAR(50) DEFAULT 'row',

    FOREIGN KEY (section_id) REFERENCES sections(id) ON DELETE CASCADE
);

-- Child layout properties (for cards/items in flex/grid containers)
CREATE TABLE IF NOT EXISTS child_layout_properties (
    id SERIAL PRIMARY KEY,
    section_id INTEGER NOT NULL,
    item_index INTEGER NOT NULL,

    -- Flexbox child properties
    flex_grow REAL DEFAULT 0,
    flex_shrink REAL DEFAULT 1,
    flex_basis VARCHAR(50) DEFAULT 'auto',
    align_self VARCHAR(50) DEFAULT 'auto',

    -- Grid child properties
    grid_column_start INTEGER DEFAULT 0,
    grid_column_end INTEGER DEFAULT 0,
    grid_row_start INTEGER DEFAULT 0,
    grid_row_end INTEGER DEFAULT 0,

    FOREIGN KEY (section_id) REFERENCES sections(id) ON DELETE CASCADE,
    UNIQUE(section_id, item_index)
);

-- Add layout data column to sections for JSON storage
ALTER TABLE sections
ADD COLUMN IF NOT EXISTS layout_data JSONB;

-- ============================================================================
-- PHASE 3: Interactive Elements
-- ============================================================================

-- Interactive elements table
CREATE TABLE IF NOT EXISTS interactive_elements (
    id SERIAL PRIMARY KEY,
    section_id INTEGER NOT NULL,
    element_index INTEGER NOT NULL,
    element_type INTEGER NOT NULL DEFAULT 0,  -- 0=none, 1=dropdown, 2=carousel, 3=modal, etc.
    element_id VARCHAR(100),

    -- Hover state styling
    hover_enabled BOOLEAN DEFAULT FALSE,
    hover_bg_color VARCHAR(50),
    hover_text_color VARCHAR(50),
    hover_scale REAL DEFAULT 1.0,
    hover_opacity REAL DEFAULT 1.0,
    hover_border_width REAL DEFAULT 0,
    hover_border_color VARCHAR(50),
    hover_transform TEXT,

    -- Animation settings
    transition_duration REAL DEFAULT 0.3,
    easing_function VARCHAR(50) DEFAULT 'ease-in-out',

    -- Dropdown data (JSON array)
    dropdown_items TEXT,
    selected_index INTEGER DEFAULT 0,

    -- Carousel data
    carousel_images TEXT,
    carousel_auto_play_speed REAL DEFAULT 0,
    carousel_show_dots BOOLEAN DEFAULT TRUE,
    carousel_show_arrows BOOLEAN DEFAULT TRUE,

    -- Modal data
    modal_title VARCHAR(255),
    modal_content TEXT,
    modal_width REAL DEFAULT 600,
    modal_height REAL DEFAULT 400,
    modal_backdrop_blur BOOLEAN DEFAULT TRUE,

    -- Accordion data (JSON)
    accordion_items TEXT,

    -- Tab data (JSON)
    tab_labels TEXT,
    tab_contents TEXT,

    FOREIGN KEY (section_id) REFERENCES sections(id) ON DELETE CASCADE,
    UNIQUE(section_id, element_index)
);

-- Add interactive data column to sections for JSON storage
ALTER TABLE sections
ADD COLUMN IF NOT EXISTS interactive_data JSONB,
ADD COLUMN IF NOT EXISTS glass_effect JSONB;

-- ============================================================================
-- CREATE INDEXES
-- ============================================================================

CREATE INDEX IF NOT EXISTS idx_property_defs_section_type ON property_definitions(section_type_id);
CREATE INDEX IF NOT EXISTS idx_custom_props_section ON section_custom_properties(section_id);
CREATE INDEX IF NOT EXISTS idx_layout_props_section ON section_layout_properties(section_id);
CREATE INDEX IF NOT EXISTS idx_child_layout_section ON child_layout_properties(section_id);
CREATE INDEX IF NOT EXISTS idx_interactive_section ON interactive_elements(section_id);

-- ============================================================================
-- POPULATE BUILT-IN SECTION TYPES (20 Original Types)
-- ============================================================================

INSERT INTO section_types (type_name, display_name, description, is_builtin) VALUES
('hero', 'Hero Section', 'Large banner with headline and CTA button', TRUE),
('navbar', 'Navigation Bar', 'Top navigation menu with logo and links', TRUE),
('about', 'About Section', 'Company or product information section', TRUE),
('services', 'Services', 'Service cards in grid layout', TRUE),
('cards', 'Card Grid', 'Generic card layout for any content', TRUE),
('team', 'Team Section', 'Team member profiles with photos', TRUE),
('pricing', 'Pricing Tables', 'Pricing tiers comparison table', TRUE),
('testimonials', 'Testimonials', 'Customer reviews and testimonials', TRUE),
('gallery', 'Image Gallery', 'Photo grid with lightbox support', TRUE),
('blog', 'Blog Posts', 'Blog post cards with excerpts', TRUE),
('contact', 'Contact Form', 'Contact form with input fields', TRUE),
('footer', 'Footer', 'Site footer with links and social icons', TRUE),
('faq', 'FAQ Section', 'Accordion-style FAQ items', TRUE),
('cta', 'Call to Action', 'Conversion-focused CTA section', TRUE),
('features', 'Features', 'Product features grid', TRUE),
('stats', 'Statistics', 'Numeric statistics display', TRUE),
('login', 'Login Form', 'User login interface', TRUE),
('image', 'Image', 'Standalone image section', TRUE),
('textbox', 'Text Box', 'Rich text content block', TRUE),
('custom', 'Custom Section', 'Blank custom section', TRUE)
ON CONFLICT (type_name) DO NOTHING;

-- ============================================================================
-- MIGRATE EXISTING SECTIONS TO USE TYPE_NAME
-- ============================================================================

UPDATE sections SET type_name =
  CASE type
    WHEN 0 THEN 'hero'
    WHEN 1 THEN 'navbar'
    WHEN 2 THEN 'about'
    WHEN 3 THEN 'services'
    WHEN 4 THEN 'cards'
    WHEN 5 THEN 'team'
    WHEN 6 THEN 'pricing'
    WHEN 7 THEN 'testimonials'
    WHEN 8 THEN 'gallery'
    WHEN 9 THEN 'blog'
    WHEN 10 THEN 'contact'
    WHEN 11 THEN 'footer'
    WHEN 12 THEN 'faq'
    WHEN 13 THEN 'cta'
    WHEN 14 THEN 'features'
    WHEN 15 THEN 'stats'
    WHEN 16 THEN 'login'
    WHEN 17 THEN 'image'
    WHEN 18 THEN 'textbox'
    WHEN 19 THEN 'custom'
    ELSE 'custom'
  END
WHERE type_name IS NULL;

-- ============================================================================
-- CREATE DEFAULT LAYOUT PROPERTIES FOR EXISTING SECTIONS
-- ============================================================================

INSERT INTO section_layout_properties (section_id, layout_mode)
SELECT id, 0 FROM sections
ON CONFLICT (section_id) DO NOTHING;

COMMIT;

-- ============================================================================
-- VERIFICATION QUERIES
-- ============================================================================

SELECT 'Migration completed successfully!' AS status;
SELECT COUNT(*) AS built_in_types FROM section_types WHERE is_builtin = TRUE;
SELECT COUNT(*) AS sections_migrated FROM sections WHERE type_name IS NOT NULL;
SELECT COUNT(*) AS sections_with_layout FROM section_layout_properties;
