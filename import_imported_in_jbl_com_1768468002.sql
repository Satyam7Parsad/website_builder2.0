-- Import Scraped Template: imported_in_jbl_com_1768468002
-- Generated: 2026-01-15 14:37:13
-- Source: https://in.jbl.com
-- Sections: 0
--
-- Run this script to import the template into PostgreSQL:
-- psql -d website_builder < imported_in_jbl_com_1768468002.sql
--


BEGIN;

-- Insert the template
INSERT INTO templates (template_name, description, project_name, created_date)
VALUES (
    'imported_in_jbl_com_1768468002',
    'Imported from https://in.jbl.com',
    'Imported In Jbl Com 1768468002',
    '2026-01-15 14:37:13'
);


-- Get the template ID
DO $$
DECLARE
    template_id_var integer;
BEGIN
    SELECT id INTO template_id_var FROM templates WHERE template_name = 'imported_in_jbl_com_1768468002';

END $$;

COMMIT;


-- Template import complete!
-- Template name: imported_in_jbl_com_1768468002
-- Total sections: 0
--
-- To verify the import:
-- SELECT * FROM templates WHERE template_name = 'imported_in_jbl_com_1768468002';
-- SELECT COUNT(*) FROM sections WHERE template_id = (SELECT id FROM templates WHERE template_name = 'imported_in_jbl_com_1768468002');

-- Update sections with BYTEA image data
