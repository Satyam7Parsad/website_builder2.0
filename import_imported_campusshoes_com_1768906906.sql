-- Import Scraped Template: imported_campusshoes_com_1768906906
-- Generated: 2026-01-20 16:34:49
-- Source: Unknown
-- Sections: 6
--
-- Run this script to import the template into PostgreSQL:
-- psql -d website_builder < imported_campusshoes_com_1768906906.sql
--


BEGIN;

-- Insert the template
INSERT INTO templates (template_name, description, project_name, created_date)
VALUES (
    'imported_campusshoes_com_1768906906',
    'Imported from  - Metadata: {"url": "", "scraped_date": "2026-01-20T16:34:49.398646", "forms": [], "social_links": [], "seo_data": {}, "custom_fonts": [], "advanced_css": {}, "typography_system": {}, "grid_system": {}, "responsive_layouts": {}}',  -- Limit to 5000 chars
    'Imported Campusshoes Com 1768906906',
    '2026-01-20 16:34:49'
);


-- Get the template ID
DO $$
DECLARE
    template_id_var integer;
BEGIN
    SELECT id INTO template_id_var FROM templates WHERE template_name = 'imported_campusshoes_com_1768906906';


    -- Section 1: Content Section
    -- CSS Data: {"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(0,0,0)", "boxShadow": "none", "padding": "10px 20px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"bor...
    -- Cards: 0 items
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
        2,
        'Content Section',
        'content-section',
        9228,
        172,
        ' @media (min-width: 768px) {#section-id-template--19851440292071__1638181377b2714d20 .slide-1 .overl',
        '@media (min-width: 768px) {#section-id-template--19851440292071__1638181377b2714d20 .slide-1 .overlay-text__title {font-size: 32.2px;',
        ' @media (min-width: 768px) {#section-id-template--19851440292071__1638181377b2714d20 .slide-1 .overlay-text__title {font-size: 32.2px;         }#section-id-template--19851440292071__1638181377b2714d20 .slide-2 .overlay-text__title {font-size: 32.2px;         }#section-id-template--19851440292071__1638181377b2714d20 .slide-3 .overlay-text__title {font-size: 32.2px;         }#section-id-template--19851440292071__1638181377b2714d20 .slide-4 .overlay-text__title {font-size: 32.2px;         }}       ',
        '',
        '',
        42,
        30,
        16,
        700,
        400,
        400,
        16,
        600,
        15,
        500,
        '1.00,1.00,1.00,1.00',
        '1.00,1.00,1.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.12,0.12,0.16,1.00',
        '1.00,1.00,1.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.78,0.39,0.49,1.00',
        '1.00,1.00,1.00,1.00',
        '0.12,0.12,0.16,1.00',
        '1.00,1.00,1.00,1.00',
        60,
        1,
        300,
        250,
        20,
        3,
        '',
        '',
        FALSE,
        '{"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(0,0,0)", "boxShadow": "none", "padding": "10px 20px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        NULL,
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat", "backgroundSize": "auto", "backgroundImage": "none"}, "position": {"position": "static", "top": "auto", "left": "auto", "right": "auto", "bottom": "auto", "zIndex": "auto"}, "typography": {"fontFamily": "system-ui"}}'
    );


    -- Section 2: Left Bestsellers Right View all Price ZEON Blue Me
    -- CSS Data: {"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(0,0,0)", "boxShadow": "none", "padding": "10px 20px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"bor...
    -- Cards: 0 items
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
        1,
        3,
        'Left Bestsellers Right View all Price ZEON Blue Me',
        'left-bestsellers-right-view-all-price-zeon-blue-me',
        790,
        993,
        'Left Bestsellers Right View all Price ZEON Blue Men''s Running Shoes ',
        '      <img data-wpsob="1" data-wpsob-height="1" height="1" data-wpsob-width="1" width="1" data-wpsob-lazy="1" loading="lazy" class="rimage__image" src="//www.campusshoes.com/cdn/shop/files/LEVEL_LEVEL',
        'Left Bestsellers Right View all Price ZEON Blue Men''s Running Shoes        <img data-wpsob="1" data-wpsob-height="1" height="1" data-wpsob-width="1" width="1" data-wpsob-lazy="1" loading="lazy" class="rimage__image" src="//www.campusshoes.com/cdn/shop/files/LEVEL_LEVEL_WHT-L.GRY_07_831c7a2c-ff1b-4011-9268-b11f984219c6_1024x1024.webp?v=1757580207" alt="Price ZEON Blue Men&#39;s Running Shoes">      Quick buy                LEVEL White Men''s Sneakers                 23 reviews  Rs. 1,799.00 6 7 8 ',
        '',
        '',
        42,
        30,
        16,
        700,
        400,
        400,
        16,
        600,
        15,
        500,
        '1.00,1.00,1.00,1.00',
        '1.00,1.00,1.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.18,0.18,0.22,1.00',
        '1.00,1.00,1.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.78,0.39,0.49,1.00',
        '1.00,1.00,1.00,1.00',
        '0.18,0.18,0.22,1.00',
        '1.00,1.00,1.00,1.00',
        60,
        1,
        800,
        1000,
        40,
        3,
        '',
        '',
        FALSE,
        '{"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(0,0,0)", "boxShadow": "none", "padding": "10px 20px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        NULL,
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat", "backgroundSize": "auto", "backgroundImage": "none"}, "position": {"position": "static", "top": "auto", "left": "auto", "right": "auto", "bottom": "auto", "zIndex": "auto"}, "typography": {"fontFamily": "system-ui"}}'
    );


    -- Section 3: Left Athleisure Apparels Right View all 
    -- CSS Data: {"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(0,0,0)", "boxShadow": "none", "padding": "10px 20px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"bor...
    -- Cards: 0 items
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
        2,
        3,
        'Left Athleisure Apparels Right View all ',
        'left-athleisure-apparels-right-view-all',
        819,
        1814,
        'Left Athleisure Apparels Right View all ',
        '      <img data-wpsob="1" data-wpsob-height="1" height="1" data-wpsob-width="1" width="1" data-wpsob-lazy="1" loading="lazy" class="rimage__image" src="//www.campusshoes.com/cdn/shop/files/SOLID-ROUND',
        'Left Athleisure Apparels Right View all        <img data-wpsob="1" data-wpsob-height="1" height="1" data-wpsob-width="1" width="1" data-wpsob-lazy="1" loading="lazy" class="rimage__image" src="//www.campusshoes.com/cdn/shop/files/SOLID-ROUNDNECK-DRYFIT-TSHIRT-BLACK_01_1024x1024.jpg?v=1765869676" alt="">      5% off Quick buy                Men''s Black Solid Round Neck T-Shirt                 No reviews  Rs. 569.00 Rs. 599.00 Sale Save 5% S M L XL XXL        <img data-wpsob="1" data-wpsob-height=',
        '',
        '',
        42,
        30,
        16,
        700,
        400,
        400,
        16,
        600,
        15,
        500,
        '1.00,1.00,1.00,1.00',
        '1.00,1.00,1.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.12,0.12,0.16,1.00',
        '1.00,1.00,1.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.78,0.39,0.49,1.00',
        '1.00,1.00,1.00,1.00',
        '0.12,0.12,0.16,1.00',
        '1.00,1.00,1.00,1.00',
        60,
        1,
        800,
        1000,
        40,
        3,
        '',
        '',
        FALSE,
        '{"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(0,0,0)", "boxShadow": "none", "padding": "10px 20px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        NULL,
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat", "backgroundSize": "auto", "backgroundImage": "none"}, "position": {"position": "static", "top": "auto", "left": "auto", "right": "auto", "bottom": "auto", "zIndex": "auto"}, "typography": {"fontFamily": "system-ui"}}'
    );


    -- Section 4: Content Section
    -- CSS Data: {"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(0,0,0)", "boxShadow": "none", "padding": "10px 20px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"bor...
    -- Cards: 0 items
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
        3,
        2,
        'Content Section',
        'content-section',
        1071,
        2683,
        '   .ai-video-hero-avvl3udu2bhvwc2fjvaigenblock5612643emvgxn {     position: relative;     width: 100',
        '  .ai-video-hero-avvl3udu2bhvwc2fjvaigenblock5612643emvgxn {',
        '   .ai-video-hero-avvl3udu2bhvwc2fjvaigenblock5612643emvgxn {     position: relative;     width: 100%;     overflow: hidden;     display: flex;     align-items: center;     justify-content: center;   }    .ai-video-hero-avvl3udu2bhvwc2fjvaigenblock5612643emvgxn::before {     content: '''';     display: block;     padding-top: 177.78%;   }    @media screen and (min-width: 750px) {     .ai-video-hero-avvl3udu2bhvwc2fjvaigenblock5612643emvgxn::before {       padding-top: 56.25%;     }   }    .ai-vide',
        '',
        '',
        42,
        30,
        16,
        700,
        400,
        400,
        16,
        600,
        15,
        500,
        '1.00,1.00,1.00,1.00',
        '1.00,1.00,1.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.12,0.12,0.16,1.00',
        '1.00,1.00,1.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.78,0.39,0.49,1.00',
        '1.00,1.00,1.00,1.00',
        '0.12,0.12,0.16,1.00',
        '1.00,1.00,1.00,1.00',
        60,
        1,
        300,
        250,
        20,
        3,
        '',
        '',
        FALSE,
        '{"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(0,0,0)", "boxShadow": "none", "padding": "10px 20px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        NULL,
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat", "backgroundSize": "auto", "backgroundImage": "none"}, "position": {"position": "static", "top": "auto", "left": "auto", "right": "auto", "bottom": "auto", "zIndex": "auto"}, "typography": {"fontFamily": "system-ui"}}'
    );


    -- Section 5: Men's Apparel NEW ARRIVAL 
    -- CSS Data: {"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(0,0,0)", "boxShadow": "none", "padding": "10px 20px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"bor...
    -- Cards: 0 items
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
        4,
        0,
        'Men''s Apparel NEW ARRIVAL ',
        'mens-apparel-new-arrival',
        800,
        4376,
        'Men''s Apparel NEW ARRIVAL ',
        '                      Shop Now',
        'Men''s Apparel NEW ARRIVAL                        Shop Now                      Men''s Sneakers #MoveYourWay                        Shop Now                      Women''s Apparel NEW ARRIVALS                        Shop Now                      Women''s Sneakers #YouGoGirl                        Shop Now                      Men''s Apparel NEW ARRIVAL                      Shop Now                    Men''s Sneakers #MoveYourWay                      Shop Now                    Women''s Apparel NEW ARRIV',
        '',
        '',
        42,
        30,
        16,
        700,
        400,
        400,
        16,
        600,
        15,
        500,
        '1.00,1.00,1.00,1.00',
        '1.00,1.00,1.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.12,0.12,0.16,1.00',
        '1.00,1.00,1.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.78,0.39,0.49,1.00',
        '1.00,1.00,1.00,1.00',
        '0.12,0.12,0.16,1.00',
        '1.00,1.00,1.00,1.00',
        60,
        1,
        300,
        250,
        20,
        3,
        '',
        '',
        FALSE,
        '{"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(0,0,0)", "boxShadow": "none", "padding": "10px 20px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        NULL,
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat", "backgroundSize": "auto", "backgroundImage": "none"}, "position": {"position": "static", "top": "auto", "left": "auto", "right": "auto", "bottom": "auto", "zIndex": "auto"}, "typography": {"fontFamily": "system-ui"}}'
    );


    -- Section 6: .p {
    -- CSS Data: {"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(0,0,0)", "boxShadow": "none", "padding": "10px 20px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"bor...
    -- Cards: 0 items
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
        5,
        2,
        '.p {',
        'p',
        300,
        7316,
        '.p {',
        '    margin:0;',
        '.p {     margin:0;     padding:0;   }      .section-template--19851440292071__ss_text_block_yWcWyx-padding {     max-width: 120rem;     margin: 0 auto;     padding: 0 1.5rem;     padding-top: 0px;     padding-bottom: 9px;   }    @media screen and (min-width: 750px) {     .section-template--19851440292071__ss_text_block_yWcWyx-padding {       padding: 0 5rem;       padding-top: 0px;       padding-bottom: 12px;     }   }    .ss-text-wrapper {     display:flex;     justify-content:center;   }    .s',
        '',
        '',
        42,
        30,
        16,
        700,
        400,
        400,
        16,
        600,
        15,
        500,
        '1.00,1.00,1.00,1.00',
        '1.00,1.00,1.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.18,0.18,0.22,1.00',
        '1.00,1.00,1.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.78,0.39,0.49,1.00',
        '1.00,1.00,1.00,1.00',
        '0.18,0.18,0.22,1.00',
        '1.00,1.00,1.00,1.00',
        60,
        1,
        300,
        250,
        20,
        3,
        '',
        '',
        FALSE,
        '{"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(0,0,0)", "boxShadow": "none", "padding": "10px 20px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        NULL,
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat", "backgroundSize": "auto", "backgroundImage": "none"}, "position": {"position": "static", "top": "auto", "left": "auto", "right": "auto", "bottom": "auto", "zIndex": "auto"}, "typography": {"fontFamily": "system-ui"}}'
    );

END $$;







COMMIT;


-- Template import complete!
-- Template name: imported_campusshoes_com_1768906906
-- Total sections: 6
--
-- To verify the import:
-- SELECT * FROM templates WHERE template_name = 'imported_campusshoes_com_1768906906';
-- SELECT COUNT(*) FROM sections WHERE template_id = (SELECT id FROM templates WHERE template_name = 'imported_campusshoes_com_1768906906');
