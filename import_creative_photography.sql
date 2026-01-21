-- Import Scraped Template: creative_photography
-- Generated: 2026-01-19 21:07:51
-- Source: https://startbootstrap.com/previews/creative
-- Sections: 1
--
-- Run this script to import the template into PostgreSQL:
-- psql -d website_builder < creative_photography.sql
--


BEGIN;

-- Insert the template
INSERT INTO templates (template_name, description, project_name, created_date)
VALUES (
    'creative_photography',
    'Imported from https://startbootstrap.com/previews/creative - Metadata: {"url": "https://startbootstrap.com/previews/creative", "scraped_date": "2026-01-19T21:07:51.720022", "forms": [], "social_links": [], "seo_data": {"title": "Creative - Theme Preview - Start Bootstrap", "description": "Creative is a fully styled, one page Bootstrap HTML theme for creating creative landing pages quickly and easily.", "keywords": "", "og": {"title": "", "description": "", "image": "", "url": ""}, "twitter": {"card": "summary_large_image", "title": "Creative - Theme Preview", "description": "Creative is a fully styled, one page Bootstrap HTML theme for creating creative landing pages quickly and easily.", "image": "https://assets.startbootstrap.com/img/meta/products/twitter/twitter-image-creative.png"}, "favicon": "https://startbootstrap.com/favicon.png", "canonical": "https://startbootstrap.com/previews/creative", "lang": "en"}, "custom_fonts": ["/assets/fonts/metropolis/Metropolis-Thin.otf", "/assets/fonts/metropolis/Metropolis-ThinItalic.otf", "/assets/fonts/metropolis/Metropolis-ExtraLight.otf", "/assets/fonts/metropolis/Metropolis-ExtraLightItalic.otf", "/assets/fonts/metropolis/Metropolis-Light.otf", "/assets/fonts/metropolis/Metropolis-LightItalic.otf", "/assets/fonts/metropolis/Metropolis-Regular.otf", "/assets/fonts/metropolis/Metropolis-RegularItalic.otf", "/assets/fonts/metropolis/Metropolis-Medium.otf", "/assets/fonts/metropolis/Metropolis-MediumItalic.otf", "/assets/fonts/metropolis/Metropolis-SemiBold.otf", "/assets/fonts/metropolis/Metropolis-SemiBoldItalic.otf", "/assets/fonts/metropolis/Metropolis-Bold.otf", "/assets/fonts/metropolis/Metropolis-BoldItalic.otf", "/assets/fonts/metropolis/Metropolis-ExtraBold.otf", "/assets/fonts/metropolis/Metropolis-ExtraBoldItalic.otf", "/assets/fonts/metropolis/Metropolis-Black.otf", "/assets/fonts/metropolis/Metropolis-BlackItalic.otf"], "advanced_css": {"hoverEffects": [{"selector": "a:hover", "css": "color: var(--bs-link-hover-color); text-decoration: underline;"}, {"selector": "a:not([href]):not([class]), a:not([href]):not([class]):hover", "css": "color: inherit; text-decoration: none;"}, {"selector": ".form-control:hover:not(:disabled):not([readonly])::file-selector-button", "css": "background-color: rgb(242, 242, 242);"}, {"selector": ".btn:hover", "css": "color: var(--bs-btn-hover-color); text-decoration: none; background-color: var(--bs-btn-hover-bg); border-color: var(--bs-btn-hover-border-color);"}, {"selector": ".btn-link:hover, .btn-link:focus-visible", "css": "text-decoration: underline;"}, {"selector": ".btn-link:hover", "css": "color: var(--bs-btn-hover-color);"}, {"selector": ".dropdown-item:hover, .dropdown-item:focus", "css": "color: var(--bs-dropdown-link-hover-color); text-decoration: none; background-color: var(--bs-dropdown-link-hover-bg);"}, {"selector": ".btn-group > .btn:hover, .btn-group > .btn:focus, .btn-group > .btn:active, .btn-group > .btn.active, .btn-group-vertical > .btn:active, .btn-group-vertical > .btn.active", "css": "z-index: 1;"}, {"selector": ".nav-link:hover, .nav-link:focus", "css": "color: var(--bs-nav-link-hover-color); text-decoration: none;"}, {"selector": ".nav-tabs .nav-link:hover, .nav-tabs .nav-link:focus", "css": "isolation: isolate; border-color: var(--bs-nav-tabs-link-hover-border-color);"}, {"selector": ".navbar-brand:hover, .navbar-brand:focus", "css": "color: var(--bs-navbar-brand-hover-color); text-decoration: none;"}, {"selector": ".navbar-toggler:hover", "css": "text-decoration: none;"}, {"selector": ".card-link:hover", "css": "text-decoration: none;"}, {"selector": ".list-group-item-action:hover, .list-group-item-action:focus", "css": "z-index: 1; color: var(--bs-list-group-action-hover-color); text-decoration: none; background-color: var(--bs-list-group-action-hover-bg);"}, {"selector": ".btn-close:hover", "css": "color: rgb(0, 0, 0); text-decoration: none; opacity: 0.75;"}, {"selector": ".carousel-control-prev:hover, .carousel-control-prev:focus, .carousel-control-next:hover, .carousel-control-next:focus", "css": "color: rgb(255, 255, 255); text-decoration: none; outline: 0px; opacity: 0.9;"}, {"selector": ".link-red:hover, .link-red:focus", "css": "color: rgb(176, 46, 36) !important;"}, {"selector": ".link-green:hover, .link-green:focus", "css": "color: rgb(0, 138, 84) !important;"}, {"selector": ".link-blue:hover, .link-blue:focus", "css": "color: rgb(0, 78, 194) !important;"}, {"selector": ".lift:hover", "css": "transform: translateY(-0.333333rem); box-shadow: rgba(33, 40, 50, 0.25) 0px 0.5rem 2rem;"}, {"selector": ".lift-sm:hover", "css": "transform: translateY(-0.166667rem); box-shadow: rgba(33, 40, 50, 0.25) 0px 0.25rem 1rem;"}, {"selector": ".card-link:hover", "css": "color: inherit !important;"}, {"selector": ".sidenav-dark .sidenav-menu .nav-link:hover, .sidenav-dark .sidenav-menu .nav-link.active, .sidenav-dark .sidenav-menu .nav-link.active .nav-link-icon", "css": "color: rgb(255, 255, 255);"}, {"se',  -- Limit to 5000 chars
    'Creative Photography',
    '2026-01-19 21:07:51'
);


