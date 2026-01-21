-- Add navbar background and text color fields to sections table
-- Fix for navbar color not saving issue

ALTER TABLE sections
ADD COLUMN IF NOT EXISTS nav_bg_color VARCHAR(50) DEFAULT 'rgba(255,255,255,1)',
ADD COLUMN IF NOT EXISTS nav_text_color VARCHAR(50) DEFAULT 'rgba(51,51,51,1)';

-- Update existing navbar sections with default colors
UPDATE sections
SET nav_bg_color = 'rgba(255,255,255,1)',
    nav_text_color = 'rgba(51,51,51,1)'
WHERE type = 1 AND (nav_bg_color IS NULL OR nav_text_color IS NULL);

COMMENT ON COLUMN sections.nav_bg_color IS 'Navigation bar background color';
COMMENT ON COLUMN sections.nav_text_color IS 'Navigation bar text color';
