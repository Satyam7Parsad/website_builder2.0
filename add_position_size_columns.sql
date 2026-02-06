-- Add Position and Size Columns to Website Builder Database
-- Run this migration to add x_position, width, and z_index columns

-- Add missing position/size columns to sections table
ALTER TABLE sections ADD COLUMN IF NOT EXISTS x_position REAL DEFAULT 0;
ALTER TABLE sections ADD COLUMN IF NOT EXISTS width REAL DEFAULT 800;
ALTER TABLE sections ADD COLUMN IF NOT EXISTS z_index INTEGER DEFAULT 0;

SELECT 'Position and size columns added successfully!' AS status;
