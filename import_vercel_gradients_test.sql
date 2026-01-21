-- Import Scraped Template: vercel_gradients_test
-- Generated: 2026-01-15 11:01:34
-- Source: https://vercel.com
-- Sections: 8
--
-- Run this script to import the template into PostgreSQL:
-- psql -d website_builder < vercel_gradients_test.sql
--


BEGIN;

-- Insert the template
INSERT INTO templates (template_name, description, project_name, created_date)
VALUES (
    'vercel_gradients_test',
    'Imported from https://vercel.com',
    'Vercel Gradients Test',
    '2026-01-15 11:01:34'
);


-- Get the template ID
DO $$
DECLARE
    template_id_var integer;
BEGIN
    SELECT id INTO template_id_var FROM templates WHERE template_name = 'vercel_gradients_test';


    -- Section 1: AI Cloud
    -- CSS Data: {"button": {"borderRadius": "4px", "borderWidth": "0px", "borderColor": "rgb(23, 23, 23)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"bord...
    -- Cards: 12 items
    INSERT INTO sections (
        template_id, section_order, type, name, section_id, height, y_position,
        title, subtitle, content, button_text, button_link,
        title_font_size, subtitle_font_size, content_font_size,
        title_font_weight, subtitle_font_weight, content_font_weight,
        button_font_size, button_font_weight, nav_font_size, nav_font_weight,
        title_color, subtitle_color, content_color, bg_color, text_color,
        accent_color, button_bg_color, button_text_color,
        padding, text_align, card_width, card_height, card_spacing, cards_per_row,
        background_image, section_image, use_bg_image, css_data, interactive_data, layout_data
    ) VALUES (
        template_id_var,
        0,
        8,
        'AI Cloud',
        'ai-cloud',
        64,
        0,
        'AI Cloud',
        'Security',
        'Vercel provides the developer tools and cloud infrastructure to build, scale, and secure a faster, more personalized web.',
        '',
        'https://vercel.com/home',
        14,
        2,
        20,
        400,
        400,
        400,
        16,
        400,
        15,
        500,
        '0.40,0.40,0.40,1.00',
        '0.40,0.40,0.40,1.00',
        '0.40,0.40,0.40,1.00',
        '0.00,0.00,0.00,0.00',
        '0.09,0.09,0.09,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.09,0.09,0.09,1.00',
        60,
        1,
        300,
        250,
        20,
        3,
        'none',
        'scraped_images/vercel_gradients_test/img_1.jpg',
        TRUE,
        '{"button": {"borderRadius": "4px", "borderWidth": "0px", "borderColor": "rgb(23, 23, 23)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "0px none rgb(23, 23, 23)", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        '{"cards": [{"title": "", "description": "Vercel provides the developer tools and cloud infrastructure to build, scale, and secure a faster, more personalized web.", "link": "https://vercel.com/home", "button_text": "", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(23, 23, 23)", "title_font_size": 16, "title_font_weight": 400}, {"title": "Products", "description": "", "link": "", "button_text": "Products", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(102, 102, 102)", "title_font_size": 14, "title_font_weight": 400}, {"title": "AI Cloud", "description": "", "link": "https://vercel.com/ai", "button_text": "AI Cloud", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(102, 102, 102)", "title_font_size": 14, "title_font_weight": 400}, {"title": "v0Build applications with AI", "description": "", "link": "https://v0.app/", "button_text": "v0Build applications with AI", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(102, 102, 102)", "title_font_size": 14, "title_font_weight": 400}, {"title": "CI/CDHelping teams ship 6\u00d7 faster", "description": "", "link": "https://vercel.com/products/previews", "button_text": "CI/CDHelping teams ship 6\u00d7 faster", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(23, 23, 23)", "title_font_size": 14, "title_font_weight": 400}, {"title": "Security", "description": "", "link": "https://vercel.com/security", "button_text": "Security", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(102, 102, 102)", "title_font_size": 14, "title_font_weight": 400}, {"title": "Bot ManagementScalable bot protection", "description": "", "link": "https://vercel.com/security/bot-management", "button_text": "Bot ManagementScalable bot protection", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(23, 23, 23)", "title_font_size": 14, "title_font_weight": 400}, {"title": "Resources", "description": "", "link": "", "button_text": "Resources", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(102, 102, 102)", "title_font_size": 14, "title_font_weight": 400}, {"title": "CustomersTrusted by the best teams", "description": "", "link": "https://vercel.com/customers", "button_text": "CustomersTrusted by the best teams", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(23, 23, 23)", "title_font_size": 14, "title_font_weight": 400}, {"title": "DocsVercel documentation", "description": "", "link": "https://vercel.com/docs", "button_text": "DocsVercel documentation", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(23, 23, 23)", "title_font_size": 14, "title_font_weight": 400}, {"title": "Next.jsThe native Next.js platform", "description": "", "link": "https://vercel.com/frameworks/nextjs", "button_text": "Next.jsThe native Next.js platform", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(23, 23, 23)", "title_font_size": 14, "title_font_weight": 400}, {"title": "Solutions", "description": "", "link": "", "button_text": "Solutions", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(102, 102, 102)", "title_font_size": 14, "title_font_weight": 400}]}',
        '{"padding": {"top": "64px", "right": "0px", "bottom": "0px", "left": "0px"}, "flexbox": {"display": "flex", "flexDirection": "column", "justifyContent": "flex-start", "alignItems": "stretch", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat", "backgroundSize": "auto", "backgroundImage": "none"}, "position": {"position": "static", "top": "auto", "left": "auto", "right": "auto", "bottom": "auto", "zIndex": "auto"}, "typography": {"fontFamily": "Geist, Arial, \"Apple Color Emoji\", \"Segoe UI Emoji\", \"Segoe UI Symbol\""}}'
    );


    -- Section 2: Build and deploy on the AI Cloud.
    -- CSS Data: {"button": {"borderRadius": "6px", "borderWidth": "0px", "borderColor": "rgb(102, 102, 102)", "boxShadow": "none", "padding": "12px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"...
    -- Cards: 12 items
    INSERT INTO sections (
        template_id, section_order, type, name, section_id, height, y_position,
        title, subtitle, content, button_text, button_link,
        title_font_size, subtitle_font_size, content_font_size,
        title_font_weight, subtitle_font_weight, content_font_weight,
        button_font_size, button_font_weight, nav_font_size, nav_font_weight,
        title_color, subtitle_color, content_color, bg_color, text_color,
        accent_color, button_bg_color, button_text_color,
        padding, text_align, card_width, card_height, card_spacing, cards_per_row,
        background_image, section_image, use_bg_image, css_data, interactive_data, layout_data
    ) VALUES (
        template_id_var,
        1,
        0,
        'Build and deploy on the AI Cloud.',
        'build-and-deploy-on-the-ai-cloud',
        900,
        64,
        'Build and deploy on the AI Cloud.',
        '',
        'Build applications with AI The AI Toolkit for TypeScript One endpoint, all your models',
        'AI SDKThe AI Toolkit for TypeScript',
        'https://sdk.vercel.ai/',
        48,
        36,
        12,
        600,
        400,
        400,
        14,
        400,
        15,
        500,
        '0.09,0.09,0.09,1.00',
        '0.09,0.09,0.09,1.00',
        '0.40,0.40,0.40,1.00',
        '0.98,0.98,0.98,1.00',
        '0.09,0.09,0.09,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.40,0.40,0.40,1.00',
        120,
        1,
        300,
        250,
        20,
        3,
        'none',
        '',
        TRUE,
        '{"button": {"borderRadius": "6px", "borderWidth": "0px", "borderColor": "rgb(102, 102, 102)", "boxShadow": "none", "padding": "12px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "0px none rgb(23, 23, 23)", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        '{"cards": [{"title": "AI SDKThe AI Toolkit for TypeScript", "description": "Build applications with AI", "link": "https://sdk.vercel.ai/", "button_text": "AI SDKThe AI Toolkit for TypeScript", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(102, 102, 102)", "title_font_size": 14, "title_font_weight": 400}, {"title": "AI GatewayOne endpoint, all your models", "description": "The AI Toolkit for TypeScript", "link": "https://vercel.com/ai-gateway", "button_text": "AI GatewayOne endpoint, all your models", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(23, 23, 23)", "title_font_size": 14, "title_font_weight": 400}, {"title": "Vercel AgentAn agent that knows your stack", "description": "One endpoint, all your models", "link": "https://vercel.com/agent", "button_text": "Vercel AgentAn agent that knows your stack", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(23, 23, 23)", "title_font_size": 14, "title_font_weight": 400}, {"title": "SandboxAI workflows in live environments", "description": "An agent that knows your stack", "link": "https://vercel.com/sandbox", "button_text": "SandboxAI workflows in live environments", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(23, 23, 23)", "title_font_size": 14, "title_font_weight": 400}, {"title": "Content DeliveryFast, scalable, and reliable", "description": "AI workflows in live environments", "link": "https://vercel.com/products/rendering", "button_text": "Content DeliveryFast, scalable, and reliable", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(23, 23, 23)", "title_font_size": 14, "title_font_weight": 400}, {"title": "Fluid ComputeServers, in serverless form", "description": "Helping teams ship 6\u00d7 faster", "link": "https://vercel.com/fluid", "button_text": "Fluid ComputeServers, in serverless form", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(23, 23, 23)", "title_font_size": 14, "title_font_weight": 400}, {"title": "ObservabilityTrace every step", "description": "Fast, scalable, and reliable", "link": "https://vercel.com/products/observability", "button_text": "ObservabilityTrace every step", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(23, 23, 23)", "title_font_size": 14, "title_font_weight": 400}, {"title": "BotIDInvisible CAPTCHA", "description": "Servers, in serverless form", "link": "https://vercel.com/botid", "button_text": "BotIDInvisible CAPTCHA", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(23, 23, 23)", "title_font_size": 14, "title_font_weight": 400}, {"title": "Platform SecurityDDoS Protection, Firewall", "description": "Trace every step", "link": "https://vercel.com/security", "button_text": "Platform SecurityDDoS Protection, Firewall", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(23, 23, 23)", "title_font_size": 14, "title_font_weight": 400}, {"title": "BlogThe latest posts and changes", "description": "Scalable bot protection", "link": "https://vercel.com/blog", "button_text": "BlogThe latest posts and changes", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(23, 23, 23)", "title_font_size": 14, "title_font_weight": 400}, {"title": "ChangelogSee what shipped", "description": "Invisible CAPTCHA", "link": "https://vercel.com/changelog", "button_text": "ChangelogSee what shipped", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(23, 23, 23)", "title_font_size": 14, "title_font_weight": 400}, {"title": "PressRead the latest news", "description": "DDoS Protection, Firewall", "link": "https://vercel.com/press", "button_text": "PressRead the latest news", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(23, 23, 23)", "title_font_size": 14, "title_font_weight": 400}]}',
        '{"padding": {"top": "0px", "right": "0px", "bottom": "0px", "left": "0px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "normal"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat", "backgroundSize": "auto", "backgroundImage": "none"}, "position": {"position": "relative", "top": "0px", "left": "0px", "right": "0px", "bottom": "0px", "zIndex": "2"}, "typography": {"fontFamily": "Geist, Arial, \"Apple Color Emoji\", \"Segoe UI Emoji\", \"Segoe UI Symbol\""}}'
    );


    -- Section 3: Build and deploy on the AI Cloud.
    -- CSS Data: {"button": {"borderRadius": "6px", "borderWidth": "0px", "borderColor": "rgb(23, 23, 23)", "boxShadow": "none", "padding": "12px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"bor...
    -- Cards: 12 items
    INSERT INTO sections (
        template_id, section_order, type, name, section_id, height, y_position,
        title, subtitle, content, button_text, button_link,
        title_font_size, subtitle_font_size, content_font_size,
        title_font_weight, subtitle_font_weight, content_font_weight,
        button_font_size, button_font_weight, nav_font_size, nav_font_weight,
        title_color, subtitle_color, content_color, bg_color, text_color,
        accent_color, button_bg_color, button_text_color,
        padding, text_align, card_width, card_height, card_spacing, cards_per_row,
        background_image, section_image, use_bg_image, css_data, interactive_data, layout_data
    ) VALUES (
        template_id_var,
        2,
        0,
        'Build and deploy on the AI Cloud.',
        'build-and-deploy-on-the-ai-cloud',
        719,
        129,
        'Build and deploy on the AI Cloud.',
        '',
        'The AI Toolkit for TypeScript One endpoint, all your models An agent that knows your stack',
        'AI GatewayOne endpoint, all your models',
        'https://vercel.com/ai-gateway',
        48,
        36,
        12,
        600,
        400,
        400,
        14,
        400,
        15,
        500,
        '0.09,0.09,0.09,1.00',
        '0.09,0.09,0.09,1.00',
        '0.40,0.40,0.40,1.00',
        '0.00,0.00,0.00,0.00',
        '0.09,0.09,0.09,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.09,0.09,0.09,1.00',
        120,
        1,
        300,
        250,
        20,
        3,
        'none',
        '',
        TRUE,
        '{"button": {"borderRadius": "6px", "borderWidth": "0px", "borderColor": "rgb(23, 23, 23)", "boxShadow": "none", "padding": "12px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "0px none rgb(23, 23, 23)", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        '{"cards": [{"title": "AI GatewayOne endpoint, all your models", "description": "The AI Toolkit for TypeScript", "link": "https://vercel.com/ai-gateway", "button_text": "AI GatewayOne endpoint, all your models", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(23, 23, 23)", "title_font_size": 14, "title_font_weight": 400}, {"title": "Vercel AgentAn agent that knows your stack", "description": "One endpoint, all your models", "link": "https://vercel.com/agent", "button_text": "Vercel AgentAn agent that knows your stack", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(23, 23, 23)", "title_font_size": 14, "title_font_weight": 400}, {"title": "SandboxAI workflows in live environments", "description": "An agent that knows your stack", "link": "https://vercel.com/sandbox", "button_text": "SandboxAI workflows in live environments", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(23, 23, 23)", "title_font_size": 14, "title_font_weight": 400}, {"title": "Fluid ComputeServers, in serverless form", "description": "AI workflows in live environments", "link": "https://vercel.com/fluid", "button_text": "Fluid ComputeServers, in serverless form", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(23, 23, 23)", "title_font_size": 14, "title_font_weight": 400}, {"title": "ObservabilityTrace every step", "description": "Fast, scalable, and reliable", "link": "https://vercel.com/products/observability", "button_text": "ObservabilityTrace every step", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(23, 23, 23)", "title_font_size": 14, "title_font_weight": 400}, {"title": "Platform SecurityDDoS Protection, Firewall", "description": "Servers, in serverless form", "link": "https://vercel.com/security", "button_text": "Platform SecurityDDoS Protection, Firewall", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(23, 23, 23)", "title_font_size": 14, "title_font_weight": 400}, {"title": "ChangelogSee what shipped", "description": "Trace every step", "link": "https://vercel.com/changelog", "button_text": "ChangelogSee what shipped", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(23, 23, 23)", "title_font_size": 14, "title_font_weight": 400}, {"title": "PressRead the latest news", "description": "Invisible CAPTCHA", "link": "https://vercel.com/press", "button_text": "PressRead the latest news", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(23, 23, 23)", "title_font_size": 14, "title_font_weight": 400}, {"title": "EventsJoin us at an event", "description": "DDoS Protection, Firewall", "link": "https://vercel.com/events", "button_text": "EventsJoin us at an event", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(23, 23, 23)", "title_font_size": 14, "title_font_weight": 400}, {"title": "Knowledge BaseFind help quickly", "description": "Granular, custom protection", "link": "https://vercel.com/kb", "button_text": "Knowledge BaseFind help quickly", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(23, 23, 23)", "title_font_size": 14, "title_font_weight": 400}, {"title": "CommunityJoin the conversation", "description": "The latest posts and changes", "link": "https://community.vercel.com/", "button_text": "CommunityJoin the conversation", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(23, 23, 23)", "title_font_size": 14, "title_font_weight": 400}, {"title": "SvelteThe web\u2019s efficient UI framework", "description": "See what shipped", "link": "https://svelte.dev/", "button_text": "SvelteThe web\u2019s efficient UI framework", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(102, 102, 102)", "title_font_size": 14, "title_font_weight": 400}]}',
        '{"padding": {"top": "48px", "right": "48px", "bottom": "48px", "left": "48px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "normal"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat", "backgroundSize": "auto", "backgroundImage": "none"}, "position": {"position": "static", "top": "auto", "left": "auto", "right": "auto", "bottom": "auto", "zIndex": "2"}, "typography": {"fontFamily": "Geist, Arial, \"Apple Color Emoji\", \"Segoe UI Emoji\", \"Segoe UI Symbol\""}}'
    );


    -- Section 4: Build and deploy on the AI Cloud.
    -- CSS Data: {"button": {"borderRadius": "6px", "borderWidth": "0px", "borderColor": "rgb(23, 23, 23)", "boxShadow": "none", "padding": "12px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"bor...
    -- Cards: 10 items
    INSERT INTO sections (
        template_id, section_order, type, name, section_id, height, y_position,
        title, subtitle, content, button_text, button_link,
        title_font_size, subtitle_font_size, content_font_size,
        title_font_weight, subtitle_font_weight, content_font_weight,
        button_font_size, button_font_weight, nav_font_size, nav_font_weight,
        title_color, subtitle_color, content_color, bg_color, text_color,
        accent_color, button_bg_color, button_text_color,
        padding, text_align, card_width, card_height, card_spacing, cards_per_row,
        background_image, section_image, use_bg_image, css_data, interactive_data, layout_data
    ) VALUES (
        template_id_var,
        3,
        8,
        'Build and deploy on the AI Cloud.',
        'build-and-deploy-on-the-ai-cloud',
        358,
        218,
        'Build and deploy on the AI Cloud.',
        '',
        'An agent that knows your stack AI workflows in live environments Trace every step',
        'Vercel AgentAn agent that knows your stack',
        'https://vercel.com/agent',
        48,
        36,
        12,
        600,
        400,
        400,
        14,
        400,
        15,
        500,
        '0.09,0.09,0.09,1.00',
        '0.09,0.09,0.09,1.00',
        '0.40,0.40,0.40,1.00',
        '0.00,0.00,0.00,0.00',
        '0.09,0.09,0.09,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.09,0.09,0.09,1.00',
        180,
        1,
        300,
        250,
        60,
        3,
        'none',
        '',
        TRUE,
        '{"button": {"borderRadius": "6px", "borderWidth": "0px", "borderColor": "rgb(23, 23, 23)", "boxShadow": "none", "padding": "12px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "0px none rgb(23, 23, 23)", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        '{"cards": [{"title": "Vercel AgentAn agent that knows your stack", "description": "An agent that knows your stack", "link": "https://vercel.com/agent", "button_text": "Vercel AgentAn agent that knows your stack", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(23, 23, 23)", "title_font_size": 14, "title_font_weight": 400}, {"title": "SandboxAI workflows in live environments", "description": "AI workflows in live environments", "link": "https://vercel.com/sandbox", "button_text": "SandboxAI workflows in live environments", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(23, 23, 23)", "title_font_size": 14, "title_font_weight": 400}, {"title": "ObservabilityTrace every step", "description": "Trace every step", "link": "https://vercel.com/products/observability", "button_text": "ObservabilityTrace every step", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(23, 23, 23)", "title_font_size": 14, "title_font_weight": 400}, {"title": "PressRead the latest news", "description": "Granular, custom protection", "link": "https://vercel.com/press", "button_text": "PressRead the latest news", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(23, 23, 23)", "title_font_size": 14, "title_font_weight": 400}, {"title": "EventsJoin us at an event", "description": "Read the latest news", "link": "https://vercel.com/events", "button_text": "EventsJoin us at an event", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(23, 23, 23)", "title_font_size": 14, "title_font_weight": 400}, {"title": "CommunityJoin the conversation", "description": "Join us at an event", "link": "https://community.vercel.com/", "button_text": "CommunityJoin the conversation", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(23, 23, 23)", "title_font_size": 14, "title_font_weight": 400}, {"title": "TurborepoSpeed with Enterprise scale", "description": "Join the conversation", "link": "https://vercel.com/solutions/turborepo", "button_text": "TurborepoSpeed with Enterprise scale", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(23, 23, 23)", "title_font_size": 14, "title_font_weight": 400}, {"title": "Web AppsShip features, not infrastructure", "description": "Speed with Enterprise scale", "link": "https://vercel.com/solutions/web-apps", "button_text": "Web AppsShip features, not infrastructure", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(23, 23, 23)", "title_font_size": 14, "title_font_weight": 400}, {"title": "DeployStart Deploying", "description": "Scale apps with one codebase", "link": "https://vercel.com/new", "button_text": "DeployStart Deploying", "bg_color": "rgb(23, 23, 23)", "text_color": "rgb(255, 255, 255)", "title_font_size": 16, "title_font_weight": 500}, {"title": "Get a Demo", "description": "Ship features, not infrastructure", "link": "https://vercel.com/contact/sales", "button_text": "Get a Demo", "bg_color": "rgb(255, 255, 255)", "text_color": "rgb(23, 23, 23)", "title_font_size": 16, "title_font_weight": 500}]}',
        '{"padding": {"top": "0px", "right": "0px", "bottom": "0px", "left": "0px"}, "flexbox": {"display": "flex", "flexDirection": "column", "justifyContent": "flex-start", "alignItems": "center", "gap": "24px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat", "backgroundSize": "auto", "backgroundImage": "none"}, "position": {"position": "static", "top": "auto", "left": "auto", "right": "auto", "bottom": "auto", "zIndex": "auto"}, "typography": {"fontFamily": "Geist, Arial, \"Apple Color Emoji\", \"Segoe UI Emoji\", \"Segoe UI Symbol\""}}'
    );


    -- Section 5: 
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
        padding, text_align, card_width, card_height, card_spacing, cards_per_row,
        background_image, section_image, use_bg_image, css_data, interactive_data, layout_data
    ) VALUES (
        template_id_var,
        4,
        3,
        '',
        '',
        271,
        848,
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
        '0.09,0.09,0.09,1.00',
        '0.09,0.09,0.09,1.00',
        '0.09,0.09,0.09,1.00',
        '0.00,0.00,0.00,0.00',
        '0.09,0.09,0.09,1.00',
        '0.8,0.4,0.5,1.0',
        '0.78,0.39,0.49,1.00',
        '1.00,1.00,1.00,1.00',
        180,
        1,
        800,
        1000,
        40,
        3,
        'none',
        '',
        TRUE,
        '{"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(0,0,0)", "boxShadow": "none", "padding": "10px 20px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "0px none rgb(23, 23, 23)", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        NULL,
        '{"padding": {"top": "0px", "right": "0px", "bottom": "0px", "left": "0px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "normal"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat", "backgroundSize": "auto", "backgroundImage": "none"}, "position": {"position": "static", "top": "auto", "left": "auto", "right": "auto", "bottom": "auto", "zIndex": "auto"}, "typography": {"fontFamily": "Geist, Arial, \"Apple Color Emoji\", \"Segoe UI Emoji\", \"Segoe UI Symbol\""}}'
    );


    -- Section 6: Scale your
    -- CSS Data: {"button": {"borderRadius": "100px", "borderWidth": "0px", "borderColor": "rgb(23, 23, 23)", "boxShadow": "rgba(0, 0, 0, 0.08) 0px 0px 0px 1px, rgba(0, 0, 0, 0.04) 0px 2px 2px 0px, rgb(250, 250, 250) ...
    -- Cards: 5 items
    INSERT INTO sections (
        template_id, section_order, type, name, section_id, height, y_position,
        title, subtitle, content, button_text, button_link,
        title_font_size, subtitle_font_size, content_font_size,
        title_font_weight, subtitle_font_weight, content_font_weight,
        button_font_size, button_font_weight, nav_font_size, nav_font_weight,
        title_color, subtitle_color, content_color, bg_color, text_color,
        accent_color, button_bg_color, button_text_color,
        padding, text_align, card_width, card_height, card_spacing, cards_per_row,
        background_image, section_image, use_bg_image, css_data, interactive_data, layout_data
    ) VALUES (
        template_id_var,
        5,
        8,
        'Scale your',
        'scale-your',
        389,
        1134,
        'Scale your',
        '',
        'Ready to deploy? Start building with a free account. Speak to an expert for your Pro or Enterprise needs. Explore Vercel Enterprise with an interactive product tour, trial, or a personalized demo.',
        'Enterprise',
        'https://vercel.com/enterprise',
        24,
        12,
        24,
        600,
        400,
        500,
        14,
        500,
        15,
        500,
        '0.09,0.09,0.09,1.00',
        '0.09,0.09,0.09,1.00',
        '0.40,0.40,0.40,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '1.00,1.00,1.00,1.00',
        '0.09,0.09,0.09,1.00',
        180,
        1,
        300,
        250,
        60,
        3,
        '',
        '',
        FALSE,
        '{"button": {"borderRadius": "100px", "borderWidth": "0px", "borderColor": "rgb(23, 23, 23)", "boxShadow": "rgba(0, 0, 0, 0.08) 0px 0px 0px 1px, rgba(0, 0, 0, 0.04) 0px 2px 2px 0px, rgb(250, 250, 250) 0px 0px 0px 1px", "padding": "0px 10px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        '{"cards": [{"title": "Enterprise", "description": "Ready to deploy? Start building with a free account. Speak to an expert for your Pro or Enterprise needs.", "link": "https://vercel.com/enterprise", "button_text": "Enterprise", "bg_color": "rgb(255, 255, 255)", "text_color": "rgb(23, 23, 23)", "title_font_size": 14, "title_font_weight": 500}, {"title": "Security", "description": "Explore Vercel Enterprise with an interactive product tour, trial, or a personalized demo.", "link": "https://vercel.com/security", "button_text": "Security", "bg_color": "rgb(255, 255, 255)", "text_color": "rgb(23, 23, 23)", "title_font_size": 14, "title_font_weight": 500}, {"title": "Start Deploying", "description": "", "link": "https://vercel.com/new", "button_text": "Start Deploying", "bg_color": "rgb(23, 23, 23)", "text_color": "rgb(255, 255, 255)", "title_font_size": 14, "title_font_weight": 500}, {"title": "Talk to an Expert", "description": "", "link": "https://vercel.com/contact/sales", "button_text": "Talk to an Expert", "bg_color": "rgb(255, 255, 255)", "text_color": "rgb(23, 23, 23)", "title_font_size": 14, "title_font_weight": 500}, {"title": "Explore Enterprise", "description": "", "link": "https://vercel.com/try-enterprise", "button_text": "Explore Enterprise", "bg_color": "rgb(255, 255, 255)", "text_color": "rgb(23, 23, 23)", "title_font_size": 14, "title_font_weight": 500}]}',
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat", "backgroundSize": "auto", "backgroundImage": "none"}, "position": {"position": "static", "top": "auto", "left": "auto", "right": "auto", "bottom": "auto", "zIndex": "auto"}, "typography": {"fontFamily": "Geist, Arial, \"Apple Color Emoji\", \"Segoe UI Emoji\", \"Segoe UI Symbol\""}}'
    );


    -- Section 7: 
    -- CSS Data: {"button": {"borderRadius": "100px", "borderWidth": "0px", "borderColor": "rgb(255, 255, 255)", "boxShadow": "none", "padding": "0px 10px", "textTransform": "none", "letterSpacing": "normal"}, "sectio...
    -- Cards: 0 items
    INSERT INTO sections (
        template_id, section_order, type, name, section_id, height, y_position,
        title, subtitle, content, button_text, button_link,
        title_font_size, subtitle_font_size, content_font_size,
        title_font_weight, subtitle_font_weight, content_font_weight,
        button_font_size, button_font_weight, nav_font_size, nav_font_weight,
        title_color, subtitle_color, content_color, bg_color, text_color,
        accent_color, button_bg_color, button_text_color,
        padding, text_align, card_width, card_height, card_spacing, cards_per_row,
        background_image, section_image, use_bg_image, css_data, interactive_data, layout_data
    ) VALUES (
        template_id_var,
        6,
        8,
        '',
        '',
        234,
        1289,
        '',
        '',
        'Ready to deploy? Start building with a free account. Speak to an expert for your Pro or Enterprise needs. Explore Vercel Enterprise with an interactive product tour, trial, or a personalized demo.',
        'Start Deploying',
        'https://vercel.com/new',
        42,
        30,
        24,
        700,
        400,
        500,
        14,
        500,
        15,
        500,
        '0.00,0.00,0.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.40,0.40,0.40,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.09,0.09,0.09,1.00',
        '1.00,1.00,1.00,1.00',
        180,
        1,
        300,
        250,
        60,
        3,
        '',
        '',
        FALSE,
        '{"button": {"borderRadius": "100px", "borderWidth": "0px", "borderColor": "rgb(255, 255, 255)", "boxShadow": "none", "padding": "0px 10px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        NULL,
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat", "backgroundSize": "auto", "backgroundImage": "none"}, "position": {"position": "static", "top": "auto", "left": "auto", "right": "auto", "bottom": "auto", "zIndex": "auto"}, "typography": {"fontFamily": "Geist, Arial, \"Apple Color Emoji\", \"Segoe UI Emoji\", \"Segoe UI Symbol\""}}'
    );


    -- Section 8: Products
    -- CSS Data: {"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(102, 102, 102)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"b...
    -- Cards: 12 items
    INSERT INTO sections (
        template_id, section_order, type, name, section_id, height, y_position,
        title, subtitle, content, button_text, button_link,
        title_font_size, subtitle_font_size, content_font_size,
        title_font_weight, subtitle_font_weight, content_font_weight,
        button_font_size, button_font_weight, nav_font_size, nav_font_weight,
        title_color, subtitle_color, content_color, bg_color, text_color,
        accent_color, button_bg_color, button_text_color,
        padding, text_align, card_width, card_height, card_spacing, cards_per_row,
        background_image, section_image, use_bg_image, css_data, interactive_data, layout_data
    ) VALUES (
        template_id_var,
        7,
        3,
        'Products',
        'products',
        614,
        1613,
        'Products',
        'Company',
        'All systems normal.',
        'AI',
        'https://vercel.com/ai',
        14,
        2,
        14,
        500,
        400,
        400,
        14,
        400,
        15,
        500,
        '0.09,0.09,0.09,1.00',
        '0.09,0.09,0.09,1.00',
        '0.00,0.44,0.95,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.40,0.40,0.40,1.00',
        120,
        1,
        800,
        1000,
        40,
        3,
        '',
        '',
        FALSE,
        '{"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(102, 102, 102)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        '{"cards": [{"title": "AI", "description": "All systems normal.", "link": "https://vercel.com/ai", "button_text": "AI", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(102, 102, 102)", "title_font_size": 14, "title_font_weight": 400}, {"title": "Enterprise", "description": "", "link": "https://vercel.com/enterprise", "button_text": "Enterprise", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(102, 102, 102)", "title_font_size": 14, "title_font_weight": 400}, {"title": "Fluid Compute", "description": "", "link": "https://vercel.com/fluid", "button_text": "Fluid Compute", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(102, 102, 102)", "title_font_size": 14, "title_font_weight": 400}, {"title": "Next.js", "description": "", "link": "https://vercel.com/solutions/nextjs", "button_text": "Next.js", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(102, 102, 102)", "title_font_size": 14, "title_font_weight": 400}, {"title": "Observability", "description": "", "link": "https://vercel.com/products/observability", "button_text": "Observability", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(102, 102, 102)", "title_font_size": 14, "title_font_weight": 400}, {"title": "Previews", "description": "", "link": "https://vercel.com/products/previews", "button_text": "Previews", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(102, 102, 102)", "title_font_size": 14, "title_font_weight": 400}, {"title": "Rendering", "description": "", "link": "https://vercel.com/products/rendering", "button_text": "Rendering", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(102, 102, 102)", "title_font_size": 14, "title_font_weight": 400}, {"title": "Security", "description": "", "link": "https://vercel.com/security", "button_text": "Security", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(102, 102, 102)", "title_font_size": 14, "title_font_weight": 400}, {"title": "Turbo", "description": "", "link": "https://vercel.com/solutions/turborepo", "button_text": "Turbo", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(102, 102, 102)", "title_font_size": 14, "title_font_weight": 400}, {"title": "Domains", "description": "", "link": "https://vercel.com/domains", "button_text": "Domains", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(102, 102, 102)", "title_font_size": 14, "title_font_weight": 400}, {"title": "Sandbox", "description": "", "link": "https://vercel.com/sandbox", "button_text": "Sandbox", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(102, 102, 102)", "title_font_size": 14, "title_font_weight": 400}, {"title": "Workflow", "description": "", "link": "https://vercel.com/workflow", "button_text": "Workflow", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(102, 102, 102)", "title_font_size": 14, "title_font_weight": 400}]}',
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat", "backgroundSize": "auto", "backgroundImage": "none"}, "position": {"position": "static", "top": "auto", "left": "auto", "right": "auto", "bottom": "auto", "zIndex": "auto"}, "typography": {"fontFamily": "Geist, Arial, \"Apple Color Emoji\", \"Segoe UI Emoji\", \"Segoe UI Symbol\""}}'
    );

END $$;









COMMIT;


-- Template import complete!
-- Template name: vercel_gradients_test
-- Total sections: 8
--
-- To verify the import:
-- SELECT * FROM templates WHERE template_name = 'vercel_gradients_test';
-- SELECT COUNT(*) FROM sections WHERE template_id = (SELECT id FROM templates WHERE template_name = 'vercel_gradients_test');

-- Update sections with BYTEA image data


UPDATE sections
SET section_image_data = E'\\x3c73766720786d6c6e733d22687474703a2f2f7777772e77332e6f72672f323030302f737667222077696474683d2232363222206865696768743d223532222066696c6c3d226e6f6e65222076696577426f783d2230203020323632203532223e3c706174682066696c6c3d22626c61636b2220643d224d35392e3739393820353248304c32392e3930303420304c35392e373939382035325a4d3132372e3632342031332e35343838433133302e3838362031332e35343838203133332e3832322031342e32353836203133362e3433322031352e36373837433133392e3034312031372e303939203134312e3131352031392e32303737203134322e3635332032322e30303339433134342e3139312032342e38303031203134342e3938342032382e32313739203134352e30332033322e323536385633342e33323033483131382e363736433131382e3836322033372e32343936203131392e3732352033392e35353735203132312e3236332034312e32343431433132322e3834372034322e38383634203132342e3936382034332e373037203132372e3632342034332e373037433132392e3330322034332e373037203133302e38342034332e32363337203133322e3233382034322e333736433133332e3633362034312e34383834203133342e3638352034302e32393031203133352e3338342033382e373831324c3134342e3534312033392e34343633433134332e3432332034322e373735203134312e3332362034352e34333833203133382e32352034372e34333535433133352e3137342034392e34333238203133312e3633322035302e34333136203132372e3632342035302e34333136433132332e3934322035302e34333136203132302e3732372034392e36373639203131372e3937382034382e313638433131352e3232382034362e36353839203131332e3038342034342e35303632203131312e3534362034312e3731433131302e3030382033382e39313338203130392e3233392033352e363734203130392e3233392033312e39393032433130392e3233392032382e33303633203131302e3030382032352e30363537203131312e3534362032322e32363935433131332e3038342031392e34373335203131352e3232382031372e33323035203131372e3937382031352e38313135433132302e3732372031342e33303236203132332e3934332031332e35343838203132372e3632342031332e353438385a4d3139302e3137322031332e35343838433139332e3135342031332e35343838203139352e3838312031342e31303334203139382e3335312031352e32313239433230302e3836372031362e32373831203230322e3931382031372e38303933203230342e3530332031392e38303636433230362e3038372032312e38303338203230372e3034332032342e31353631203230372e3336392032362e383633334c3139382e3134322032372e33333031433139372e3736392032352e31393937203139362e3833362032332e35333533203139352e3334352032322e33333639433139332e392032312e30393432203139322e3137362032302e34373237203139302e3137322032302e34373237433138372e3238332032302e34373237203138352e3034352032312e34373135203138332e3436312032332e34363838433138312e3837372032352e343636203138312e3038342032382e33303636203138312e3038342033312e39393032433138312e3038342033352e36373339203138312e3837372033382e35313435203138332e3436312034302e35313137433138352e3034352034322e353039203138372e3238332034332e35303738203139302e3137322034332e35303738433139322e3236392034332e35303738203139342e3036332034322e38383633203139352e3535352034312e36343336433139372e3034362034302e33353634203139372e3935352033382e35333638203139382e3238312033362e313834364c3230372e3537382033362e353834433230372e3235322033392e33383031203230362e3239362034312e38323132203230342e3731322034332e39303732433230332e3132372034352e39393332203230312e3037372034372e36313336203139382e3536312034382e37363736433139362e3034342034392e38373731203139332e3234382035302e34333136203139302e3137322035302e34333136433138362e34392035302e34333136203138332e3237352034392e363737203138302e3532352034382e313638433137372e3737362034362e36353839203137352e3633322034342e35303632203137342e3039342034312e3731433137322e3535362033382e39313338203137312e3738372033352e363734203137312e3738372033312e39393032433137312e3738372032382e33303633203137322e3535362032352e30363537203137342e3039342032322e32363935433137352e3633322031392e34373334203137372e3737362031372e33323035203138302e3532352031352e38313135433138332e3237352031342e33303236203138362e34392031332e35343838203139302e3137322031332e353438385a4d3232382e3832352031332e35343838433233322e3038372031332e35343838203233352e3032342031342e32353834203233372e3633342031352e36373837433234302e3234342031372e303939203234322e3331382031392e32303737203234332e3835352032322e30303339433234352e3339332032342e38303031203234362e3138362032382e323138203234362e3233322033322e323536385633342e33323033483231392e383738433232302e3036342033372e32343935203232302e3932362033392e35353736203232322e3436342034312e32343431433232342e3034382034322e38383633203232362e3136392034332e37303639203232382e3832352034332e373037433233302e3530332034332e373037203233322e3034312034332e32363337203233332e3433392034322e333736433233342e3833372034312e34383834203233352e3838362034302e32393031203233362e3538352033382e373831324c3234352e3734332033392e34343633433234342e3632352034322e37373531203234322e3532372034352e34333833203233392e3435312034372e34333535433233362e3337352034392e34333238203233322e3833332035302e34333136203232382e3832352035302e34333136433232352e3134342035302e34333136203232312e3932382034392e363737203231392e3137392034382e313638433231362e3432392034362e36353839203231342e3238352034342e35303631203231322e3734372034312e3731433231312e3230392033382e39313339203231302e34342033352e36373339203231302e34342033312e39393032433231302e34342032382e33303633203231312e3230392032352e30363537203231322e3734372032322e32363935433231342e3238352031392e34373334203231362e3432392031372e33323036203231392e3137392031352e38313135433232312e3932382031342e33303236203232352e3134342031332e35343839203232382e3832352031332e353438385a4d38362e383939342033362e363932344c3130342e31333720322e3336333238483131342e3934354c38392e3935372034392e363332384838332e383432384c35382e3835343520322e33363332384836392e363633314c38362e383939342033362e363932345a4d3135382e3532312032312e31333737433135392e3131312031392e32313531203135392e3933332031372e37323136203136302e3938352031362e36353832433136322e3531322031352e31313633203136342e36342031342e33343537203136372e3336392031342e33343537483137302e3736395632312e36313433483136372e33433136352e3335372032312e36313433203136332e3736312032312e38373836203136322e3531322032322e34303732433136312e3330392032322e39333539203136302e3338342032332e37373336203135392e3733362032342e39313839433135392e3133352032362e30363433203135382e3833352032372e35313833203135382e3833352032392e323830335634392e36333238483134392e3935335631342e33343537483135382e3237394c3135382e3532312032312e313337375a4d3236302e3234382034392e36333238483235312e3356322e3336333238483236302e3234385634392e363332385a4d3132372e3632342032302e32373235433132352e3135342032302e32373235203132332e31352032312e30303531203132312e3631322032322e34363937433132302e3037342032332e39333434203131392e3131392032352e39393831203131382e3734362032382e36363131483133352e383033433133352e3437372032352e37373635203133342e3536382032332e36363834203133332e3037372032322e33333639433133312e3538362032302e393631203132392e3736382032302e32373235203132372e3632342032302e323732355a4d3232382e3832352032302e32373235433232362e3335352032302e32373236203232342e3335312032312e30303531203232322e3831332032322e34363937433232312e3237362032332e39333434203232302e33322032352e39393832203231392e3934372032382e36363131483233372e303035433233362e3637392032352e37373634203233352e3736392032332e36363834203233342e3237382032322e33333639433233322e3738372032302e393631203233302e3936392032302e32373235203232382e3832352032302e323732355a22207374796c653d2266696c6c3a626c61636b3b66696c6c2d6f7061636974793a313b222f3e3c2f7376673e'
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'vercel_gradients_test')
  AND section_order = 0;
