-- Import Scraped Template: imported_wix_com_1768384805
-- Generated: 2026-01-14 15:31:50
-- Source: https://www.wix.com/website-template/view/html/5059?originUrl=https%3A%2F%2Fwww.wix.com%2Fwebsite%2Ftemplates%2Fhtml%2Fall%2F2&tpClick=view_button&esi=2f2b3dc1-00fd-4be9-a8e0-2e1b8d483984
-- Sections: 0
--
-- Run this script to import the template into PostgreSQL:
-- psql -d website_builder < imported_wix_com_1768384805.sql
--


BEGIN;

-- Insert the template
INSERT INTO templates (template_name, description, project_name, created_date)
VALUES (
    'imported_wix_com_1768384805',
    'Imported from https://www.wix.com/website-template/view/html/5059?originUrl=https%3A%2F%2Fwww.wix.com%2Fwebsite%2Ftemplates%2Fhtml%2Fall%2F2&tpClick=view_button&esi=2f2b3dc1-00fd-4be9-a8e0-2e1b8d483984',
    'Imported Wix Com 1768384805',
    '2026-01-14 15:31:50'
);


-- Get the template ID
DO $$
DECLARE
    template_id_var integer;
BEGIN
    SELECT id INTO template_id_var FROM templates WHERE template_name = 'imported_wix_com_1768384805';

END $$;

COMMIT;


-- Template import complete!
-- Template name: imported_wix_com_1768384805
-- Total sections: 0
--
-- To verify the import:
-- SELECT * FROM templates WHERE template_name = 'imported_wix_com_1768384805';
-- SELECT COUNT(*) FROM sections WHERE template_id = (SELECT id FROM templates WHERE template_name = 'imported_wix_com_1768384805');

-- Update sections with BYTEA image data
