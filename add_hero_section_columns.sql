-- Add columns for Hero Section Connector
-- Run this script to update your database schema

-- HERO SECTION COLUMNS
ALTER TABLE sections ADD COLUMN IF NOT EXISTS hero_badge_text TEXT DEFAULT 'Your Premier Visual Production Partner';
ALTER TABLE sections ADD COLUMN IF NOT EXISTS hero_badge_icon_left INTEGER DEFAULT 0;
ALTER TABLE sections ADD COLUMN IF NOT EXISTS hero_badge_icon_right INTEGER DEFAULT 0;
ALTER TABLE sections ADD COLUMN IF NOT EXISTS hero_heading TEXT DEFAULT 'Transforming Ideas into';
ALTER TABLE sections ADD COLUMN IF NOT EXISTS hero_heading_accent TEXT DEFAULT 'Visual Excellence';
ALTER TABLE sections ADD COLUMN IF NOT EXISTS hero_description TEXT DEFAULT '';
ALTER TABLE sections ADD COLUMN IF NOT EXISTS hero_btn_primary_text TEXT DEFAULT 'Explore Our Services';
ALTER TABLE sections ADD COLUMN IF NOT EXISTS hero_btn_secondary_text TEXT DEFAULT 'Partner With Us';
ALTER TABLE sections ADD COLUMN IF NOT EXISTS hero_btn_primary_action INTEGER DEFAULT 0;
ALTER TABLE sections ADD COLUMN IF NOT EXISTS hero_btn_primary_target TEXT DEFAULT '';
ALTER TABLE sections ADD COLUMN IF NOT EXISTS hero_btn_secondary_action INTEGER DEFAULT 0;
ALTER TABLE sections ADD COLUMN IF NOT EXISTS hero_btn_secondary_target TEXT DEFAULT '';
ALTER TABLE sections ADD COLUMN IF NOT EXISTS hero_feature_badges_json TEXT DEFAULT '[]';
ALTER TABLE sections ADD COLUMN IF NOT EXISTS hero_stats_json TEXT DEFAULT '[]';
ALTER TABLE sections ADD COLUMN IF NOT EXISTS hero_bg_color TEXT DEFAULT '0.98,0.98,0.99,1.0';
ALTER TABLE sections ADD COLUMN IF NOT EXISTS hero_badge_bg TEXT DEFAULT '1.0,1.0,1.0,0.95';
ALTER TABLE sections ADD COLUMN IF NOT EXISTS hero_badge_text_color TEXT DEFAULT '0.2,0.2,0.25,1.0';
ALTER TABLE sections ADD COLUMN IF NOT EXISTS hero_badge_icon_color TEXT DEFAULT '0.95,0.5,0.2,1.0';
ALTER TABLE sections ADD COLUMN IF NOT EXISTS hero_heading_color TEXT DEFAULT '0.1,0.1,0.15,1.0';
ALTER TABLE sections ADD COLUMN IF NOT EXISTS hero_accent_color TEXT DEFAULT '0.95,0.5,0.2,1.0';
ALTER TABLE sections ADD COLUMN IF NOT EXISTS hero_description_color TEXT DEFAULT '0.4,0.4,0.45,1.0';
ALTER TABLE sections ADD COLUMN IF NOT EXISTS hero_btn_primary_bg TEXT DEFAULT '0.95,0.5,0.2,1.0';
ALTER TABLE sections ADD COLUMN IF NOT EXISTS hero_btn_primary_text_color TEXT DEFAULT '1.0,1.0,1.0,1.0';
ALTER TABLE sections ADD COLUMN IF NOT EXISTS hero_btn_secondary_bg TEXT DEFAULT '1.0,1.0,1.0,0.0';
ALTER TABLE sections ADD COLUMN IF NOT EXISTS hero_btn_secondary_text_color TEXT DEFAULT '0.1,0.1,0.15,1.0';
ALTER TABLE sections ADD COLUMN IF NOT EXISTS hero_btn_secondary_border TEXT DEFAULT '0.8,0.8,0.85,1.0';
ALTER TABLE sections ADD COLUMN IF NOT EXISTS hero_btn_border_radius REAL DEFAULT 30.0;
ALTER TABLE sections ADD COLUMN IF NOT EXISTS hero_badge_border_radius REAL DEFAULT 25.0;

-- Verify columns were added
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'sections'
AND column_name LIKE 'hero_%'
ORDER BY column_name;
