-- Import Scraped Template: photography_portfolio
-- Generated: 2026-01-19 20:44:56
-- Source: https://html5up.net/lens
-- Sections: 1
--
-- Run this script to import the template into PostgreSQL:
-- psql -d website_builder < photography_portfolio.sql
--


BEGIN;

-- Insert the template
INSERT INTO templates (template_name, description, project_name, created_date)
VALUES (
    'photography_portfolio',
    'Imported from https://html5up.net/lens - Metadata: {"url": "https://html5up.net/lens", "scraped_date": "2026-01-19T20:44:56.357279", "forms": [], "social_links": [{"platform": "Twitter", "href": "http://twitter.com/ajlkn", "position": {"x": 0, "y": 0}, "icon": "Follow @ajlkn"}], "seo_data": {"title": "Lens | HTML5 UP", "description": "This is Lens, a full screen (and entirely responsive) photo gallery design. Unlike previous designs I''ve done in this vein (Parallelism, for instance), this one eschews the usual lightbox in favor of a completely full screen experience -- one that I''m happy to say translates awesomely all the way down to the tiniest of mobile devices.", "keywords": "html5, css3, responsive, site template, website template", "og": {"title": "Lens by HTML5 UP", "description": "This is Lens, a full screen (and entirely responsive) photo gallery design. Unlike previous designs I''ve done in this vein (Parallelism, for instance), this one eschews the usual lightbox in favor of a completely full screen experience -- one that I''m happy to say translates awesomely all the way down to the tiniest of mobile devices.", "image": "https://html5up.net/uploads/cards/lens.jpg", "url": "http://html5up.net/lens"}, "twitter": {"card": "", "title": "", "description": "", "image": ""}, "favicon": "https://html5up.net/assets/icons/favicon.ico", "canonical": "https://html5up.net/lens", "lang": ""}, "custom_fonts": ["fonts/h5u.woff", "fonts/h5u.ttf"], "advanced_css": {"hoverEffects": [{"selector": "a:hover", "css": "color: rgb(231, 116, 111); border-color: rgb(231, 116, 111);"}, {"selector": ".button:hover", "css": "border-color: rgb(231, 116, 111); color: rgb(231, 116, 111);"}, {"selector": ".button.alt.on, .button.alt:hover", "css": "background: rgb(231, 116, 111); border-color: rgb(231, 116, 111);"}, {"selector": ".button.twitter.on, .button.twitter:hover", "css": "background: rgb(0, 172, 238); border-color: rgb(0, 172, 238); color: rgb(255, 255, 255);"}, {"selector": "ul.selector li:hover", "css": "background: rgb(242, 244, 247);"}, {"selector": "body.dark #demo-header .button.alt2:hover", "css": "border-color: rgb(231, 116, 111);"}, {"selector": "body.dark #demo-header .selector li:hover", "css": "background: rgb(71, 77, 89);"}, {"selector": "#px-banner .px-button:hover", "css": "background: rgb(45, 192, 234);"}, {"selector": ".fb_dialog_close_icon:hover", "css": "background: url(\"https://connect.facebook.net/rsrc.php/v4/yq/r/IE9JII6Z1Ys.png\") 0px -15px no-repeat scroll transparent;"}], "animations": [{"selector": "button popout alt2 offsite icon icon-popout solo", "animation": "none 0s ease 0s 1 normal none running"}, {"selector": "button back alt2", "animation": "none 0s ease 0s 1 normal none running"}, {"selector": "button alt download on", "animation": "none 0s ease 0s 1 normal none running"}, {"selector": "offsite button icon icon-twitter twitter on", "animation": "none 0s ease 0s 1 normal none running"}, {"selector": "button", "animation": "none 0s ease 0s 1 normal none running"}, {"selector": "offsite", "animation": "none 0s ease 0s 1 normal none running"}, {"selector": "offsite button alt", "animation": "none 0s ease 0s 1 normal none running"}, {"selector": "closer button", "animation": "none 0s ease 0s 1 normal none running"}], "transitions": [{"selector": "button popout alt2 offsite icon icon-popout solo", "transition": "color 0.2s ease-in-out, border-color 0.2s ease-in-out, background-color 0.2s ease-in-out"}, {"selector": "button back alt2", "transition": "color 0.2s ease-in-out, border-color 0.2s ease-in-out, background-color 0.2s ease-in-out"}, {"selector": "button alt download on", "transition": "color 0.2s ease-in-out, border-color 0.2s ease-in-out, background-color 0.2s ease-in-out"}, {"selector": "offsite button icon icon-twitter twitter on", "transition": "color 0.2s ease-in-out, border-color 0.2s ease-in-out, background-color 0.2s ease-in-out"}, {"selector": "button", "transition": "color 0.2s ease-in-out, border-color 0.2s ease-in-out, background-color 0.2s ease-in-out"}, {"selector": "offsite", "transition": "color 0.2s ease-in-out, border-color 0.2s ease-in-out, background-color 0.2s ease-in-out"}, {"selector": "offsite button alt", "transition": "color 0.2s ease-in-out, border-color 0.2s ease-in-out, background-color 0.2s ease-in-out"}, {"selector": "closer button", "transition": "color 0.2s ease-in-out, border-color 0.2s ease-in-out, background-color 0.2s ease-in-out"}]}, "typography_system": {"fonts": ["\"Source Sans Pro\", Arial, sans-serif"], "sizes": {"h1": 16, "h2": 35, "h3": 22, "p": 22, "a": 17}, "weights": [300, 600, 700]}, "grid_system": {"baseUnit": 8, "spacingScale": [8, 16, 24, 32, 48, 64], "commonSpacings": [], "gridColumns": "none", "cv_base_unit": 4, "cv_verified": true}, "responsive_layouts": {"mobile": {"width": 375, "height": 812, "sections": [{"visible": false, "display": "flex"}, {"visible": false, "display": "flex"}]}, "tablet": {"width": 768, "height": 1024, "secti',  -- Limit to 5000 chars
    'Photography Portfolio',
    '2026-01-19 20:44:56'
);


