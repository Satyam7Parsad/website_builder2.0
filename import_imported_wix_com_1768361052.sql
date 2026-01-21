-- Import Scraped Template: imported_wix_com_1768361052
-- Generated: 2026-01-14 08:55:57
-- Source: https://www.wix.com/website-template/view/html/2746?originUrl=https%3A%2F%2Fwww.wix.com%2Fwebsite%2Ftemplates%2Fhtml%2Fall%2F2&tpClick=view_button&esi=833b60e3-2884-4c4b-85f4-32797ef88c67
-- Sections: 0
--
-- Run this script to import the template into PostgreSQL:
-- psql -d website_builder < imported_wix_com_1768361052.sql
--


BEGIN;

-- Insert the template
INSERT INTO templates (template_name, description, project_name, created_date)
VALUES (
    'imported_wix_com_1768361052',
    'Imported from https://www.wix.com/website-template/view/html/2746?originUrl=https%3A%2F%2Fwww.wix.com%2Fwebsite%2Ftemplates%2Fhtml%2Fall%2F2&tpClick=view_button&esi=833b60e3-2884-4c4b-85f4-32797ef88c67',
    'Imported Wix Com 1768361052',
    '2026-01-14 08:55:57'
);


-- Get the template ID
DO $$
DECLARE
    template_id_var integer;
BEGIN
    SELECT id INTO template_id_var FROM templates WHERE template_name = 'imported_wix_com_1768361052';

END $$;

COMMIT;


-- Template import complete!
-- Template name: imported_wix_com_1768361052
-- Total sections: 0
--
-- To verify the import:
-- SELECT * FROM templates WHERE template_name = 'imported_wix_com_1768361052';
-- SELECT COUNT(*) FROM sections WHERE template_id = (SELECT id FROM templates WHERE template_name = 'imported_wix_com_1768361052');

-- Update sections with BYTEA image data
