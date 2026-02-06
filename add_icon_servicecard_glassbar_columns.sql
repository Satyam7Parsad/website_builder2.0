-- Add columns for Icon, Service Card, and Glass Bar connectors
-- Run this script to update your database schema

-- ICON COLUMNS
ALTER TABLE sections ADD COLUMN IF NOT EXISTS icon_type INTEGER DEFAULT 0;
ALTER TABLE sections ADD COLUMN IF NOT EXISTS icon_size REAL DEFAULT 48.0;
ALTER TABLE sections ADD COLUMN IF NOT EXISTS icon_color TEXT DEFAULT '0.2,0.2,0.4,1.0';
ALTER TABLE sections ADD COLUMN IF NOT EXISTS icon_stroke_width REAL DEFAULT 2.0;

-- SERVICE CARD COLUMNS
ALTER TABLE sections ADD COLUMN IF NOT EXISTS service_cards_json TEXT DEFAULT '[]';
ALTER TABLE sections ADD COLUMN IF NOT EXISTS service_cards_per_row INTEGER DEFAULT 3;
ALTER TABLE sections ADD COLUMN IF NOT EXISTS service_card_spacing REAL DEFAULT 20.0;

-- GLASS BAR COLUMNS
ALTER TABLE sections ADD COLUMN IF NOT EXISTS glass_bar_text TEXT DEFAULT 'Your text here';
ALTER TABLE sections ADD COLUMN IF NOT EXISTS glass_bar_highlight TEXT DEFAULT 'highlight';
ALTER TABLE sections ADD COLUMN IF NOT EXISTS glass_bar_text_color TEXT DEFAULT '0.2,0.2,0.25,1.0';
ALTER TABLE sections ADD COLUMN IF NOT EXISTS glass_bar_highlight_color TEXT DEFAULT '0.3,0.5,0.9,1.0';
ALTER TABLE sections ADD COLUMN IF NOT EXISTS glass_bar_bg_color TEXT DEFAULT '0.95,0.95,0.98,0.9';
ALTER TABLE sections ADD COLUMN IF NOT EXISTS glass_bar_opacity REAL DEFAULT 0.9;
ALTER TABLE sections ADD COLUMN IF NOT EXISTS glass_bar_border_radius REAL DEFAULT 30.0;
ALTER TABLE sections ADD COLUMN IF NOT EXISTS glass_bar_padding REAL DEFAULT 20.0;

-- Verify columns were added
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'sections'
AND column_name IN (
    'icon_type', 'icon_size', 'icon_color', 'icon_stroke_width',
    'service_cards_json', 'service_cards_per_row', 'service_card_spacing',
    'glass_bar_text', 'glass_bar_highlight', 'glass_bar_text_color',
    'glass_bar_highlight_color', 'glass_bar_bg_color', 'glass_bar_opacity',
    'glass_bar_border_radius', 'glass_bar_padding'
)
ORDER BY column_name;
