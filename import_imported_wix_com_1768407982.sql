-- Import Scraped Template: imported_wix_com_1768407982
-- Generated: 2026-01-14 21:57:00
-- Source: https://www.wix.com/website-template/view/html/2175?originUrl=https%3A%2F%2Fwww.wix.com%2Fwebsite%2Ftemplates%2Fhtml%2Fmost-popular&tpClick=view_button&esi=575c2659-8404-4cc7-8440-e7a245bfae49
-- Sections: 0
--
-- Run this script to import the template into PostgreSQL:
-- psql -d website_builder < imported_wix_com_1768407982.sql
--


BEGIN;

-- Insert the template
INSERT INTO templates (template_name, description, project_name, created_date)
VALUES (
    'imported_wix_com_1768407982',
    'Imported from https://www.wix.com/website-template/view/html/2175?originUrl=https%3A%2F%2Fwww.wix.com%2Fwebsite%2Ftemplates%2Fhtml%2Fmost-popular&tpClick=view_button&esi=575c2659-8404-4cc7-8440-e7a245bfae49',
    'Imported Wix Com 1768407982',
    '2026-01-14 21:57:00'
);


-- Get the template ID
DO $$
DECLARE
    template_id_var integer;
BEGIN
    SELECT id INTO template_id_var FROM templates WHERE template_name = 'imported_wix_com_1768407982';

END $$;

COMMIT;


-- Template import complete!
-- Template name: imported_wix_com_1768407982
-- Total sections: 0
--
-- To verify the import:
-- SELECT * FROM templates WHERE template_name = 'imported_wix_com_1768407982';
-- SELECT COUNT(*) FROM sections WHERE template_id = (SELECT id FROM templates WHERE template_name = 'imported_wix_com_1768407982');

-- Update sections with BYTEA image data
