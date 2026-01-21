-- PostgreSQL Database Setup for Website Builder v4.0
-- Drop and recreate database

DROP DATABASE IF EXISTS website_builder;
CREATE DATABASE website_builder;

-- Connect to the database
\c website_builder

-- Create templates table
CREATE TABLE IF NOT EXISTS templates (
    id SERIAL PRIMARY KEY,
    template_name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    project_name VARCHAR(100),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create sections table
CREATE TABLE IF NOT EXISTS sections (
    id SERIAL PRIMARY KEY,
    template_id INTEGER NOT NULL,
    section_order INTEGER DEFAULT 0,
    type INTEGER NOT NULL,
    name VARCHAR(100),
    section_id VARCHAR(100),
    height INTEGER DEFAULT 400,
    y_position REAL DEFAULT 0,

    -- Content fields
    title TEXT,
    subtitle TEXT,
    content TEXT,
    button_text VARCHAR(100),
    button_link VARCHAR(255),

    -- Typography
    title_font_size INTEGER DEFAULT 42,
    title_font_weight INTEGER DEFAULT 700,
    subtitle_font_size INTEGER DEFAULT 20,
    subtitle_font_weight INTEGER DEFAULT 400,
    content_font_size INTEGER DEFAULT 16,
    content_font_weight INTEGER DEFAULT 400,
    button_font_size INTEGER DEFAULT 16,
    button_font_weight INTEGER DEFAULT 600,
    nav_font_size INTEGER DEFAULT 15,
    nav_font_weight INTEGER DEFAULT 500,

    -- Colors (stored as "r,g,b,a" strings)
    title_color VARCHAR(50) DEFAULT '0.1,0.1,0.1,1.0',
    subtitle_color VARCHAR(50) DEFAULT '0.3,0.3,0.3,1.0',
    content_color VARCHAR(50) DEFAULT '0.2,0.2,0.2,1.0',
    bg_color VARCHAR(50) DEFAULT '1.0,1.0,1.0,1.0',
    text_color VARCHAR(50) DEFAULT '0.1,0.1,0.1,1.0',
    accent_color VARCHAR(50) DEFAULT '0.2,0.5,1.0,1.0',
    button_bg_color VARCHAR(50) DEFAULT '0.2,0.5,1.0,1.0',
    button_text_color VARCHAR(50) DEFAULT '1.0,1.0,1.0,1.0',

    -- Layout settings
    padding INTEGER DEFAULT 60,
    text_align INTEGER DEFAULT 1,
    card_width INTEGER DEFAULT 300,
    card_height INTEGER DEFAULT 250,
    card_spacing INTEGER DEFAULT 20,
    card_padding INTEGER DEFAULT 25,
    cards_per_row INTEGER DEFAULT 3,
    heading_to_cards_spacing REAL DEFAULT 40,

    -- Images (stored as BYTEA for binary data)
    background_image VARCHAR(255),
    background_image_data BYTEA,
    section_image VARCHAR(255),
    section_image_data BYTEA,
    use_bg_image BOOLEAN DEFAULT FALSE,
    bg_overlay_opacity REAL DEFAULT 0.5,

    -- Width and positioning (v4.0 features)
    section_width_percent REAL DEFAULT 100.0,
    horizontal_align INTEGER DEFAULT 0,
    use_manual_position BOOLEAN DEFAULT FALSE,

    FOREIGN KEY (template_id) REFERENCES templates(id) ON DELETE CASCADE
);

-- Create indexes for better performance
CREATE INDEX idx_sections_template_id ON sections(template_id);
CREATE INDEX idx_sections_order ON sections(section_order);

-- Display success message
SELECT 'PostgreSQL database and tables created successfully!' AS status;
