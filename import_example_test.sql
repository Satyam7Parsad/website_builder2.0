-- Import Scraped Template: example_test
-- Generated: 2026-01-08 15:41:14
-- Source: https://example.com
-- Sections: 0
--
-- Run this script to import the template into PostgreSQL:
-- psql -d website_builder < example_test.sql
--


BEGIN;

-- Insert the template
INSERT INTO templates (template_name, description, project_name, created_date)
VALUES (
    'example_test',
    'Imported from example.com',
    'Example Test',
    '2026-01-08 15:41:14'
);


-- Get the template ID
DO $$
DECLARE
    template_id_var integer;
BEGIN
    SELECT id INTO template_id_var FROM templates WHERE template_name = 'example_test';

END $$;

COMMIT;


-- Template import complete!
-- Template name: example_test
-- Total sections: 0
--
-- To verify the import:
-- SELECT * FROM templates WHERE template_name = 'example_test';
-- SELECT COUNT(*) FROM sections WHERE template_id = (SELECT id FROM templates WHERE template_name = 'example_test');

-- Update sections with BYTEA image data
