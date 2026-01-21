-- Import Scraped Template: imported_tajhotels_com_1768749989
-- Generated: 2026-01-18 20:56:59
-- Source: https://www.tajhotels.com/en-in/offers/celebrating-our-bond-2026?gad_source=1&gad_campaignid=633337829&gbraid=0AAAAADhl-_8tm0iMVuhVabrS-_IB958eQ&gclid=Cj0KCQiAprLLBhCMARIsAEDhdPd4YsGT1hmda-eUilX2sY5MOFp9LcCCuQcjyF4fmlvrsRxz_FgIuo4aAuJiEALw_wcB
-- Sections: 0
--
-- Run this script to import the template into PostgreSQL:
-- psql -d website_builder < imported_tajhotels_com_1768749989.sql
--


BEGIN;

-- Insert the template
INSERT INTO templates (template_name, description, project_name, created_date)
VALUES (
    'imported_tajhotels_com_1768749989',
    'Imported from https://www.tajhotels.com/en-in/offers/celebrating-our-bond-2026?gad_source=1&gad_campaignid=633337829&gbraid=0AAAAADhl-_8tm0iMVuhVabrS-_IB958eQ&gclid=Cj0KCQiAprLLBhCMARIsAEDhdPd4YsGT1hmda-eUilX2sY5MOFp9LcCCuQcjyF4fmlvrsRxz_FgIuo4aAuJiEALw_wcB - Metadata: {"url": "https://www.tajhotels.com/en-in/offers/celebrating-our-bond-2026?gad_source=1&gad_campaignid=633337829&gbraid=0AAAAADhl-_8tm0iMVuhVabrS-_IB958eQ&gclid=Cj0KCQiAprLLBhCMARIsAEDhdPd4YsGT1hmda-eUilX2sY5MOFp9LcCCuQcjyF4fmlvrsRxz_FgIuo4aAuJiEALw_wcB", "scraped_date": "2026-01-18T20:56:59.721479", "forms": [], "social_links": [], "seo_data": {"title": "Access Denied", "description": "", "keywords": "", "og": {"title": "", "description": "", "image": "", "url": ""}, "twitter": {"card": "", "title": "", "description": "", "image": ""}, "favicon": "", "canonical": "", "lang": ""}, "custom_fonts": [], "advanced_css": {"hoverEffects": [], "animations": [], "transitions": []}, "typography_system": {"fonts": ["Times"], "sizes": {"h1": 32, "p": 16}, "weights": [400, 700]}, "grid_system": {"baseUnit": 8, "spacingScale": [8, 16, 24, 32, 48, 64], "commonSpacings": [], "gridColumns": "none", "cv_base_unit": 8, "cv_verified": true}, "responsive_layouts": {"mobile": {"width": 375, "height": 812, "sections": []}, "tablet": {"width": 768, "height": 1024, "sections": []}, "desktop": {"width": 1920, "height": 1080, "sections": []}}}',  -- Limit to 5000 chars
    'Imported Tajhotels Com 1768749989',
    '2026-01-18 20:56:59'
);


-- Get the template ID
DO $$
DECLARE
    template_id_var integer;
BEGIN
    SELECT id INTO template_id_var FROM templates WHERE template_name = 'imported_tajhotels_com_1768749989';

END $$;

COMMIT;


-- Template import complete!
-- Template name: imported_tajhotels_com_1768749989
-- Total sections: 0
--
-- To verify the import:
-- SELECT * FROM templates WHERE template_name = 'imported_tajhotels_com_1768749989';
-- SELECT COUNT(*) FROM sections WHERE template_id = (SELECT id FROM templates WHERE template_name = 'imported_tajhotels_com_1768749989');

-- Update sections with BYTEA image data