-- Get the template ID
DO $$
DECLARE
    template_id_var integer;
BEGIN
    SELECT id INTO template_id_var FROM templates WHERE template_name = 'photography_portfolio';


    -- Section 1: Lens
    -- CSS Data: {"button": {"borderRadius": "4px", "borderWidth": "1px", "borderColor": "rgb(87, 93, 105)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"bor...
    -- Cards: 8 items
    INSERT INTO sections (
        template_id, section_order, type, name, section_id, height, y_position,
        title, subtitle, content, button_text, button_link,
        title_font_size, subtitle_font_size, content_font_size,
        title_font_weight, subtitle_font_weight, content_font_weight,
        button_font_size, button_font_weight, nav_font_size, nav_font_weight,
        title_color, subtitle_color, content_color, bg_color, text_color,
        accent_color, button_bg_color, button_text_color,
        nav_bg_color, nav_text_color,
        padding, text_align, card_width, card_height, card_spacing, cards_per_row,
        background_image, section_image, use_bg_image, css_data, interactive_data, layout_data
    ) VALUES (
        template_id_var,
        0,
        1,
        'Lens',
        'lens',
        80,
        0,
        'Lens',
        'Need an attribution-free version?',
        'PS: If you like what I''m doing here, don''t forget to ... Check out Pixelarity, my latest and greatest side project that offers attribution-free usage of all of my templates, exclusive new templates, and support (from me) for just $19.',
        'Pop Out',
        'https://html5up.net/uploads/demos/lens/',
        15,
        3,
        21,
        600,
        400,
        300,
        15,
        600,
        15,
        500,
        '1.00,1.00,1.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.40,0.43,0.47,1.00',
        '0.22,0.24,0.29,0.98',
        '1.00,1.00,1.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,0.00',
        '0.40,0.43,0.47,1.00',
        40,
        1,
        300,
        250,
        20,
        3,
        'none',
        '',
        TRUE,
        '{"button": {"borderRadius": "4px", "borderWidth": "1px", "borderColor": "rgb(87, 93, 105)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "0px none rgb(255, 255, 255)", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "26px", "letterSpacing": "normal"}}',
        '{"cards": [{"title": "Pop Out", "description": "PS: If you like what I''m doing here, don''t forget to ...", "link": "https://html5up.net/uploads/demos/lens/", "button_text": "Pop Out", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(255, 255, 255)", "title_font_size": 15, "title_font_weight": 600}, {"title": "Back", "description": "Check out Pixelarity, my latest and greatest side project that offers attribution-free usage of all of my templates, exclusive new templates, and support (from me) for just $19.", "link": "https://html5up.net/", "button_text": "Back", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(255, 255, 255)", "title_font_size": 15, "title_font_weight": 600}, {"title": "Download (384,952)", "description": "", "link": "https://html5up.net/lens/download", "button_text": "Download (384,952)", "bg_color": "rgb(231, 116, 111)", "text_color": "rgb(255, 255, 255)", "title_font_size": 15, "title_font_weight": 600}, {"title": "Follow @ajlkn", "description": "", "link": "http://twitter.com/ajlkn", "button_text": "Follow @ajlkn", "bg_color": "rgb(0, 172, 238)", "text_color": "rgb(255, 255, 255)", "title_font_size": 17, "title_font_weight": 600}, {"title": "Subscribe", "description": "", "link": "https://html5up.net/lens#", "button_text": "Subscribe", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(103, 109, 121)", "title_font_size": 17, "title_font_weight": 600}, {"title": "Pixelarity", "description": "", "link": "https://pixelarity.com/", "button_text": "Pixelarity", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(103, 109, 121)", "title_font_size": 21, "title_font_weight": 300}, {"title": "Visit Pixelarity", "description": "", "link": "https://pixelarity.com/", "button_text": "Visit Pixelarity", "bg_color": "rgb(103, 109, 121)", "text_color": "rgb(255, 255, 255)", "title_font_size": 17, "title_font_weight": 600}, {"title": "", "description": "", "link": "https://html5up.net/lens#", "button_text": "", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(103, 109, 121)", "title_font_size": 17, "title_font_weight": 300}], "paragraphs": [{"text": "PS: If you like what I''m doing here, don''t forget to ...", "fontSize": 21.6667, "fontWeight": 300, "color": "rgb(103, 109, 121)", "fontFamily": "\"Source Sans Pro\", Arial, sans-serif"}, {"text": "Check out Pixelarity, my latest and greatest side project that offers attribution-free usage of all of my templates, exclusive new templates, and support (from me) for just $19.", "fontSize": 21.6667, "fontWeight": 300, "color": "rgb(103, 109, 121)", "fontFamily": "\"Source Sans Pro\", Arial, sans-serif"}], "nav_items": [{"text": "Pop Out", "href": "https://html5up.net/uploads/demos/lens/", "fontSize": 15.6, "fontWeight": 600, "color": "rgb(255, 255, 255)"}, {"text": "Back", "href": "https://html5up.net/", "fontSize": 15.6, "fontWeight": 600, "color": "rgb(255, 255, 255)"}, {"text": "Download (384,952)", "href": "https://html5up.net/lens/download", "fontSize": 15.6, "fontWeight": 600, "color": "rgb(255, 255, 255)"}, {"text": "Follow @ajlkn", "href": "http://twitter.com/ajlkn", "fontSize": 17.3333, "fontWeight": 600, "color": "rgb(255, 255, 255)"}, {"text": "Subscribe", "href": "https://html5up.net/lens#", "fontSize": 17.3333, "fontWeight": 600, "color": "rgb(103, 109, 121)"}, {"text": "Pixelarity", "href": "https://pixelarity.com/", "fontSize": 21.6667, "fontWeight": 300, "color": "rgb(103, 109, 121)"}, {"text": "Visit Pixelarity", "href": "https://pixelarity.com/", "fontSize": 17.3333, "fontWeight": 600, "color": "rgb(255, 255, 255)"}]}',
        '{"padding": {"top": "0px", "right": "0px", "bottom": "0px", "left": "0px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "normal"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat", "backgroundSize": "auto", "backgroundImage": "none"}, "position": {"position": "absolute", "top": "0px", "left": "0px", "right": "0px", "bottom": "0px", "zIndex": "auto"}, "typography": {"fontFamily": "\"Source Sans Pro\", Arial, sans-serif"}}'
    );

END $$;


COMMIT;


-- Template import complete!
-- Template name: photography_portfolio
-- Total sections: 1
--
-- To verify the import:
-- SELECT * FROM templates WHERE template_name = 'photography_portfolio';
-- SELECT COUNT(*) FROM sections WHERE template_id = (SELECT id FROM templates WHERE template_name = 'photography_portfolio');

-- Update sections with BYTEA image data
