-- Import Scraped Template: test_enhanced_scraper
-- Generated: 2026-01-09 13:44:30
-- Source: https://www.example.com
-- Sections: 0
--
-- Run this script to import the template into PostgreSQL:
-- psql -d website_builder < test_enhanced_scraper.sql
--


BEGIN;

-- Insert the template
INSERT INTO templates (template_name, description, project_name, created_date)
VALUES (
    'test_enhanced_scraper',
    'Imported from www.example.com',
    'Test Enhanced Scraper',
    '2026-01-09 13:44:30'
);


-- Get the template ID
DO $$
DECLARE
    template_id_var integer;
BEGIN
    SELECT id INTO template_id_var FROM templates WHERE template_name = 'test_enhanced_scraper';

END $$;

COMMIT;


-- Template import complete!
-- Template name: test_enhanced_scraper
-- Total sections: 0
--
-- To verify the import:
-- SELECT * FROM templates WHERE template_name = 'test_enhanced_scraper';
-- SELECT COUNT(*) FROM sections WHERE template_id = (SELECT id FROM templates WHERE template_name = 'test_enhanced_scraper');

-- Update sections with BYTEA image data
