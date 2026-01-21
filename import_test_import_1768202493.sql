-- Import Scraped Template: test_import_1768202493
-- Generated: 2026-01-12 12:52:08
-- Source: https://example.com
-- Sections: 0
--
-- Run this script to import the template into PostgreSQL:
-- psql -d website_builder < test_import_1768202493.sql
--


BEGIN;

-- Insert the template
INSERT INTO templates (template_name, description, project_name, created_date)
VALUES (
    'test_import_1768202493',
    'Imported from example.com',
    'Test Import 1768202493',
    '2026-01-12 12:52:08'
);


-- Get the template ID
DO $$
DECLARE
    template_id_var integer;
BEGIN
    SELECT id INTO template_id_var FROM templates WHERE template_name = 'test_import_1768202493';

END $$;

COMMIT;


-- Template import complete!
-- Template name: test_import_1768202493
-- Total sections: 0
--
-- To verify the import:
-- SELECT * FROM templates WHERE template_name = 'test_import_1768202493';
-- SELECT COUNT(*) FROM sections WHERE template_id = (SELECT id FROM templates WHERE template_name = 'test_import_1768202493');

-- Update sections with BYTEA image data
