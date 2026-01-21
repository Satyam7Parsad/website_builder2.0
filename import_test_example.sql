-- Import Scraped Template: test_example
-- Generated: 2026-01-09 12:51:15
-- Source: https://example.com
-- Sections: 0
--
-- Run this script to import the template into PostgreSQL:
-- psql -d website_builder < test_example.sql
--


BEGIN;

-- Insert the template
INSERT INTO templates (template_name, description, project_name, created_date)
VALUES (
    'test_example',
    'Imported from example.com',
    'Test Example',
    '2026-01-09 12:51:15'
);


-- Get the template ID
DO $$
DECLARE
    template_id_var integer;
BEGIN
    SELECT id INTO template_id_var FROM templates WHERE template_name = 'test_example';

END $$;

COMMIT;


-- Template import complete!
-- Template name: test_example
-- Total sections: 0
--
-- To verify the import:
-- SELECT * FROM templates WHERE template_name = 'test_example';
-- SELECT COUNT(*) FROM sections WHERE template_id = (SELECT id FROM templates WHERE template_name = 'test_example');

-- Update sections with BYTEA image data
