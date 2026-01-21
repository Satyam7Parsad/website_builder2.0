-- Database Migration for Website Builder v3.0
-- Adds new fields for width control, positioning, and spacing

USE website_builder;

-- Add new columns to sections table
ALTER TABLE sections
ADD COLUMN IF NOT EXISTS y_position FLOAT DEFAULT 0 AFTER height,
ADD COLUMN IF NOT EXISTS card_padding INT DEFAULT 25 AFTER card_spacing,
ADD COLUMN IF NOT EXISTS heading_to_cards_spacing FLOAT DEFAULT 40 AFTER cards_per_row,
ADD COLUMN IF NOT EXISTS section_width_percent FLOAT DEFAULT 100.0 AFTER bg_overlay_opacity,
ADD COLUMN IF NOT EXISTS horizontal_align INT DEFAULT 0 AFTER section_width_percent,
ADD COLUMN IF NOT EXISTS use_manual_position TINYINT(1) DEFAULT 0 AFTER horizontal_align;

-- Display success message
SELECT 'Migration completed successfully! New columns added.' AS Status;
