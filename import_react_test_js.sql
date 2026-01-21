-- Import Scraped Template: react_test_js
-- Generated: 2026-01-19 21:31:28
-- Source: https://react.dev
-- Sections: 2
--
-- Run this script to import the template into PostgreSQL:
-- psql -d website_builder < react_test_js.sql
--


BEGIN;

-- Insert the template
INSERT INTO templates (template_name, description, project_name, created_date)
VALUES (
    'react_test_js',
    'Imported from https://react.dev - Metadata: {"url": "https://react.dev", "scraped_date": "2026-01-19T21:31:28.030163", "forms": [{"y_position": 3260.453125, "height": 48, "width": 558, "inputs": [{"type": "text", "name": ":R1sq8q6:", "placeholder": "Search", "required": false}], "action": "https://react.dev/", "method": "get"}, {"y_position": 4512.546875, "height": 48, "width": 558, "inputs": [{"type": "text", "name": ":R6sqaq6:", "placeholder": "Search", "required": false}], "action": "https://react.dev/", "method": "get"}], "social_links": [{"platform": "Youtube", "href": "https://www.youtube.com/watch?v=8pDqJVdNa44", "position": {"x": 986, "y": 3363.953125}, "icon": ""}, {"platform": "Youtube", "href": "https://www.youtube.com/watch?v=8pDqJVdNa44", "position": {"x": 1142, "y": 3385.140625}, "icon": "React: The DocumentaryThe origin story of React"}, {"platform": "Youtube", "href": "https://www.youtube.com/watch?v=x7cQ3mrcKaY", "position": {"x": 986, "y": 3460.953125}, "icon": ""}, {"platform": "Youtube", "href": "https://www.youtube.com/watch?v=x7cQ3mrcKaY", "position": {"x": 1142, "y": 3482.140625}, "icon": "Rethinking Best PracticesPete Hunt (2013)"}, {"platform": "Youtube", "href": "https://www.youtube.com/watch?v=KVZ-P-ZI6W4", "position": {"x": 986, "y": 3557.953125}, "icon": ""}, {"platform": "Youtube", "href": "https://www.youtube.com/watch?v=KVZ-P-ZI6W4", "position": {"x": 1142, "y": 3579.140625}, "icon": "Introducing React NativeTom Occhino (2015)"}, {"platform": "Youtube", "href": "https://www.youtube.com/watch?v=V-QO-KO90iQ", "position": {"x": 986, "y": 3654.953125}, "icon": ""}, {"platform": "Youtube", "href": "https://www.youtube.com/watch?v=V-QO-KO90iQ", "position": {"x": 1142, "y": 3676.140625}, "icon": "Introducing React HooksSophie Alpert and Dan Abramov (2018)"}, {"platform": "Youtube", "href": "https://www.youtube.com/watch?v=TQQPAU21ZUw", "position": {"x": 986, "y": 3751.953125}, "icon": ""}, {"platform": "Youtube", "href": "https://www.youtube.com/watch?v=TQQPAU21ZUw", "position": {"x": 1142, "y": 3773.140625}, "icon": "Introducing Server ComponentsDan Abramov and Lauren Tan (2020)"}, {"platform": "Youtube", "href": "https://www.youtube.com/watch?v=FZ0cG47msEk&list=PLNG_1j3cPCaZZ7etkzWA7JfdmKWT0pMsa&index=1", "position": {"x": 986, "y": 4616.046875}, "icon": "<img class=\"h-8 w-8 border-2 shadow-md border-gray-70 object-cover rounded-full\" src=\"/images/home/conf2021/andrew.jpg\" alt=\"\">"}, {"platform": "Youtube", "href": "https://www.youtube.com/watch?v=FZ0cG47msEk&list=PLNG_1j3cPCaZZ7etkzWA7JfdmKWT0pMsa&index=1", "position": {"x": 1142, "y": 4637.234375}, "icon": "React 18 KeynoteThe React Team"}, {"platform": "Youtube", "href": "https://www.youtube.com/watch?v=ytudH8je5ko&list=PLNG_1j3cPCaZZ7etkzWA7JfdmKWT0pMsa&index=2", "position": {"x": 986, "y": 4713.046875}, "icon": "<img class=\"h-8 w-8 border-2 shadow-md border-gray-70 object-cover rounded-full\" src=\"/images/home/conf2021/shruti.jpg\" alt=\"\">"}, {"platform": "Youtube", "href": "https://www.youtube.com/watch?v=ytudH8je5ko&list=PLNG_1j3cPCaZZ7etkzWA7JfdmKWT0pMsa&index=2", "position": {"x": 1142, "y": 4734.234375}, "icon": "React 18 for App DevelopersShruti Kapoor"}, {"platform": "Youtube", "href": "https://www.youtube.com/watch?v=pj5N-Khihgc&list=PLNG_1j3cPCaZZ7etkzWA7JfdmKWT0pMsa&index=3", "position": {"x": 986, "y": 4810.046875}, "icon": "<img class=\"h-8 w-8 border-2 shadow-md border-gray-70 object-cover rounded-full\" src=\"/images/home/conf2021/shaundai.jpg\" alt=\"\">"}, {"platform": "Youtube", "href": "https://www.youtube.com/watch?v=pj5N-Khihgc&list=PLNG_1j3cPCaZZ7etkzWA7JfdmKWT0pMsa&index=3", "position": {"x": 1142, "y": 4831.234375}, "icon": "Streaming Server Rendering with SuspenseShaundai Person"}, {"platform": "Youtube", "href": "https://www.youtube.com/watch?v=qn7gRClrC9U&list=PLNG_1j3cPCaZZ7etkzWA7JfdmKWT0pMsa&index=4", "position": {"x": 986, "y": 4907.046875}, "icon": "<img class=\"h-8 w-8 border-2 shadow-md border-gray-70 object-cover rounded-full\" src=\"/images/home/conf2021/aakansha.jpg\" alt=\"\">"}, {"platform": "Youtube", "href": "https://www.youtube.com/watch?v=qn7gRClrC9U&list=PLNG_1j3cPCaZZ7etkzWA7JfdmKWT0pMsa&index=4", "position": {"x": 1142, "y": 4928.234375}, "icon": "The First React Working GroupAakansha Doshi"}, {"platform": "Youtube", "href": "https://www.youtube.com/watch?v=oxDfrke8rZg&list=PLNG_1j3cPCaZZ7etkzWA7JfdmKWT0pMsa&index=5", "position": {"x": 986, "y": 5004.046875}, "icon": "<img class=\"h-8 w-8 border-2 shadow-md border-gray-70 object-cover rounded-full\" src=\"/images/home/conf2021/brian.jpg\" alt=\"\">"}, {"platform": "Youtube", "href": "https://www.youtube.com/watch?v=oxDfrke8rZg&list=PLNG_1j3cPCaZZ7etkzWA7JfdmKWT0pMsa&index=5", "position": {"x": 1142, "y": 5025.234375}, "icon": "React Developer ToolingBrian Vaughn"}, {"platform": "Youtube", "href": "https://www.youtube.com/watch?v=lGEMwh32soc&list=PLNG_1j3cPCaZZ7etkzWA7JfdmKWT0pMsa&index=6", "position": {"x": 986, "y": 5101',  -- Limit to 5000 chars
    'React Test Js',
    '2026-01-19 21:31:28'
);


