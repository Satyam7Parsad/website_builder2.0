-- Add support for multi-image features in PostgreSQL
-- Date: 2026-01-07

\c website_builder

-- Add columns for Hero Animation (slideshow images)
ALTER TABLE sections ADD COLUMN IF NOT EXISTS hero_animation_images TEXT[];
ALTER TABLE sections ADD COLUMN IF NOT EXISTS hero_animation_images_data BYTEA[];
ALTER TABLE sections ADD COLUMN IF NOT EXISTS enable_hero_animation BOOLEAN DEFAULT FALSE;
ALTER TABLE sections ADD COLUMN IF NOT EXISTS hero_animation_speed REAL DEFAULT 3.0;

-- Add columns for Gallery images
ALTER TABLE sections ADD COLUMN IF NOT EXISTS gallery_images TEXT[];
ALTER TABLE sections ADD COLUMN IF NOT EXISTS gallery_images_data BYTEA[];
ALTER TABLE sections ADD COLUMN IF NOT EXISTS gallery_columns INTEGER DEFAULT 3;
ALTER TABLE sections ADD COLUMN IF NOT EXISTS gallery_spacing REAL DEFAULT 20.0;

-- Add columns for Navbar logo
ALTER TABLE sections ADD COLUMN IF NOT EXISTS logo_path TEXT;
ALTER TABLE sections ADD COLUMN IF NOT EXISTS logo_data BYTEA;

-- Add comment
COMMENT ON TABLE sections IS 'Website sections with multi-image support added 2026-01-07';

-- Verify changes
\d sections
