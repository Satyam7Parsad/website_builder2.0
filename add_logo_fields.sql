-- Add Logo Size and Brand Text Position fields to sections table
-- Run this migration to add logo control features

ALTER TABLE sections
ADD COLUMN IF NOT EXISTS logo_size REAL DEFAULT 50.0,
ADD COLUMN IF NOT EXISTS brand_text_position INTEGER DEFAULT 0;

-- Update existing records with default values
UPDATE sections
SET logo_size = 50.0,
    brand_text_position = 0
WHERE logo_size IS NULL OR brand_text_position IS NULL;

-- Comments
COMMENT ON COLUMN sections.logo_size IS 'Logo size in pixels (30-150px)';
COMMENT ON COLUMN sections.brand_text_position IS 'Brand text position: 0=side, 1=above, 2=below logo';
