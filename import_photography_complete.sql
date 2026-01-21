-- Import Scraped Template: photography_complete
-- Generated: 2026-01-19 21:07:08
-- Source: https://templatemo.com/live/templatemo_567_astro_motion
-- Sections: 0
--
-- Run this script to import the template into PostgreSQL:
-- psql -d website_builder < photography_complete.sql
--


BEGIN;

-- Insert the template
INSERT INTO templates (template_name, description, project_name, created_date)
VALUES (
    'photography_complete',
    'Imported from https://templatemo.com/live/templatemo_567_astro_motion - Metadata: {"url": "https://templatemo.com/live/templatemo_567_astro_motion", "scraped_date": "2026-01-19T21:07:08.719445", "forms": [], "social_links": [], "seo_data": {"title": "Live View Page - 567 astro motion Template", "description": "Live view page for  567 astro motion Template, download free CSS templates for your website", "keywords": "", "og": {"title": "", "description": "", "image": "", "url": ""}, "twitter": {"card": "", "title": "", "description": "", "image": ""}, "favicon": "", "canonical": "", "lang": "en"}, "custom_fonts": [], "advanced_css": {"hoverEffects": [{"selector": "a:hover", "css": "color: rgb(204, 0, 102); text-decoration: underline;"}, {"selector": ".tm-menu a:hover", "css": "background: linear-gradient(rgb(204, 204, 204), rgb(255, 255, 255), rgb(255, 255, 255)); text-decoration: none;"}, {"selector": ".col3-ft a:hover", "css": "color: rgb(255, 255, 102);"}, {"selector": "#carbonads a:hover", "css": "color: inherit;"}, {"selector": ".tn_des a:hover", "css": "text-decoration: none;"}, {"selector": ".thumbnail_200:hover .tn_des", "css": "visibility: visible; opacity: 1;"}, {"selector": ".view-all a:hover, .flashmo_download a:active", "css": "background: rgb(221, 221, 221); color: rgb(85, 85, 85); text-decoration: none;"}, {"selector": ".tm-dl-blue a:hover, .tm-dl-blue a:active", "css": "background: linear-gradient(rgb(34, 85, 153), rgb(51, 153, 204)); text-decoration: none;"}, {"selector": ".tm-dl-green a:hover, .tm-dl-green a:active", "css": "background: linear-gradient(rgb(34, 119, 68), rgb(51, 170, 102)); color: rgb(255, 255, 255); text-decoration: none;"}, {"selector": ".tm-dl-teal a:hover, .tm-dl-teal a:active", "css": "background: linear-gradient(rgb(98, 155, 173), rgb(60, 90, 175)); color: rgb(255, 255, 255); text-decoration: none;"}, {"selector": ".tm-dl-purple a:hover, .tm-dl-purple a:active", "css": "background: rgb(92, 105, 154); color: rgb(255, 255, 255); text-decoration: none;"}, {"selector": ".tm-dl-grey a:hover, .tm-dl-grey a:active", "css": "background: rgb(88, 98, 109); text-decoration: none;"}, {"selector": ".tm-dl-grey-premium a:hover, .tm-dl-grey-premium a:active", "css": "background: linear-gradient(rgb(64, 64, 64), rgb(96, 100, 114)); text-decoration: none;"}, {"selector": ".top_links a:active, .top_links a:hover", "css": "color: rgb(204, 255, 0);"}, {"selector": ".blog_post a:active, .blog_post a:hover", "css": "color: rgb(170, 0, 0);"}, {"selector": "div.paging a:hover, div.paging a:active", "css": "background-color: rgb(204, 204, 204); color: rgb(0, 0, 0); text-decoration: none;"}], "animations": [], "transitions": []}, "typography_system": {"fonts": [], "sizes": {}, "weights": []}, "grid_system": {"baseUnit": 8, "spacingScale": [8, 16, 24, 32, 48, 64], "commonSpacings": [], "gridColumns": "none", "cv_base_unit": 4, "cv_verified": true}, "responsive_layouts": {"mobile": {"width": 375, "height": 812, "sections": []}, "tablet": {"width": 768, "height": 1024, "sections": []}, "desktop": {"width": 1920, "height": 1080, "sections": []}}}',  -- Limit to 5000 chars
    'Photography Complete',
    '2026-01-19 21:07:08'
);


-- Get the template ID
DO $$
DECLARE
    template_id_var integer;
BEGIN
    SELECT id INTO template_id_var FROM templates WHERE template_name = 'photography_complete';

END $$;

COMMIT;


-- Template import complete!
-- Template name: photography_complete
-- Total sections: 0
--
-- To verify the import:
-- SELECT * FROM templates WHERE template_name = 'photography_complete';
-- SELECT COUNT(*) FROM sections WHERE template_id = (SELECT id FROM templates WHERE template_name = 'photography_complete');

-- Update sections with BYTEA image data
