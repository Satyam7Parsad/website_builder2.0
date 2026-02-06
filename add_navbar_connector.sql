-- Add Navbar Connector Support to Website Builder Database
-- Run this migration to add navbar connector columns

-- Add navbar connector columns to sections table
ALTER TABLE sections ADD COLUMN IF NOT EXISTS navbar_items_json TEXT;
ALTER TABLE sections ADD COLUMN IF NOT EXISTS navbar_bg_color VARCHAR(50) DEFAULT '0.12,0.12,0.12,1.0';
ALTER TABLE sections ADD COLUMN IF NOT EXISTS navbar_hover_color VARCHAR(50) DEFAULT '0.26,0.26,0.26,1.0';
ALTER TABLE sections ADD COLUMN IF NOT EXISTS navbar_dropdown_color VARCHAR(50) DEFAULT '0.18,0.18,0.18,1.0';
ALTER TABLE sections ADD COLUMN IF NOT EXISTS navbar_text_color VARCHAR(50) DEFAULT '1.0,1.0,1.0,1.0';
ALTER TABLE sections ADD COLUMN IF NOT EXISTS navbar_height REAL DEFAULT 42;
ALTER TABLE sections ADD COLUMN IF NOT EXISTS navbar_padding_x REAL DEFAULT 10;
ALTER TABLE sections ADD COLUMN IF NOT EXISTS navbar_padding_y REAL DEFAULT 8;
ALTER TABLE sections ADD COLUMN IF NOT EXISTS navbar_spacing REAL DEFAULT 18;
ALTER TABLE sections ADD COLUMN IF NOT EXISTS navbar_rounding REAL DEFAULT 4;
ALTER TABLE sections ADD COLUMN IF NOT EXISTS navbar_font_scale REAL DEFAULT 1.0;
ALTER TABLE sections ADD COLUMN IF NOT EXISTS navbar_rounded BOOLEAN DEFAULT TRUE;

SELECT 'Navbar connector columns added successfully!' AS status;
