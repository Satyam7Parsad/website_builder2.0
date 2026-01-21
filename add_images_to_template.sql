-- Add images to Pilates Studio template sections
-- This updates the template with actual image references

BEGIN;

-- Get the template ID
DO $$
DECLARE
    template_id_var integer;
    hero_section_id integer;
    gallery_section_id integer;
    about_section_id integer;
    contact_section_id integer;
BEGIN
    SELECT id INTO template_id_var FROM templates WHERE template_name = 'Pilates Studio - L. Carter';

    -- Get section IDs
    SELECT id INTO hero_section_id FROM sections WHERE template_id = template_id_var AND section_order = 0;
    SELECT id INTO gallery_section_id FROM sections WHERE template_id = template_id_var AND section_order = 2;
    SELECT id INTO about_section_id FROM sections WHERE template_id = template_id_var AND section_order = 3;
    SELECT id INTO contact_section_id FROM sections WHERE template_id = template_id_var AND section_order = 6;

    -- Update Hero Section with background image
    UPDATE sections SET
        background_image = '/Users/imaging/Desktop/website-builder/wix-images/Screenshot 2026-01-08 at 2.23.10 PM.png',
        use_bg_image = true,
        bg_overlay_opacity = 0.3
    WHERE id = hero_section_id;

    -- Update Book Your Session Gallery with 3 images
    UPDATE sections SET
        gallery_images = ARRAY[
            '/Users/imaging/Desktop/website-builder/wix-images/Screenshot 2026-01-08 at 2.23.28 PM.png'
        ],
        gallery_columns = 3,
        gallery_spacing = 20.0
    WHERE id = gallery_section_id;

    -- Update About Section with side image
    UPDATE sections SET
        section_image = '/Users/imaging/Desktop/website-builder/wix-images/Screenshot 2026-01-08 at 2.24.01 PM.png'
    WHERE id = about_section_id;

    -- Update Contact Section with image
    UPDATE sections SET
        section_image = '/Users/imaging/Desktop/website-builder/wix-images/Screenshot 2026-01-08 at 2.24.45 PM.png'
    WHERE id = contact_section_id;

    RAISE NOTICE 'Images added to template sections!';
END $$;

COMMIT;

-- Verify images were added
SELECT 'Images updated successfully!' as message;
SELECT s.name, s.background_image IS NOT NULL as has_bg_image, s.section_image IS NOT NULL as has_section_image,
       array_length(s.gallery_images, 1) as gallery_count
FROM sections s
JOIN templates t ON s.template_id = t.id
WHERE t.template_name = 'Pilates Studio - L. Carter'
ORDER BY s.section_order;