-- Get the template ID
DO $$
DECLARE
    template_id_var integer;
BEGIN
    SELECT id INTO template_id_var FROM templates WHERE template_name = 'creative_photography';


    -- Section 1: 
    -- CSS Data: {"button": {"borderRadius": "4px", "borderWidth": "1px", "borderColor": "rgba(0, 0, 0, 0)", "boxShadow": "none", "padding": "8px 12px", "textTransform": "none", "letterSpacing": "normal"}, "section": ...
    -- Cards: 7 items
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
        0,
        '',
        '',
        900,
        0,
        '',
        '',
        '',
        'Overview Page',
        'https://startbootstrap.com/theme/creative',
        42,
        30,
        16,
        700,
        400,
        400,
        12,
        400,
        15,
        500,
        '0.13,0.16,0.20,0.50',
        '0.13,0.16,0.20,0.50',
        '0.13,0.16,0.20,0.50',
        '0.00,0.00,0.00,0.00',
        '0.13,0.16,0.20,0.50',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.13,0.16,0.20,0.50',
        '0.00,0.00,0.00,0.00',
        '0.13,0.16,0.20,0.50',
        80,
        1,
        300,
        250,
        20,
        3,
        'none',
        '',
        TRUE,
        '{"button": {"borderRadius": "4px", "borderWidth": "1px", "borderColor": "rgba(0, 0, 0, 0)", "boxShadow": "none", "padding": "8px 12px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"borderRadius": "100%", "boxShadow": "none", "border": "1px solid rgba(0, 0, 0, 0)", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "14px", "letterSpacing": "normal"}}',
        '{"cards": [{"title": "Overview Page", "description": "", "link": "https://startbootstrap.com/theme/creative", "button_text": "Overview Page", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgba(33, 40, 50, 0.5)", "title_font_size": 12, "title_font_weight": 400}, {"title": "", "description": "", "link": "", "button_text": "", "bg_color": "rgba(33, 40, 50, 0.2)", "text_color": "rgba(33, 40, 50, 0.5)", "title_font_size": 14, "title_font_weight": 400}, {"title": "", "description": "", "link": "", "button_text": "", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgba(33, 40, 50, 0.5)", "title_font_size": 14, "title_font_weight": 400}, {"title": "", "description": "", "link": "", "button_text": "", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgba(33, 40, 50, 0.5)", "title_font_size": 14, "title_font_weight": 400}, {"title": "", "description": "", "link": "https://github.com/StartBootstrap/startbootstrap-creative", "button_text": "", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgba(33, 40, 50, 0.5)", "title_font_size": 12, "title_font_weight": 400}, {"title": "Free Download", "description": "", "link": "https://github.com/StartBootstrap/startbootstrap-creative/archive/gh-pages.zip", "button_text": "Free Download", "bg_color": "rgb(240, 227, 231)", "text_color": "rgb(220, 57, 45)", "title_font_size": 12, "title_font_weight": 400}, {"title": "", "description": "", "link": "", "button_text": "", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgba(33, 40, 50, 0.5)", "title_font_size": 12, "title_font_weight": 400}]}',
        '{"padding": {"top": "0px", "right": "0px", "bottom": "0px", "left": "0px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "normal"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat", "backgroundSize": "auto", "backgroundImage": "none"}, "position": {"position": "absolute", "top": "0px", "left": "0px", "right": "0px", "bottom": "0px", "zIndex": "auto"}, "typography": {"fontFamily": "Metropolis, -apple-system, \"system-ui\", \"Segoe UI\", Roboto, \"Helvetica Neue\", Arial, sans-serif, \"Apple Color Emoji\", \"Segoe UI Emoji\", \"Segoe UI Symbol\", \"Noto Color Emoji\""}}'
    );

END $$;


COMMIT;


-- Template import complete!
-- Template name: creative_photography
-- Total sections: 1
--
-- To verify the import:
-- SELECT * FROM templates WHERE template_name = 'creative_photography';
-- SELECT COUNT(*) FROM sections WHERE template_id = (SELECT id FROM templates WHERE template_name = 'creative_photography');

-- Update sections with BYTEA image data
