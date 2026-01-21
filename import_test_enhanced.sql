-- Import Scraped Template: test_enhanced
-- Generated: 2026-01-10 22:22:52
-- Source: https://www.example.com
-- Sections: 0
--
-- Run this script to import the template into PostgreSQL:
-- psql -d website_builder < test_enhanced.sql
--


BEGIN;

-- Insert the template
INSERT INTO templates (template_name, description, project_name, created_date)
VALUES (
    'test_enhanced',
    'Imported from www.example.com',
    'Test Enhanced',
    '2026-01-10 22:22:52'
);


-- Get the template ID
DO $$
DECLARE
    template_id_var integer;
BEGIN
    SELECT id INTO template_id_var FROM templates WHERE template_name = 'test_enhanced';

END $$;

COMMIT;


-- Template import complete!
-- Template name: test_enhanced
-- Total sections: 0
--
-- To verify the import:
-- SELECT * FROM templates WHERE template_name = 'test_enhanced';
-- SELECT COUNT(*) FROM sections WHERE template_id = (SELECT id FROM templates WHERE template_name = 'test_enhanced');

-- Update sections with BYTEA image data
