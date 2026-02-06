-- Add Connector Support to Website Builder Database
-- Run this migration to add connector columns

-- Add connector columns to sections table
ALTER TABLE sections ADD COLUMN IF NOT EXISTS text_blocks_json TEXT;
ALTER TABLE sections ADD COLUMN IF NOT EXISTS text_content_width REAL DEFAULT 700;
ALTER TABLE sections ADD COLUMN IF NOT EXISTS text_padding REAL DEFAULT 30;

ALTER TABLE sections ADD COLUMN IF NOT EXISTS bar_items_json TEXT;

ALTER TABLE sections ADD COLUMN IF NOT EXISTS footer_columns_json TEXT;
ALTER TABLE sections ADD COLUMN IF NOT EXISTS footer_heading_color VARCHAR(50) DEFAULT '1.0,1.0,1.0,1.0';
ALTER TABLE sections ADD COLUMN IF NOT EXISTS footer_subheading_color VARCHAR(50) DEFAULT '1.0,1.0,1.0,0.9';
ALTER TABLE sections ADD COLUMN IF NOT EXISTS footer_heading_size REAL DEFAULT 1.3;
ALTER TABLE sections ADD COLUMN IF NOT EXISTS footer_subheading_size REAL DEFAULT 1.0;
ALTER TABLE sections ADD COLUMN IF NOT EXISTS footer_heading_boldness REAL DEFAULT 1.5;
ALTER TABLE sections ADD COLUMN IF NOT EXISTS footer_subheading_boldness REAL DEFAULT 0;
ALTER TABLE sections ADD COLUMN IF NOT EXISTS footer_column_width REAL DEFAULT 280;
ALTER TABLE sections ADD COLUMN IF NOT EXISTS footer_item_spacing REAL DEFAULT 8;

ALTER TABLE sections ADD COLUMN IF NOT EXISTS connector_cards_json TEXT;
ALTER TABLE sections ADD COLUMN IF NOT EXISTS connector_cards_per_row INTEGER DEFAULT 3;
ALTER TABLE sections ADD COLUMN IF NOT EXISTS connector_card_spacing REAL DEFAULT 20;

ALTER TABLE sections ADD COLUMN IF NOT EXISTS vertical_blocks_json TEXT;
ALTER TABLE sections ADD COLUMN IF NOT EXISTS vertical_heading_color VARCHAR(50) DEFAULT '0.1,0.1,0.1,1.0';
ALTER TABLE sections ADD COLUMN IF NOT EXISTS vertical_desc_color VARCHAR(50) DEFAULT '0.3,0.3,0.3,1.0';
ALTER TABLE sections ADD COLUMN IF NOT EXISTS vertical_heading_size REAL DEFAULT 1.2;
ALTER TABLE sections ADD COLUMN IF NOT EXISTS vertical_desc_size REAL DEFAULT 1.0;
ALTER TABLE sections ADD COLUMN IF NOT EXISTS vertical_heading_boldness REAL DEFAULT 1.5;
ALTER TABLE sections ADD COLUMN IF NOT EXISTS vertical_desc_boldness REAL DEFAULT 0;
ALTER TABLE sections ADD COLUMN IF NOT EXISTS vertical_content_width REAL DEFAULT 500;
ALTER TABLE sections ADD COLUMN IF NOT EXISTS vertical_spacing REAL DEFAULT 15;

SELECT 'Connector columns added successfully!' AS status;
