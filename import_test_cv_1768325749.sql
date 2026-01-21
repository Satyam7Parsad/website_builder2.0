-- Import Scraped Template: test_cv_1768325749
-- Generated: 2026-01-13 23:06:18
-- Source: https://example.com
-- Sections: 0
--
-- Run this script to import the template into PostgreSQL:
-- psql -d website_builder < test_cv_1768325749.sql
--


BEGIN;

-- Insert the template
INSERT INTO templates (template_name, description, project_name, created_date)
VALUES (
    'test_cv_1768325749',
    'Imported from https://example.com',
    'Test Cv 1768325749',
    '2026-01-13 23:06:18'
);


-- Get the template ID
DO $$
DECLARE
    template_id_var integer;
BEGIN
    SELECT id INTO template_id_var FROM templates WHERE template_name = 'test_cv_1768325749';

END $$;

COMMIT;


-- Template import complete!
-- Template name: test_cv_1768325749
-- Total sections: 0
--
-- To verify the import:
-- SELECT * FROM templates WHERE template_name = 'test_cv_1768325749';
-- SELECT COUNT(*) FROM sections WHERE template_id = (SELECT id FROM templates WHERE template_name = 'test_cv_1768325749');

-- Update sections with BYTEA image data