-- Get the template ID
DO $$
DECLARE
    template_id_var integer;
BEGIN
    SELECT id INTO template_id_var FROM templates WHERE template_name = 'react_test_js';


    -- Section 1: React
    -- CSS Data: {"button": {"borderRadius": "9999px", "borderWidth": "0px", "borderColor": "rgb(229, 231, 235)", "boxShadow": "none", "padding": "12px 24px", "textTransform": "none", "letterSpacing": "normal"}, "sect...
    -- Cards: 12 items
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
        'React',
        'react',
        900,
        96,
        'React',
        'Video.js',
        'The library for web and native user interfaces React lets you build user interfaces out of individual pieces called components. Create your own React components like Thumbnail, LikeButton, and Video. Then combine them into entire screens, pages, and apps. Video description',
        'Learn React',
        'https://react.dev/learn',
        52,
        40,
        32,
        600,
        400,
        400,
        17,
        700,
        15,
        500,
        '0.14,0.15,0.18,1.00',
        '0.14,0.15,0.18,1.00',
        '0.25,0.28,0.34,1.00',
        '0.00,0.00,0.00,0.00',
        '0.03,0.49,0.64,1.00',
        '0.8,0.4,0.5,1.0',
        '0.03,0.49,0.64,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,0.00',
        '0.03,0.49,0.64,1.00',
        80,
        1,
        300,
        250,
        20,
        3,
        'none',
        '',
        TRUE,
        '{"button": {"borderRadius": "9999px", "borderWidth": "0px", "borderColor": "rgb(229, 231, 235)", "boxShadow": "none", "padding": "12px 24px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "0px solid rgb(229, 231, 235)", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "30px", "letterSpacing": "normal"}}',
        '{"cards": [{"title": "Learn React", "description": "The library for web and native user interfaces", "link": "https://react.dev/learn", "button_text": "Learn React", "bg_color": "rgb(8, 126, 164)", "text_color": "rgb(255, 255, 255)", "title_font_size": 17, "title_font_weight": 700}, {"title": "API Reference", "description": "React lets you build user interfaces out of individual pieces called components. Create your own React components like Thumbnail, LikeButton, and Video. Then combine them into entire screens, pages, and apps.", "link": "https://react.dev/reference/react", "button_text": "API Reference", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(35, 39, 47)", "title_font_size": 17, "title_font_weight": 700}, {"title": "", "description": "Video description", "link": "", "button_text": "", "bg_color": "rgb(255, 255, 255)", "text_color": "rgba(255, 255, 255, 0.5)", "title_font_size": 17, "title_font_weight": 400}, {"title": "My videoVideo description", "description": "Whether you work on your own or with thousands of other developers, using React feels the same. It is designed to let you seamlessly combine components written by independent people, teams, and organizations.", "link": "", "button_text": "My videoVideo description", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(64, 71, 86)", "title_font_size": 17, "title_font_weight": 400}, {"title": "", "description": "React components are JavaScript functions. Want to show some content conditionally? Use an if statement. Displaying a list? Try array map(). Learning React is learning programming.", "link": "", "button_text": "", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(94, 104, 126)", "title_font_size": 17, "title_font_weight": 400}, {"title": "", "description": "Video description", "link": "", "button_text": "", "bg_color": "rgb(255, 255, 255)", "text_color": "rgba(255, 255, 255, 0.5)", "title_font_size": 17, "title_font_weight": 400}, {"title": "First videoVideo description", "description": "Video description", "link": "", "button_text": "First videoVideo description", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(64, 71, 86)", "title_font_size": 17, "title_font_weight": 400}, {"title": "", "description": "Video description", "link": "", "button_text": "", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(94, 104, 126)", "title_font_size": 17, "title_font_weight": 400}, {"title": "", "description": "This markup syntax is called JSX. It is a JavaScript syntax extension popularized by React. Putting JSX markup close to related rendering logic makes React components easy to create, maintain, and delete.", "link": "", "button_text": "", "bg_color": "rgb(255, 255, 255)", "text_color": "rgba(255, 255, 255, 0.5)", "title_font_size": 17, "title_font_weight": 400}, {"title": "Second videoVideo description", "description": "React components receive data and return what should appear on the screen. You can pass them new data in response to an interaction, like when the user types into an input. React will then update the screen to match the new data.", "link": "", "button_text": "Second videoVideo description", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(64, 71, 86)", "title_font_size": 17, "title_font_weight": 400}, {"title": "", "description": "A brief history of React", "link": "", "button_text": "", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(94, 104, 126)", "title_font_size": 17, "title_font_weight": 400}, {"title": "", "description": "The origin story of React", "link": "", "button_text": "", "bg_color": "rgb(255, 255, 255)", "text_color": "rgba(255, 255, 255, 0.5)", "title_font_size": 17, "title_font_weight": 400}], "paragraphs": [{"text": "The library for web and native user interfaces", "fontSize": 18, "fontWeight": 400, "color": "rgb(64, 71, 86)", "fontFamily": "\"Optimistic Display\", -apple-system, ui-sans-serif, system-ui, sans-serif, \"Apple Color Emoji\", \"Segoe UI Emoji\", \"Segoe UI Symbol\", \"Noto Color Emoji\""}, {"text": "React lets you build user interfaces out of individual pieces called components. Create your own React components like Thumbnail, LikeButton, and Video. Then combine them into entire screens, pages, and apps.", "fontSize": 20, "fontWeight": 400, "color": "rgb(64, 71, 86)", "fontFamily": "\"Optimistic Text\", -apple-system, ui-sans-serif, system-ui, sans-serif, \"Apple Color Emoji\", \"Segoe UI Emoji\", \"Segoe UI Symbol\", \"Noto Color Emoji\""}, {"text": "Video description", "fontSize": 13, "fontWeight": 400, "color": "rgb(94, 104, 126)", "fontFamily": "\"Optimistic Text\", -apple-system, ui-sans-serif, system-ui, sans-serif, \"Apple Color Emoji\", \"Segoe UI Emoji\", \"Segoe UI Symbol\", \"Noto Color Emoji\""}, {"text": "Whether you work on your own or with thousands of other developers, using React feels the same. It is designed to let you seamlessly combine components written by independent people, teams, and organizations.", "fontSize": 20, "fontWeight": 400, "color": "rgb(64, 71, 86)", "fontFamily": "\"Optimistic Text\", -apple-system, ui-sans-serif, system-ui, sans-serif, \"Apple Color Emoji\", \"Segoe UI Emoji\", \"Segoe UI Symbol\", \"Noto Color Emoji\""}, {"text": "React components are JavaScript functions. Want to show some content conditionally? Use an if statement. Displaying a list? Try array map(). Learning React is learning programming.", "fontSize": 20, "fontWeight": 400, "color": "rgb(64, 71, 86)", "fontFamily": "\"Optimistic Text\", -apple-system, ui-sans-serif, system-ui, sans-serif, \"Apple Color Emoji\", \"Segoe UI Emoji\", \"Segoe UI Symbol\", \"Noto Color Emoji\""}, {"text": "Video description", "fontSize": 13, "fontWeight": 400, "color": "rgb(94, 104, 126)", "fontFamily": "\"Optimistic Text\", -apple-system, ui-sans-serif, system-ui, sans-serif, \"Apple Color Emoji\", \"Segoe UI Emoji\", \"Segoe UI Symbol\", \"Noto Color Emoji\""}, {"text": "Video description", "fontSize": 13, "fontWeight": 400, "color": "rgb(94, 104, 126)", "fontFamily": "\"Optimistic Text\", -apple-system, ui-sans-serif, system-ui, sans-serif, \"Apple Color Emoji\", \"Segoe UI Emoji\", \"Segoe UI Symbol\", \"Noto Color Emoji\""}, {"text": "Video description", "fontSize": 13, "fontWeight": 400, "color": "rgb(94, 104, 126)", "fontFamily": "\"Optimistic Text\", -apple-system, ui-sans-serif, system-ui, sans-serif, \"Apple Color Emoji\", \"Segoe UI Emoji\", \"Segoe UI Symbol\", \"Noto Color Emoji\""}, {"text": "This markup syntax is called JSX. It is a JavaScript syntax extension popularized by React. Putting JSX markup close to related rendering logic makes React components easy to create, maintain, and delete.", "fontSize": 20, "fontWeight": 400, "color": "rgb(64, 71, 86)", "fontFamily": "\"Optimistic Text\", -apple-system, ui-sans-serif, system-ui, sans-serif, \"Apple Color Emoji\", \"Segoe UI Emoji\", \"Segoe UI Symbol\", \"Noto Color Emoji\""}, {"text": "React components receive data and return what should appear on the screen. You can pass them new data in response to an interaction, like when the user types into an input. React will then update the screen to match the new data.", "fontSize": 20, "fontWeight": 400, "color": "rgb(64, 71, 86)", "fontFamily": "\"Optimistic Text\", -apple-system, ui-sans-serif, system-ui, sans-serif, \"Apple Color Emoji\", \"Segoe UI Emoji\", \"Segoe UI Symbol\", \"Noto Color Emoji\""}], "hero_animation_images": ["https://react.dev/images/home/conf2021/cover.svg", "https://react.dev/images/home/community/react_conf_fun.webp", "https://react.dev/images/home/community/react_india_sunil.webp", "https://react.dev/images/home/community/react_conf_hallway.webp", "https://react.dev/images/home/community/react_india_hallway.webp"], "enable_hero_animation": true, "hero_animation_speed": 2.0}',
        '{"padding": {"top": "0px", "right": "0px", "bottom": "0px", "left": "0px"}, "flexbox": {"display": "flex", "flexDirection": "column", "justifyContent": "center", "alignItems": "normal", "gap": "normal"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat", "backgroundSize": "auto", "backgroundImage": "none"}, "position": {"position": "static", "top": "auto", "left": "auto", "right": "auto", "bottom": "auto", "zIndex": "auto"}, "typography": {"fontFamily": "\"Optimistic Text\", -apple-system, ui-sans-serif, system-ui, sans-serif, \"Apple Color Emoji\", \"Segoe UI Emoji\", \"Segoe UI Symbol\", \"Noto Color Emoji\""}}'
    );


    -- Section 2: Section 2
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
        10,
        'Section 2',
        'section-2',
        239,
        8714,
        '',
        '',
        '',
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
        '0.00,0.00,0.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.10,0.10,0.10,1.00',
        '0.8,0.4,0.5,1.0',
        '0.78,0.39,0.49,1.00',
        '1.00,1.00,1.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.20,0.20,0.20,1.00',
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
        '{"footer_links": [{"text": "@sawaratsuki1004", "href": "https://twitter.com/sawaratsuki1004", "category": "General"}, {"text": "Learn React", "href": "https://react.dev/learn", "category": "General"}, {"text": "Quick Start", "href": "https://react.dev/learn", "category": "General"}, {"text": "Installation", "href": "https://react.dev/learn/installation", "category": "General"}, {"text": "Describing the UI", "href": "https://react.dev/learn/describing-the-ui", "category": "General"}, {"text": "Adding Interactivity", "href": "https://react.dev/learn/adding-interactivity", "category": "General"}, {"text": "Managing State", "href": "https://react.dev/learn/managing-state", "category": "General"}, {"text": "Escape Hatches", "href": "https://react.dev/learn/escape-hatches", "category": "General"}, {"text": "API Reference", "href": "https://react.dev/reference/react", "category": "General"}, {"text": "React APIs", "href": "https://react.dev/reference/react", "category": "General"}, {"text": "React DOM APIs", "href": "https://react.dev/reference/react-dom", "category": "General"}, {"text": "Community", "href": "https://react.dev/community", "category": "General"}, {"text": "Code of Conduct", "href": "https://github.com/facebook/react/blob/main/CODE_OF_CONDUCT.md", "category": "General"}, {"text": "Meet the Team", "href": "https://react.dev/community/team", "category": "General"}, {"text": "Docs Contributors", "href": "https://react.dev/community/docs-contributors", "category": "General"}, {"text": "Acknowledgements", "href": "https://react.dev/community/acknowledgements", "category": "General"}, {"text": "Blog", "href": "https://react.dev/blog", "category": "General"}, {"text": "React Native", "href": "https://reactnative.dev/", "category": "General"}, {"text": "Privacy", "href": "https://opensource.facebook.com/legal/privacy", "category": "General"}, {"text": "Terms", "href": "https://opensource.fb.com/legal/terms/", "category": "General"}], "social_links": [{"platform": "Twitter", "href": "https://twitter.com/sawaratsuki1004", "icon": ""}, {"platform": "Facebook", "href": "https://github.com/facebook/react/blob/main/CODE_OF_CONDUCT.md", "icon": ""}, {"platform": "Facebook", "href": "https://opensource.facebook.com/legal/privacy", "icon": ""}, {"platform": "Facebook", "href": "https://www.facebook.com/react", "icon": "<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 24 24\" width=\"1.33em\" height=\"1.33em\" fill=\"currentColor\"><path fill=\"none\" d=\"M0 0h24v24H0z\"></path><path d=\"M12 2C6.477 2 2 6.477 2 12c0 4.991 3.657 9.128 8.438 9.879V14.89h-2.54V12h2.54V9.797c0-2.506 1.492-3.89 3.777-3.89 1.094 0 2.238.195 2.238.195v2.46h-1.26c-1.243 0-1.63.771-1.63 1.562V12h2.773l-.443 2.89h-2.33v6.989C18.343 21.129 22 16.99 22 12c0-5.523-4.477-10-10-10z\"></path></svg>"}, {"platform": "Twitter", "href": "https://twitter.com/reactjs", "icon": "<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 512 512\" height=\"1.30em\" width=\"1.30em\" fill=\"currentColor\"><path fill=\"none\" d=\"M0 0h24v24H0z\"></path><path d=\"M389.2 48h70.6L305.6 224.2 487 464H345L233.7 318.6 106.5 464H35.8L200.7 275.5 26.8 48H172.4L272.9 180.9 389.2 48zM364.4 421.8h39.1L151.1 88h-42L364.4 421.8z\"></path></svg>"}, {"platform": "Facebook", "href": "https://github.com/facebook/react", "icon": "<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"1.5em\" height=\"1.5em\" viewBox=\"0 -2 24 24\" fill=\"currentColor\"><path d=\"M10 0a10 10 0 0 0-3.16 19.49c.5.1.68-.22.68-.48l-.01-1.7c-2.78.6-3.37-1.34-3.37-1.34-.46-1.16-1.11-1.47-1.11-1.47-.9-.62.07-.6.07-.6 1 .07 1.53 1.03 1.53 1.03.9 1.52 2.34 1.08 2.91.83.1-.65.35-1.09.63-1.34-2.22-.25-4.55-1.11-4.55-4.94 0-1.1.39-1.99 1.03-2.69a3.6 3.6 0 0 1 .1-2.64s.84-.27 2.75 1.02a9.58 9.58 0 0 1 5 0c1.91-1.3 2.75-1.02 2.75-1.02.55 1.37.2 2.4.1 2.64.64.7 1.03 1.6 1.03 2.69 0 3.84-2.34 4.68-4.57 4.93.36.31.68.92.68 1.85l-.01 2.75c0 .26.18.58.69.48A10 10 0 0 0 10 0\"></path></svg>"}], "copyright": "\u00a9 Meta Platforms, Incno uwu plzuwu?Logo by@sawaratsuki1004Learn ReactQuick StartInstallationDescribing the UIAdding InteractivityManaging StateEscape HatchesAPI ReferenceReact APIsReact DOM APIsCommunityCode of ConductMeet the TeamDocs ContributorsAcknowledgementsMoreBlogReact NativePrivacyTerms"}',
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat", "backgroundSize": "auto", "backgroundImage": "none"}, "position": {"position": "static", "top": "auto", "left": "auto", "right": "auto", "bottom": "auto", "zIndex": "auto"}, "typography": {"fontFamily": "system-ui"}}'
    );

END $$;



COMMIT;


-- Template import complete!
-- Template name: react_test_js
-- Total sections: 2
--
-- To verify the import:
-- SELECT * FROM templates WHERE template_name = 'react_test_js';
-- SELECT COUNT(*) FROM sections WHERE template_id = (SELECT id FROM templates WHERE template_name = 'react_test_js');

-- Update sections with BYTEA image data
