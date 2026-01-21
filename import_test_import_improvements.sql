-- Import Scraped Template: test_import_improvements
-- Generated: 2026-01-19 15:58:39
-- Source: https://example.com
-- Sections: 0
--
-- Run this script to import the template into PostgreSQL:
-- psql -d website_builder < test_import_improvements.sql
--


BEGIN;

-- Insert the template
INSERT INTO templates (template_name, description, project_name, created_date)
VALUES (
    'test_import_improvements',
    'Imported from https://example.com - Metadata: {"url": "https://example.com", "scraped_date": "2026-01-19T15:58:39.263185", "forms": [], "social_links": [], "seo_data": {"title": "Example Domain", "description": "", "keywords": "", "og": {"title": "", "description": "", "image": "", "url": ""}, "twitter": {"card": "", "title": "", "description": "", "image": ""}, "favicon": "", "canonical": "", "lang": "en"}, "custom_fonts": [], "advanced_css": {"hoverEffects": [], "animations": [{"selector": "a", "animation": "none 0s ease 0s 1 normal none running"}], "transitions": [{"selector": "a", "transition": "all"}]}, "typography_system": {"fonts": ["system-ui, sans-serif"], "sizes": {"h1": 24, "p": 16, "a": 16}, "weights": [400, 700]}, "grid_system": {"baseUnit": 8, "spacingScale": [8, 16, 24, 32, 48, 64], "commonSpacings": [], "gridColumns": "none", "cv_base_unit": 8, "cv_verified": true}, "responsive_layouts": {"mobile": {"width": 375, "height": 812, "sections": []}, "tablet": {"width": 768, "height": 1024, "sections": []}, "desktop": {"width": 1920, "height": 1080, "sections": []}}}',  -- Limit to 5000 chars
    'Test Import Improvements',
    '2026-01-19 15:58:39'
);


-- Get the template ID
DO $$
DECLARE
    template_id_var integer;
BEGIN
    SELECT id INTO template_id_var FROM templates WHERE template_name = 'test_import_improvements';

END $$;

COMMIT;


-- Template import complete!
-- Template name: test_import_improvements
-- Total sections: 0
--
-- To verify the import:
-- SELECT * FROM templates WHERE template_name = 'test_import_improvements';
-- SELECT COUNT(*) FROM sections WHERE template_id = (SELECT id FROM templates WHERE template_name = 'test_import_improvements');

-- Update sections with BYTEA image data
