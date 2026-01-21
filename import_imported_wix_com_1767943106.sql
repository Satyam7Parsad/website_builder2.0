-- Import Scraped Template: imported_wix_com_1767943106
-- Generated: 2026-01-09 12:48:37
-- Source: https://www.wix.com/website-template/view/html/5685?originUrl=https%3A%2F%2Fwww.wix.com%2Fwebsite%2Ftemplates&tpClick=view_button&esi=4d3f5dec-67d5-4939-b887-6edaddb33e3a
-- Sections: 0
--
-- Run this script to import the template into PostgreSQL:
-- psql -d website_builder < imported_wix_com_1767943106.sql
--


BEGIN;

-- Insert the template
INSERT INTO templates (template_name, description, project_name, created_date)
VALUES (
    'imported_wix_com_1767943106',
    'Imported from www.wix.com',
    'Imported Wix Com 1767943106',
    '2026-01-09 12:48:37'
);


-- Get the template ID
DO $$
DECLARE
    template_id_var integer;
BEGIN
    SELECT id INTO template_id_var FROM templates WHERE template_name = 'imported_wix_com_1767943106';

END $$;

COMMIT;


-- Template import complete!
-- Template name: imported_wix_com_1767943106
-- Total sections: 0
--
-- To verify the import:
-- SELECT * FROM templates WHERE template_name = 'imported_wix_com_1767943106';
-- SELECT COUNT(*) FROM sections WHERE template_id = (SELECT id FROM templates WHERE template_name = 'imported_wix_com_1767943106');

-- Update sections with BYTEA image data
