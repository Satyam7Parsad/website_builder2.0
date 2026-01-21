-- Import Scraped Template: macbook_test
-- Generated: 2026-01-08 15:41:30
-- Source: https://www.apple.com/macbook-air/
-- Sections: 0
--
-- Run this script to import the template into PostgreSQL:
-- psql -d website_builder < macbook_test.sql
--


BEGIN;

-- Insert the template
INSERT INTO templates (template_name, description, project_name, created_date)
VALUES (
    'macbook_test',
    'Imported from www.apple.com',
    'Macbook Test',
    '2026-01-08 15:41:30'
);


-- Get the template ID
DO $$
DECLARE
    template_id_var integer;
BEGIN
    SELECT id INTO template_id_var FROM templates WHERE template_name = 'macbook_test';

END $$;

COMMIT;


-- Template import complete!
-- Template name: macbook_test
-- Total sections: 0
--
-- To verify the import:
-- SELECT * FROM templates WHERE template_name = 'macbook_test';
-- SELECT COUNT(*) FROM sections WHERE template_id = (SELECT id FROM templates WHERE template_name = 'macbook_test');
