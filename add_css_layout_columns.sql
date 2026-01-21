-- ============================================================================
-- ADD CSS LAYOUT COLUMNS TO SECTIONS TABLE
-- This adds support for Flexbox, Grid, and CSS properties
-- ============================================================================

BEGIN;

-- Add Flexbox properties
ALTER TABLE sections
ADD COLUMN IF NOT EXISTS display VARCHAR(20) DEFAULT 'block',
ADD COLUMN IF NOT EXISTS flex_direction VARCHAR(20) DEFAULT 'row',
ADD COLUMN IF NOT EXISTS justify_content VARCHAR(30) DEFAULT 'normal',
ADD COLUMN IF NOT EXISTS align_items VARCHAR(30) DEFAULT 'normal',
ADD COLUMN IF NOT EXISTS gap REAL DEFAULT 0;

-- Add Grid properties
ALTER TABLE sections
ADD COLUMN IF NOT EXISTS grid_template_columns VARCHAR(200) DEFAULT 'none',
ADD COLUMN IF NOT EXISTS grid_template_rows VARCHAR(200) DEFAULT 'none';

-- Add 4-sided padding (instead of single padding value)
ALTER TABLE sections
ADD COLUMN IF NOT EXISTS padding_top REAL DEFAULT 60,
ADD COLUMN IF NOT EXISTS padding_right REAL DEFAULT 60,
ADD COLUMN IF NOT EXISTS padding_bottom REAL DEFAULT 60,
ADD COLUMN IF NOT EXISTS padding_left REAL DEFAULT 60;

-- Add background properties
ALTER TABLE sections
ADD COLUMN IF NOT EXISTS background_position VARCHAR(50) DEFAULT '0% 0%',
ADD COLUMN IF NOT EXISTS background_repeat VARCHAR(20) DEFAULT 'repeat',
ADD COLUMN IF NOT EXISTS background_size VARCHAR(50) DEFAULT 'auto',
ADD COLUMN IF NOT EXISTS background_image_css TEXT DEFAULT 'none';

-- Add positioning properties
ALTER TABLE sections
ADD COLUMN IF NOT EXISTS css_position VARCHAR(20) DEFAULT 'static',
ADD COLUMN IF NOT EXISTS css_top VARCHAR(20) DEFAULT 'auto',
ADD COLUMN IF NOT EXISTS css_left VARCHAR(20) DEFAULT 'auto',
ADD COLUMN IF NOT EXISTS css_right VARCHAR(20) DEFAULT 'auto',
ADD COLUMN IF NOT EXISTS css_bottom VARCHAR(20) DEFAULT 'auto',
ADD COLUMN IF NOT EXISTS css_z_index INTEGER DEFAULT 0;

-- Add border/shadow properties
ALTER TABLE sections
ADD COLUMN IF NOT EXISTS section_border_radius REAL DEFAULT 0,
ADD COLUMN IF NOT EXISTS section_box_shadow VARCHAR(100) DEFAULT 'none',
ADD COLUMN IF NOT EXISTS section_border VARCHAR(100) DEFAULT 'none',
ADD COLUMN IF NOT EXISTS section_opacity REAL DEFAULT 1.0;

-- Add typography properties
ALTER TABLE sections
ADD COLUMN IF NOT EXISTS section_line_height VARCHAR(20) DEFAULT 'normal',
ADD COLUMN IF NOT EXISTS section_letter_spacing VARCHAR(20) DEFAULT 'normal',
ADD COLUMN IF NOT EXISTS font_family VARCHAR(100) DEFAULT 'system-ui';

-- Add gradient support
ALTER TABLE sections
ADD COLUMN IF NOT EXISTS has_gradient BOOLEAN DEFAULT FALSE,
ADD COLUMN IF NOT EXISTS gradient_colors TEXT DEFAULT NULL,
ADD COLUMN IF NOT EXISTS gradient_is_radial BOOLEAN DEFAULT FALSE;

COMMIT;

-- Show added columns
SELECT column_name, data_type, column_default
FROM information_schema.columns
WHERE table_name = 'sections'
  AND column_name IN ('display', 'justify_content', 'gap', 'grid_template_columns')
ORDER BY column_name;

-- Success message
\echo '✅ CSS Layout columns added successfully!'
\echo 'Run this to verify: SELECT display, justify_content FROM sections LIMIT 5;'
