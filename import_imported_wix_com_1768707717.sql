-- Import Scraped Template: imported_wix_com_1768707717
-- Generated: 2026-01-18 09:20:50
-- Source: https://www.wix.com/website-template/view/html/5685?originUrl=https%3A%2F%2Fwww.wix.com%2Fwebsite%2Ftemplates&tpClick=view_button&esi=4d3f5dec-67d5-4939-b887-6edaddb33e3a
-- Sections: 0
--
-- Run this script to import the template into PostgreSQL:
-- psql -d website_builder < imported_wix_com_1768707717.sql
--


BEGIN;

-- Insert the template
INSERT INTO templates (template_name, description, project_name, created_date)
VALUES (
    'imported_wix_com_1768707717',
    'Imported from https://www.wix.com/website-template/view/html/5685?originUrl=https%3A%2F%2Fwww.wix.com%2Fwebsite%2Ftemplates&tpClick=view_button&esi=4d3f5dec-67d5-4939-b887-6edaddb33e3a - Metadata: {"url": "https://www.wix.com/website-template/view/html/5685?originUrl=https%3A%2F%2Fwww.wix.com%2Fwebsite%2Ftemplates&tpClick=view_button&esi=4d3f5dec-67d5-4939-b887-6edaddb33e3a", "scraped_date": "2026-01-18T09:20:50.343189", "forms": [], "social_links": [], "seo_data": {"title": "Pilates Studio (Energetic) Website Template | WIX", "description": "Energize your Pilates studio''s online presence with a vibrant, engaging website! This template features the Wix Bookings app, making it easy for clients to schedule their sessions and manage appointments. With sections designed to showcase classes, instructors, and testimonials, you can create a community that inspires health and wellness. Get started on strengthening your brand today by clicking ''Edit''!", "keywords": "", "og": {"title": "Pilates Studio (Energetic) Website Template | WIX", "description": "Energize your Pilates studio''s online presence with a vibrant, engaging website! This template features the Wix Bookings app, making it easy for clients to schedule their sessions and manage appointments. With sections designed to showcase classes, instructors, and testimonials, you can create a community that inspires health and wellness. Get started on strengthening your brand today by clicking ''Edit''!", "image": "//static.wixstatic.com/media/", "url": "https://www.wix.com/website-template/view/html/5685"}, "twitter": {"card": "", "title": "", "description": "", "image": ""}, "favicon": "https://www.wix.com/favicon.ico", "canonical": "https://www.wix.com/website-template/view/html/5685", "lang": ""}, "custom_fonts": [], "advanced_css": {"hoverEffects": [], "animations": [{"selector": "nHuSJZ", "animation": "none 0s ease 0s 1 normal none running"}, {"selector": "oOZ5cH FrcaLY", "animation": "none 0s ease 0s 1 normal none running"}, {"selector": "oOZ5cH", "animation": "none 0s ease 0s 1 normal none running"}, {"selector": "bggdgE LCjeiB", "animation": "none 0s ease 0s 1 normal none running"}, {"selector": "Ydu4WK Y_xMZ5", "animation": "none 0s ease 0s 1 normal none running"}, {"selector": "gVJ7eC", "animation": "none 0s ease 0s 1 normal none running"}, {"selector": "XpwCp3 sKD7vO kX8CZg", "animation": "none 0s ease 0s 1 normal none running"}], "transitions": [{"selector": "nHuSJZ", "transition": "all"}, {"selector": "oOZ5cH FrcaLY", "transition": "all"}, {"selector": "oOZ5cH", "transition": "all"}, {"selector": "bggdgE LCjeiB", "transition": "all"}, {"selector": "Ydu4WK Y_xMZ5", "transition": "all"}, {"selector": "gVJ7eC", "transition": "all"}, {"selector": "XpwCp3 sKD7vO kX8CZg", "transition": "all"}]}, "typography_system": {"fonts": ["\"Madefor Display\", \"Helvetica Neue\", Helvetica, Arial, \u30e1\u30a4\u30ea\u30aa, meiryo, \"\u30d2\u30e9\u30ae\u30ce\u89d2\u30b4 pro w3\", \"hiragino kaku gothic pro\", sans-serif", "Madefor, \"Helvetica Neue\", Helvetica, Arial, \u30e1\u30a4\u30ea\u30aa, meiryo, \"\u30d2\u30e9\u30ae\u30ce\u89d2\u30b4 pro w3\", \"hiragino kaku gothic pro\", sans-serif"], "sizes": {"h1": 36, "h3": 16, "p": 16, "button": 16, "a": 16}, "weights": [300, 400, 700]}, "grid_system": {"baseUnit": 8, "spacingScale": [8, 16, 24, 32, 48, 64], "commonSpacings": [], "gridColumns": "none", "cv_base_unit": 4, "cv_verified": true}, "responsive_layouts": {"mobile": {"width": 375, "height": 812, "sections": []}, "tablet": {"width": 768, "height": 1024, "sections": []}, "desktop": {"width": 1920, "height": 1080, "sections": []}}}',  -- Limit to 5000 chars
    'Imported Wix Com 1768707717',
    '2026-01-18 09:20:50'
);


-- Get the template ID
DO $$
DECLARE
    template_id_var integer;
BEGIN
    SELECT id INTO template_id_var FROM templates WHERE template_name = 'imported_wix_com_1768707717';

END $$;

COMMIT;


-- Template import complete!
-- Template name: imported_wix_com_1768707717
-- Total sections: 0
--
-- To verify the import:
-- SELECT * FROM templates WHERE template_name = 'imported_wix_com_1768707717';
-- SELECT COUNT(*) FROM sections WHERE template_id = (SELECT id FROM templates WHERE template_name = 'imported_wix_com_1768707717');

-- Update sections with BYTEA image data
