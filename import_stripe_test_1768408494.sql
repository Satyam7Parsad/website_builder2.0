-- Import Scraped Template: stripe_test_1768408494
-- Generated: 2026-01-14 22:07:24
-- Source: https://www.stripe.com
-- Sections: 58
--
-- Run this script to import the template into PostgreSQL:
-- psql -d website_builder < stripe_test_1768408494.sql
--


BEGIN;

-- Insert the template
INSERT INTO templates (template_name, description, project_name, created_date)
VALUES (
    'stripe_test_1768408494',
    'Imported from https://www.stripe.com',
    'Stripe Test 1768408494',
    '2026-01-14 22:07:24'
);


-- Get the template ID
DO $$
DECLARE
    template_id_var integer;
BEGIN
    SELECT id INTO template_id_var FROM templates WHERE template_name = 'stripe_test_1768408494';


    -- Section 1: Stripe logo
    -- CSS Data: {"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(0, 0, 238)", "boxShadow": "none", "padding": "4px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"borde...
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
        3,
        'Stripe logo',
        'stripe-logo',
        901,
        0,
        'Stripe logo',
        'Money Management',
        'Online payments In-person payments Fraud prevention',
        'Stripe logo',
        'https://stripe.com/in',
        32,
        20,
        16,
        700,
        400,
        300,
        32,
        700,
        15,
        500,
        '0.26,0.33,0.40,1.00',
        '0.26,0.33,0.40,1.00',
        '0.04,0.15,0.25,1.00',
        '0.00,0.00,0.00,0.00',
        '1.00,1.00,1.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.00,0.00,0.93,1.00',
        40,
        1,
        800,
        1000,
        40,
        3,
        '',
        'scraped_images/stripe_test_1768408494/img_8.jpg',
        FALSE,
        '{"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(0, 0, 238)", "boxShadow": "none", "padding": "4px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "0px none rgb(255, 255, 255)", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "24px", "letterSpacing": "0.2px"}}',
        '{"cards": [{"title": "Stripe logo", "description": "Online payments", "link": "https://stripe.com/in", "button_text": "Stripe logo", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(0, 0, 238)", "title_font_size": 32, "title_font_weight": 700}, {"title": "Products", "description": "In-person payments", "link": "", "button_text": "Products", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(255, 255, 255)", "title_font_size": 15, "title_font_weight": 500}, {"title": "Solutions", "description": "Fraud prevention", "link": "", "button_text": "Solutions", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(255, 255, 255)", "title_font_size": 15, "title_font_weight": 500}, {"title": "Developers", "description": "Acceptance optimisations", "link": "", "button_text": "Developers", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(255, 255, 255)", "title_font_size": 15, "title_font_weight": 500}, {"title": "Resources", "description": "Payments for platforms", "link": "", "button_text": "Resources", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(255, 255, 255)", "title_font_size": 15, "title_font_weight": 500}, {"title": "Pricing", "description": "Send money to third parties", "link": "https://stripe.com/in/pricing", "button_text": "Pricing", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(255, 255, 255)", "title_font_size": 15, "title_font_weight": 500}, {"title": "Support", "description": "Subscription management", "link": "https://support.stripe.com/", "button_text": "Support", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(255, 255, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "Sign in", "description": "Sales tax & VAT automation", "link": "https://dashboard.stripe.com/login", "button_text": "Sign in", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(255, 255, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "Contact sales", "description": "Accounting automation", "link": "https://stripe.com/in/contact/sales", "button_text": "Contact sales", "bg_color": "rgb(255, 255, 255)", "text_color": "rgb(255, 255, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "Open mobile navigation", "description": "Custom reports", "link": "https://stripe.com/in#", "button_text": "Open mobile navigation", "bg_color": "rgba(255, 255, 255, 0.2)", "text_color": "rgb(255, 255, 255)", "title_font_size": 16, "title_font_weight": 300}, {"title": "Stripe logo", "description": "Data sync", "link": "https://stripe.com/in", "button_text": "Stripe logo", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(0, 0, 238)", "title_font_size": 16, "title_font_weight": 300}, {"title": "Back", "description": "Access to 100+ globally", "link": "", "button_text": "Back", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}]}',
        '{"padding": {"top": "0px", "right": "0px", "bottom": "0px", "left": "0px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "normal"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 2: Money Management
    -- CSS Data: {"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(10, 37, 64)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"borde...
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
        3,
        'Money Management',
        'money-management',
        657,
        116,
        'Money Management',
        'By use case',
        'Online payments In-person payments Fraud prevention',
        'Enterprises',
        'https://stripe.com/in/enterprise',
        13,
        1,
        14,
        425,
        400,
        300,
        14,
        300,
        15,
        500,
        '0.04,0.15,0.25,1.00',
        '0.04,0.15,0.25,1.00',
        '0.04,0.15,0.25,1.00',
        '0.00,0.00,0.00,0.00',
        '0.26,0.33,0.40,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.04,0.15,0.25,1.00',
        40,
        1,
        800,
        1000,
        40,
        3,
        '',
        '',
        FALSE,
        '{"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(10, 37, 64)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "0px none rgb(66, 84, 102)", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        '{"cards": [{"title": "Enterprises", "description": "Online payments", "link": "https://stripe.com/in/enterprise", "button_text": "Enterprises", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 14, "title_font_weight": 300}, {"title": "Startups", "description": "In-person payments", "link": "https://stripe.com/in/startups", "button_text": "Startups", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 14, "title_font_weight": 300}, {"title": "Agentic commerce", "description": "Fraud prevention", "link": "https://stripe.com/in/use-cases/agentic-commerce", "button_text": "Agentic commerce", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 14, "title_font_weight": 300}, {"title": "Crypto", "description": "Acceptance optimisations", "link": "https://stripe.com/in/use-cases/crypto", "button_text": "Crypto", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 14, "title_font_weight": 300}, {"title": "E-commerce", "description": "Payments for platforms", "link": "https://stripe.com/in/use-cases/ecommerce", "button_text": "E-commerce", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 14, "title_font_weight": 300}, {"title": "Embedded finance", "description": "Send money to third parties", "link": "https://stripe.com/in/use-cases/embedded-finance", "button_text": "Embedded finance", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 14, "title_font_weight": 300}, {"title": "Finance automation", "description": "Subscription management", "link": "https://stripe.com/in/use-cases/finance-automation", "button_text": "Finance automation", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 14, "title_font_weight": 300}, {"title": "Global businesses", "description": "Sales tax & VAT automation", "link": "https://stripe.com/in/use-cases/global-businesses", "button_text": "Global businesses", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 14, "title_font_weight": 300}, {"title": "In-app payments", "description": "Accounting automation", "link": "https://stripe.com/in/use-cases/in-app-payments", "button_text": "In-app payments", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 14, "title_font_weight": 300}, {"title": "Marketplaces", "description": "Custom reports", "link": "https://stripe.com/in/use-cases/marketplaces", "button_text": "Marketplaces", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 14, "title_font_weight": 300}, {"title": "Platforms", "description": "Data sync", "link": "https://stripe.com/in/use-cases/platforms", "button_text": "Platforms", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 14, "title_font_weight": 300}, {"title": "SaaS", "description": "Access to 100+ globally", "link": "https://stripe.com/in/use-cases/saas", "button_text": "SaaS", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 14, "title_font_weight": 300}]}',
        '{"padding": {"top": "0px", "right": "0px", "bottom": "0px", "left": "0px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "normal"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 3: Money Management
    -- CSS Data: {"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(10, 37, 64)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"borde...
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
        8,
        'Money Management',
        'money-management',
        110,
        246,
        'Money Management',
        '',
        'Acceptance optimisations Start-up incorporation Carbon removal',
        'Crypto',
        'https://stripe.com/in/use-cases/crypto',
        13,
        1,
        14,
        425,
        400,
        300,
        14,
        300,
        15,
        500,
        '0.04,0.15,0.25,1.00',
        '0.04,0.15,0.25,1.00',
        '0.04,0.15,0.25,1.00',
        '0.00,0.00,0.00,0.00',
        '0.26,0.33,0.40,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.04,0.15,0.25,1.00',
        40,
        1,
        300,
        250,
        20,
        3,
        '',
        '',
        FALSE,
        '{"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(10, 37, 64)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "0px none rgb(66, 84, 102)", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        '{"cards": [{"title": "Crypto", "description": "Acceptance optimisations", "link": "https://stripe.com/in/use-cases/crypto", "button_text": "Crypto", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 14, "title_font_weight": 300}, {"title": "E-commerce", "description": "Start-up incorporation", "link": "https://stripe.com/in/use-cases/ecommerce", "button_text": "E-commerce", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 14, "title_font_weight": 300}, {"title": "Embedded finance", "description": "Carbon removal", "link": "https://stripe.com/in/use-cases/embedded-finance", "button_text": "Embedded finance", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 14, "title_font_weight": 300}, {"title": "In-app payments", "description": "", "link": "https://stripe.com/in/use-cases/in-app-payments", "button_text": "In-app payments", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 14, "title_font_weight": 300}, {"title": "Marketplaces", "description": "", "link": "https://stripe.com/in/use-cases/marketplaces", "button_text": "Marketplaces", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 14, "title_font_weight": 300}, {"title": "Platforms", "description": "", "link": "https://stripe.com/in/use-cases/platforms", "button_text": "Platforms", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 14, "title_font_weight": 300}, {"title": "App integrations", "description": "", "link": "https://marketplace.stripe.com/", "button_text": "App integrations", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 14, "title_font_weight": 300}, {"title": "Code samples", "description": "", "link": "https://github.com/stripe-samples", "button_text": "Code samples", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 14, "title_font_weight": 300}, {"title": "Stripe Apps", "description": "", "link": "https://stripe.com/in/apps", "button_text": "Stripe Apps", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 14, "title_font_weight": 300}, {"title": "Set up in-person payments", "description": "", "link": "https://docs.stripe.com/terminal", "button_text": "Set up in-person payments", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 14, "title_font_weight": 300}, {"title": "Build a platform or marketplace", "description": "", "link": "https://docs.stripe.com/connect", "button_text": "Build a platform or marketplace", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 14, "title_font_weight": 300}, {"title": "Manage subscriptions", "description": "", "link": "https://docs.stripe.com/billing", "button_text": "Manage subscriptions", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 14, "title_font_weight": 300}]}',
        '{"padding": {"top": "0px", "right": "0px", "bottom": "0px", "left": "0px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "normal"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 4: Revenue and Finance Automation
    -- CSS Data: {"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(10, 37, 64)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"borde...
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
        3,
        8,
        'Revenue and Finance Automation',
        'revenue-and-finance-automation',
        76,
        373,
        'Revenue and Finance Automation',
        '',
        'Payments for platforms Send money to third parties',
        'API status',
        'https://status.stripe.com/',
        13,
        1,
        14,
        425,
        400,
        300,
        14,
        300,
        15,
        500,
        '0.04,0.15,0.25,1.00',
        '0.04,0.15,0.25,1.00',
        '0.04,0.15,0.25,1.00',
        '0.00,0.00,0.00,0.00',
        '0.26,0.33,0.40,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.04,0.15,0.25,1.00',
        40,
        1,
        300,
        250,
        20,
        3,
        '',
        '',
        FALSE,
        '{"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(10, 37, 64)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "0px none rgb(66, 84, 102)", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        NULL,
        '{"padding": {"top": "0px", "right": "0px", "bottom": "0px", "left": "0px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "normal"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 5: 
    -- CSS Data: {"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(10, 37, 64)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"borde...
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
        4,
        8,
        '',
        '',
        127,
        498,
        '',
        '',
        'Subscription management Accounting automation Custom reports',
        'Creator economy',
        'https://stripe.com/in/use-cases/creator-economy',
        42,
        30,
        14,
        700,
        400,
        300,
        14,
        300,
        15,
        500,
        '0.26,0.33,0.40,1.00',
        '0.26,0.33,0.40,1.00',
        '0.04,0.15,0.25,1.00',
        '0.00,0.00,0.00,0.00',
        '0.26,0.33,0.40,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.04,0.15,0.25,1.00',
        60,
        1,
        300,
        250,
        20,
        3,
        '',
        '',
        FALSE,
        '{"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(10, 37, 64)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "0px none rgb(66, 84, 102)", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        '{"cards": [{"title": "Creator economy", "description": "Subscription management", "link": "https://stripe.com/in/use-cases/creator-economy", "button_text": "Creator economy", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 14, "title_font_weight": 300}, {"title": "Hospitality, travel and leisure", "description": "Accounting automation", "link": "https://stripe.com/industries/travel", "button_text": "Hospitality, travel and leisure", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 14, "title_font_weight": 300}, {"title": "Insurance", "description": "Custom reports", "link": "https://stripe.com/industries/insurance", "button_text": "Insurance", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 14, "title_font_weight": 300}, {"title": "Non-profits", "description": "Data sync", "link": "https://stripe.com/industries/nonprofits", "button_text": "Non-profits", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 14, "title_font_weight": 300}, {"title": "Retail", "description": "", "link": "https://stripe.com/industries/retail", "button_text": "Retail", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 14, "title_font_weight": 300}]}',
        '{"padding": {"top": "0px", "right": "0px", "bottom": "0px", "left": "0px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "normal"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 6: 
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
        5,
        3,
        '',
        '',
        250,
        901,
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
        '0.26,0.33,0.40,1.00',
        '0.26,0.33,0.40,1.00',
        '0.26,0.33,0.40,1.00',
        '0.00,0.00,0.00,0.00',
        '0.26,0.33,0.40,1.00',
        '0.8,0.4,0.5,1.0',
        '0.78,0.39,0.49,1.00',
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
        '{"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(0,0,0)", "boxShadow": "none", "padding": "10px 20px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "0px none rgb(66, 84, 102)", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        NULL,
        '{"padding": {"top": "0px", "right": "0px", "bottom": "0px", "left": "0px"}, "flexbox": {"display": "grid", "flexDirection": "row", "justifyContent": "normal", "alignItems": "center", "gap": "60px normal"}, "grid": {"gridTemplateColumns": "270px 270px 270px 270px", "gridTemplateRows": "40px 40px"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 7: Modular solutions
    -- CSS Data: {"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(99, 91, 255)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"bor...
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
        6,
        3,
        'Modular solutions',
        'modular-solutions',
        800,
        1151,
        'Modular solutions',
        'Payments                          Payments',
        'Reduce costs, grow revenue, and run your business more efficiently on a fully integrated, AI-powered platform. Use Stripe to handle all of your payments-related needs, manage revenue operations, and launch (or invent) new business models. Increase authorisation rates, offer local payment methods to boost conversion, and reduce fraud using AI. Manage flat rate, usage-based, and hybrid pricing models, minimise churn, and automate finance operations.',
        'Atlas',
        'https://stripe.com/in/atlas',
        18,
        6,
        18,
        500,
        400,
        300,
        16,
        425,
        15,
        500,
        '0.39,0.36,1.00,1.00',
        '0.39,0.36,1.00,1.00',
        '0.26,0.33,0.40,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.39,0.36,1.00,1.00',
        20,
        1,
        800,
        1000,
        40,
        3,
        '',
        'scraped_images/stripe_test_1768408494/img_8.jpg',
        FALSE,
        '{"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(99, 91, 255)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        '{"cards": [{"title": "Atlas", "description": "Reduce costs, grow revenue, and run your business more efficiently on a fully integrated, AI-powered platform. Use Stripe to handle all of your payments-related needs, manage revenue operations, and launch (or invent) new business models.", "link": "https://stripe.com/in/atlas", "button_text": "Atlas", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}, {"title": "Billing", "description": "Increase authorisation rates, offer local payment methods to boost conversion, and reduce fraud using AI.", "link": "https://stripe.com/in/billing", "button_text": "Billing", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}, {"title": "Capital", "description": "Manage flat rate, usage-based, and hybrid pricing models, minimise churn, and automate finance operations.", "link": "https://stripe.com/in/capital", "button_text": "Capital", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}, {"title": "Checkout", "description": "Integrate payments into your platform or marketplace for end-to-end payments experiences.", "link": "https://stripe.com/in/payments/checkout", "button_text": "Checkout", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}, {"title": "Climate", "description": "Launch, manage, and scale a commercial card programme without any setup fees.", "link": "https://stripe.com/in/climate", "button_text": "Climate", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}, {"title": "Connect", "description": "", "link": "https://stripe.com/in/connect", "button_text": "Connect", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}, {"title": "Elements", "description": "", "link": "https://stripe.com/in/payments/elements", "button_text": "Elements", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}, {"title": "Identity", "description": "", "link": "https://stripe.com/in/identity", "button_text": "Identity", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}, {"title": "Invoicing", "description": "", "link": "https://stripe.com/invoicing", "button_text": "Invoicing", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}, {"title": "Issuing", "description": "", "link": "https://stripe.com/in/issuing", "button_text": "Issuing", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}, {"title": "Payments", "description": "", "link": "https://stripe.com/in/payments", "button_text": "Payments", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}, {"title": "Radar", "description": "", "link": "https://stripe.com/in/radar", "button_text": "Radar", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}]}',
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 8: Modular solutions
    -- CSS Data: {"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(99, 91, 255)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"bor...
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
        'Modular solutions',
        'modular-solutions',
        504,
        1279,
        'Modular solutions',
        '',
        'Reduce costs, grow revenue, and run your business more efficiently on a fully integrated, AI-powered platform. Use Stripe to handle all of your payments-related needs, manage revenue operations, and launch (or invent) new business models.',
        'Atlas',
        'https://stripe.com/in/atlas',
        18,
        6,
        18,
        500,
        400,
        300,
        16,
        425,
        15,
        500,
        '0.39,0.36,1.00,1.00',
        '0.39,0.36,1.00,1.00',
        '0.26,0.33,0.40,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.39,0.36,1.00,1.00',
        40,
        1,
        800,
        1000,
        40,
        3,
        '',
        'scraped_images/stripe_test_1768408494/img_8.jpg',
        FALSE,
        '{"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(99, 91, 255)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        '{"cards": [{"title": "Atlas", "description": "Reduce costs, grow revenue, and run your business more efficiently on a fully integrated, AI-powered platform. Use Stripe to handle all of your payments-related needs, manage revenue operations, and launch (or invent) new business models.", "link": "https://stripe.com/in/atlas", "button_text": "Atlas", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}, {"title": "Billing", "description": "", "link": "https://stripe.com/in/billing", "button_text": "Billing", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}, {"title": "Capital", "description": "", "link": "https://stripe.com/in/capital", "button_text": "Capital", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}, {"title": "Checkout", "description": "", "link": "https://stripe.com/in/payments/checkout", "button_text": "Checkout", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}, {"title": "Climate", "description": "", "link": "https://stripe.com/in/climate", "button_text": "Climate", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}, {"title": "Connect", "description": "", "link": "https://stripe.com/in/connect", "button_text": "Connect", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}, {"title": "Elements", "description": "", "link": "https://stripe.com/in/payments/elements", "button_text": "Elements", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}, {"title": "Identity", "description": "", "link": "https://stripe.com/in/identity", "button_text": "Identity", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}, {"title": "Invoicing", "description": "", "link": "https://stripe.com/invoicing", "button_text": "Invoicing", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}, {"title": "Issuing", "description": "", "link": "https://stripe.com/in/issuing", "button_text": "Issuing", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}, {"title": "Payments", "description": "", "link": "https://stripe.com/in/payments", "button_text": "Payments", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}, {"title": "Radar", "description": "", "link": "https://stripe.com/in/radar", "button_text": "Radar", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}]}',
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 9: Payments                          Payments
    -- CSS Data: {"button": {"borderRadius": "16.5px", "borderWidth": "0px", "borderColor": "rgb(255, 255, 255)", "boxShadow": "none", "padding": "3px 12px 6px 16px", "textTransform": "none", "letterSpacing": "0.2px"}...
    -- Cards: 4 items
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
        8,
        3,
        'Payments                          Payments',
        'payments-payments',
        900,
        1879,
        'Payments                          Payments',
        'See also',
        'Increase authorisation rates, offer local payment methods to boost conversion, and reduce fraud using AI.',
        'Start with Payments',
        'https://stripe.com/in/payments',
        18,
        6,
        18,
        500,
        400,
        300,
        15,
        425,
        15,
        500,
        '0.39,0.36,1.00,1.00',
        '0.39,0.36,1.00,1.00',
        '0.26,0.33,0.40,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.39,0.36,1.00,1.00',
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
        '{"button": {"borderRadius": "16.5px", "borderWidth": "0px", "borderColor": "rgb(255, 255, 255)", "boxShadow": "none", "padding": "3px 12px 6px 16px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        '{"cards": [{"title": "Start with Payments", "description": "Increase authorisation rates, offer local payment methods to boost conversion, and reduce fraud using AI.", "link": "https://stripe.com/in/payments", "button_text": "Start with Payments", "bg_color": "rgb(99, 91, 255)", "text_color": "rgb(255, 255, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "Tax", "description": "", "link": "https://stripe.com/in/tax", "button_text": "Tax", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "Radar", "description": "", "link": "https://stripe.com/in/radar", "button_text": "Radar", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "Terminal", "description": "", "link": "https://stripe.com/in/terminal", "button_text": "Terminal", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 15, "title_font_weight": 425}]}',
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 10: Payments                          Payments
    -- CSS Data: {"button": {"borderRadius": "16.5px", "borderWidth": "0px", "borderColor": "rgb(255, 255, 255)", "boxShadow": "none", "padding": "3px 12px 6px 16px", "textTransform": "none", "letterSpacing": "0.2px"}...
    -- Cards: 4 items
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
        9,
        3,
        'Payments                          Payments',
        'payments-payments',
        477,
        2090,
        'Payments                          Payments',
        'See also',
        'Increase authorisation rates, offer local payment methods to boost conversion, and reduce fraud using AI.',
        'Start with Payments',
        'https://stripe.com/in/payments',
        18,
        6,
        18,
        500,
        400,
        300,
        15,
        425,
        15,
        500,
        '0.39,0.36,1.00,1.00',
        '0.39,0.36,1.00,1.00',
        '0.26,0.33,0.40,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.39,0.36,1.00,1.00',
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
        '{"button": {"borderRadius": "16.5px", "borderWidth": "0px", "borderColor": "rgb(255, 255, 255)", "boxShadow": "none", "padding": "3px 12px 6px 16px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        '{"cards": [{"title": "Start with Payments", "description": "Increase authorisation rates, offer local payment methods to boost conversion, and reduce fraud using AI.", "link": "https://stripe.com/in/payments", "button_text": "Start with Payments", "bg_color": "rgb(99, 91, 255)", "text_color": "rgb(255, 255, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "Tax", "description": "", "link": "https://stripe.com/in/tax", "button_text": "Tax", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "Radar", "description": "", "link": "https://stripe.com/in/radar", "button_text": "Radar", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "Terminal", "description": "", "link": "https://stripe.com/in/terminal", "button_text": "Terminal", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 15, "title_font_weight": 425}]}',
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 11: See also
    -- CSS Data: {"button": {"borderRadius": "16.5px", "borderWidth": "0px", "borderColor": "rgb(255, 255, 255)", "boxShadow": "none", "padding": "3px 12px 6px 16px", "textTransform": "none", "letterSpacing": "0.2px"}...
    -- Cards: 4 items
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
        10,
        8,
        'See also',
        'see-also',
        205,
        2362,
        'See also',
        '',
        '',
        'Start with Payments',
        'https://stripe.com/in/payments',
        15,
        3,
        16,
        425,
        400,
        400,
        15,
        425,
        15,
        500,
        '0.04,0.15,0.25,1.00',
        '0.04,0.15,0.25,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.39,0.36,1.00,1.00',
        '1.00,1.00,1.00,1.00',
        40,
        1,
        300,
        250,
        20,
        3,
        '',
        '',
        FALSE,
        '{"button": {"borderRadius": "16.5px", "borderWidth": "0px", "borderColor": "rgb(255, 255, 255)", "boxShadow": "none", "padding": "3px 12px 6px 16px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        '{"cards": [{"title": "Start with Payments", "description": "", "link": "https://stripe.com/in/payments", "button_text": "Start with Payments", "bg_color": "rgb(99, 91, 255)", "text_color": "rgb(255, 255, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "Tax", "description": "", "link": "https://stripe.com/in/tax", "button_text": "Tax", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "Radar", "description": "", "link": "https://stripe.com/in/radar", "button_text": "Radar", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "Terminal", "description": "", "link": "https://stripe.com/in/terminal", "button_text": "Terminal", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 15, "title_font_weight": 425}]}',
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 12: See also
    -- CSS Data: {"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(99, 91, 255)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"bord...
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
        11,
        8,
        'See also',
        'see-also',
        116,
        2451,
        'See also',
        '',
        '',
        'Tax',
        'https://stripe.com/in/tax',
        15,
        3,
        16,
        425,
        400,
        400,
        15,
        425,
        15,
        500,
        '0.04,0.15,0.25,1.00',
        '0.04,0.15,0.25,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.39,0.36,1.00,1.00',
        60,
        1,
        300,
        250,
        20,
        3,
        '',
        '',
        FALSE,
        '{"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(99, 91, 255)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        NULL,
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 13: Billing                          Billing
    -- CSS Data: {"button": {"borderRadius": "16.5px", "borderWidth": "0px", "borderColor": "rgb(255, 255, 255)", "boxShadow": "none", "padding": "3px 12px 6px 16px", "textTransform": "none", "letterSpacing": "0.2px"}...
    -- Cards: 4 items
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
        12,
        3,
        'Billing                          Billing',
        'billing-billing',
        900,
        2875,
        'Billing                          Billing',
        'See also',
        'Manage flat rate, usage-based, and hybrid pricing models, minimise churn, and automate finance operations.',
        'Start with Billing',
        'https://stripe.com/in/billing',
        18,
        6,
        18,
        500,
        400,
        300,
        15,
        425,
        15,
        500,
        '0.39,0.36,1.00,1.00',
        '0.39,0.36,1.00,1.00',
        '0.26,0.33,0.40,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.39,0.36,1.00,1.00',
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
        '{"button": {"borderRadius": "16.5px", "borderWidth": "0px", "borderColor": "rgb(255, 255, 255)", "boxShadow": "none", "padding": "3px 12px 6px 16px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        '{"cards": [{"title": "Start with Billing", "description": "Manage flat rate, usage-based, and hybrid pricing models, minimise churn, and automate finance operations.", "link": "https://stripe.com/in/billing", "button_text": "Start with Billing", "bg_color": "rgb(99, 91, 255)", "text_color": "rgb(255, 255, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "Invoicing", "description": "", "link": "https://stripe.com/invoicing", "button_text": "Invoicing", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "Usage-based billing", "description": "", "link": "https://stripe.com/in/billing/usage-based-billing", "button_text": "Usage-based billing", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "Stripe Sigma", "description": "", "link": "https://stripe.com/in/sigma", "button_text": "Stripe Sigma", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 15, "title_font_weight": 425}]}',
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 14: Billing                          Billing
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
        13,
        3,
        'Billing                          Billing',
        'billing-billing',
        92,
        3110,
        'Billing                          Billing',
        '',
        '',
        '',
        '',
        18,
        6,
        16,
        500,
        400,
        400,
        16,
        600,
        15,
        500,
        '0.39,0.36,1.00,1.00',
        '0.39,0.36,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.78,0.39,0.49,1.00',
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
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 15: See also
    -- CSS Data: {"button": {"borderRadius": "16.5px", "borderWidth": "0px", "borderColor": "rgb(255, 255, 255)", "boxShadow": "none", "padding": "3px 12px 6px 16px", "textTransform": "none", "letterSpacing": "0.2px"}...
    -- Cards: 4 items
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
        14,
        8,
        'See also',
        'see-also',
        205,
        3334,
        'See also',
        '',
        '',
        'Start with Billing',
        'https://stripe.com/in/billing',
        15,
        3,
        16,
        425,
        400,
        400,
        15,
        425,
        15,
        500,
        '0.04,0.15,0.25,1.00',
        '0.04,0.15,0.25,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.39,0.36,1.00,1.00',
        '1.00,1.00,1.00,1.00',
        40,
        1,
        300,
        250,
        20,
        3,
        '',
        '',
        FALSE,
        '{"button": {"borderRadius": "16.5px", "borderWidth": "0px", "borderColor": "rgb(255, 255, 255)", "boxShadow": "none", "padding": "3px 12px 6px 16px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        '{"cards": [{"title": "Start with Billing", "description": "", "link": "https://stripe.com/in/billing", "button_text": "Start with Billing", "bg_color": "rgb(99, 91, 255)", "text_color": "rgb(255, 255, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "Invoicing", "description": "", "link": "https://stripe.com/invoicing", "button_text": "Invoicing", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "Usage-based billing", "description": "", "link": "https://stripe.com/in/billing/usage-based-billing", "button_text": "Usage-based billing", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "Stripe Sigma", "description": "", "link": "https://stripe.com/in/sigma", "button_text": "Stripe Sigma", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 15, "title_font_weight": 425}]}',
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 16: See also
    -- CSS Data: {"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(99, 91, 255)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"bord...
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
        15,
        8,
        'See also',
        'see-also',
        116,
        3423,
        'See also',
        '',
        '',
        'Invoicing',
        'https://stripe.com/invoicing',
        15,
        3,
        16,
        425,
        400,
        400,
        15,
        425,
        15,
        500,
        '0.04,0.15,0.25,1.00',
        '0.04,0.15,0.25,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.39,0.36,1.00,1.00',
        60,
        1,
        300,
        250,
        20,
        3,
        '',
        '',
        FALSE,
        '{"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(99, 91, 255)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        NULL,
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 17: Connect                          Connect
    -- CSS Data: {"button": {"borderRadius": "16.5px", "borderWidth": "0px", "borderColor": "rgb(255, 255, 255)", "boxShadow": "none", "padding": "3px 12px 6px 16px", "textTransform": "none", "letterSpacing": "0.2px"}...
    -- Cards: 4 items
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
        16,
        3,
        'Connect                          Connect',
        'connect-connect',
        900,
        3871,
        'Connect                          Connect',
        'See also',
        'Integrate payments into your platform or marketplace for end-to-end payments experiences.',
        'Start with Connect',
        'https://stripe.com/in/connect',
        18,
        6,
        18,
        500,
        400,
        300,
        15,
        425,
        15,
        500,
        '0.39,0.36,1.00,1.00',
        '0.39,0.36,1.00,1.00',
        '0.26,0.33,0.40,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.39,0.36,1.00,1.00',
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
        '{"button": {"borderRadius": "16.5px", "borderWidth": "0px", "borderColor": "rgb(255, 255, 255)", "boxShadow": "none", "padding": "3px 12px 6px 16px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        '{"cards": [{"title": "Start with Connect", "description": "Integrate payments into your platform or marketplace for end-to-end payments experiences.", "link": "https://stripe.com/in/connect", "button_text": "Start with Connect", "bg_color": "rgb(99, 91, 255)", "text_color": "rgb(255, 255, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "Terminal", "description": "", "link": "https://stripe.com/in/terminal", "button_text": "Terminal", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "Instant Payouts", "description": "", "link": "https://stripe.com/in/connect/payouts", "button_text": "Instant Payouts", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "Payment Elements", "description": "", "link": "https://stripe.com/in/payments/elements", "button_text": "Payment Elements", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 15, "title_font_weight": 425}]}',
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 18: Connect                          Connect
    -- CSS Data: {"button": {"borderRadius": "16.5px", "borderWidth": "0px", "borderColor": "rgb(255, 255, 255)", "boxShadow": "none", "padding": "3px 12px 6px 16px", "textTransform": "none", "letterSpacing": "0.2px"}...
    -- Cards: 4 items
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
        17,
        3,
        'Connect                          Connect',
        'connect-connect',
        449,
        4096,
        'Connect                          Connect',
        'See also',
        'Integrate payments into your platform or marketplace for end-to-end payments experiences.',
        'Start with Connect',
        'https://stripe.com/in/connect',
        18,
        6,
        18,
        500,
        400,
        300,
        15,
        425,
        15,
        500,
        '0.39,0.36,1.00,1.00',
        '0.39,0.36,1.00,1.00',
        '0.26,0.33,0.40,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.39,0.36,1.00,1.00',
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
        '{"button": {"borderRadius": "16.5px", "borderWidth": "0px", "borderColor": "rgb(255, 255, 255)", "boxShadow": "none", "padding": "3px 12px 6px 16px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        '{"cards": [{"title": "Start with Connect", "description": "Integrate payments into your platform or marketplace for end-to-end payments experiences.", "link": "https://stripe.com/in/connect", "button_text": "Start with Connect", "bg_color": "rgb(99, 91, 255)", "text_color": "rgb(255, 255, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "Terminal", "description": "", "link": "https://stripe.com/in/terminal", "button_text": "Terminal", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "Instant Payouts", "description": "", "link": "https://stripe.com/in/connect/payouts", "button_text": "Instant Payouts", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "Payment Elements", "description": "", "link": "https://stripe.com/in/payments/elements", "button_text": "Payment Elements", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 15, "title_font_weight": 425}]}',
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 19: See also
    -- CSS Data: {"button": {"borderRadius": "16.5px", "borderWidth": "0px", "borderColor": "rgb(255, 255, 255)", "boxShadow": "none", "padding": "3px 12px 6px 16px", "textTransform": "none", "letterSpacing": "0.2px"}...
    -- Cards: 4 items
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
        18,
        8,
        'See also',
        'see-also',
        205,
        4340,
        'See also',
        '',
        '',
        'Start with Connect',
        'https://stripe.com/in/connect',
        15,
        3,
        16,
        425,
        400,
        400,
        15,
        425,
        15,
        500,
        '0.04,0.15,0.25,1.00',
        '0.04,0.15,0.25,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.39,0.36,1.00,1.00',
        '1.00,1.00,1.00,1.00',
        40,
        1,
        300,
        250,
        20,
        3,
        '',
        '',
        FALSE,
        '{"button": {"borderRadius": "16.5px", "borderWidth": "0px", "borderColor": "rgb(255, 255, 255)", "boxShadow": "none", "padding": "3px 12px 6px 16px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        '{"cards": [{"title": "Start with Connect", "description": "", "link": "https://stripe.com/in/connect", "button_text": "Start with Connect", "bg_color": "rgb(99, 91, 255)", "text_color": "rgb(255, 255, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "Terminal", "description": "", "link": "https://stripe.com/in/terminal", "button_text": "Terminal", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "Instant Payouts", "description": "", "link": "https://stripe.com/in/connect/payouts", "button_text": "Instant Payouts", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "Payment Elements", "description": "", "link": "https://stripe.com/in/payments/elements", "button_text": "Payment Elements", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 15, "title_font_weight": 425}]}',
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 20: See also
    -- CSS Data: {"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(99, 91, 255)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"bord...
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
        19,
        8,
        'See also',
        'see-also',
        116,
        4429,
        'See also',
        '',
        '',
        'Terminal',
        'https://stripe.com/in/terminal',
        15,
        3,
        16,
        425,
        400,
        400,
        15,
        425,
        15,
        500,
        '0.04,0.15,0.25,1.00',
        '0.04,0.15,0.25,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.39,0.36,1.00,1.00',
        60,
        1,
        300,
        250,
        20,
        3,
        '',
        '',
        FALSE,
        '{"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(99, 91, 255)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        NULL,
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 21: Issuing                          Issuing
    -- CSS Data: {"button": {"borderRadius": "16.5px", "borderWidth": "0px", "borderColor": "rgb(255, 255, 255)", "boxShadow": "none", "padding": "3px 12px 6px 16px", "textTransform": "none", "letterSpacing": "0.2px"}...
    -- Cards: 4 items
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
        20,
        3,
        'Issuing                          Issuing',
        'issuing-issuing',
        449,
        4867,
        'Issuing                          Issuing',
        'See also',
        'Launch, manage, and scale a commercial card programme without any setup fees.',
        'Start with Issuing',
        'https://stripe.com/in/issuing',
        18,
        6,
        18,
        500,
        400,
        300,
        15,
        425,
        15,
        500,
        '0.39,0.36,1.00,1.00',
        '0.39,0.36,1.00,1.00',
        '0.26,0.33,0.40,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.39,0.36,1.00,1.00',
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
        '{"button": {"borderRadius": "16.5px", "borderWidth": "0px", "borderColor": "rgb(255, 255, 255)", "boxShadow": "none", "padding": "3px 12px 6px 16px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        '{"cards": [{"title": "Start with Issuing", "description": "Launch, manage, and scale a commercial card programme without any setup fees.", "link": "https://stripe.com/in/issuing", "button_text": "Start with Issuing", "bg_color": "rgb(99, 91, 255)", "text_color": "rgb(255, 255, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "Connect", "description": "", "link": "https://stripe.com/in/connect/platforms", "button_text": "Connect", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "Financial Accounts", "description": "", "link": "https://stripe.com/in/financial-accounts", "button_text": "Financial Accounts", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "Capital", "description": "", "link": "https://stripe.com/in/capital/platforms", "button_text": "Capital", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 15, "title_font_weight": 425}]}',
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 22: See also
    -- CSS Data: {"button": {"borderRadius": "16.5px", "borderWidth": "0px", "borderColor": "rgb(255, 255, 255)", "boxShadow": "none", "padding": "3px 12px 6px 16px", "textTransform": "none", "letterSpacing": "0.2px"}...
    -- Cards: 4 items
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
        21,
        8,
        'See also',
        'see-also',
        205,
        5111,
        'See also',
        '',
        '',
        'Start with Issuing',
        'https://stripe.com/in/issuing',
        15,
        3,
        16,
        425,
        400,
        400,
        15,
        425,
        15,
        500,
        '0.04,0.15,0.25,1.00',
        '0.04,0.15,0.25,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.39,0.36,1.00,1.00',
        '1.00,1.00,1.00,1.00',
        40,
        1,
        300,
        250,
        20,
        3,
        '',
        '',
        FALSE,
        '{"button": {"borderRadius": "16.5px", "borderWidth": "0px", "borderColor": "rgb(255, 255, 255)", "boxShadow": "none", "padding": "3px 12px 6px 16px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        '{"cards": [{"title": "Start with Issuing", "description": "", "link": "https://stripe.com/in/issuing", "button_text": "Start with Issuing", "bg_color": "rgb(99, 91, 255)", "text_color": "rgb(255, 255, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "Connect", "description": "", "link": "https://stripe.com/in/connect/platforms", "button_text": "Connect", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "Financial Accounts", "description": "", "link": "https://stripe.com/in/financial-accounts", "button_text": "Financial Accounts", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "Capital", "description": "", "link": "https://stripe.com/in/capital/platforms", "button_text": "Capital", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 15, "title_font_weight": 425}]}',
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 23: See also
    -- CSS Data: {"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(99, 91, 255)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"bord...
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
        22,
        8,
        'See also',
        'see-also',
        116,
        5200,
        'See also',
        '',
        '',
        'Connect',
        'https://stripe.com/in/connect/platforms',
        15,
        3,
        16,
        425,
        400,
        400,
        15,
        425,
        15,
        500,
        '0.04,0.15,0.25,1.00',
        '0.04,0.15,0.25,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.39,0.36,1.00,1.00',
        60,
        1,
        300,
        250,
        20,
        3,
        '',
        '',
        FALSE,
        '{"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(99, 91, 255)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        NULL,
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 24: Global scale
    -- CSS Data: {"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(0, 212, 255)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"bord...
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
        23,
        2,
        'Global scale',
        'global-scale',
        1024,
        5443,
        'Global scale',
        '500M+',
        '',
        'Stripe services',
        'https://status.stripe.com/',
        18,
        6,
        16,
        500,
        400,
        400,
        15,
        425,
        15,
        500,
        '0.00,0.83,1.00,1.00',
        '0.00,0.83,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.00,0.83,1.00,1.00',
        60,
        1,
        300,
        250,
        20,
        3,
        '',
        '',
        FALSE,
        '{"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(0, 212, 255)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        NULL,
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 25: Global scale
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
        24,
        2,
        'Global scale',
        'global-scale',
        312,
        5686,
        'Global scale',
        '',
        '',
        '',
        '',
        18,
        6,
        16,
        500,
        400,
        400,
        16,
        600,
        15,
        500,
        '0.00,0.83,1.00,1.00',
        '0.00,0.83,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.78,0.39,0.49,1.00',
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
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 26: 500M+
    -- CSS Data: {"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(0, 212, 255)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"bord...
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
        25,
        2,
        '500M+',
        '500m',
        88,
        6094,
        '500M+',
        '47+',
        '',
        'Stripe services',
        'https://status.stripe.com/',
        24,
        12,
        16,
        500,
        400,
        400,
        15,
        425,
        15,
        500,
        '1.00,1.00,1.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.00,0.83,1.00,1.00',
        60,
        1,
        300,
        250,
        20,
        3,
        '',
        '',
        FALSE,
        '{"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(0, 212, 255)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        NULL,
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 27: Support for any business type
    -- CSS Data: {"button": {"borderRadius": "14px", "borderWidth": "1px", "borderColor": "rgb(231, 236, 241)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"...
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
        26,
        3,
        'Support for any business type',
        'support-for-any-business-type',
        891,
        6310,
        'Support for any business type',
        'SaaS',
        '',
        '',
        '',
        38,
        26,
        16,
        500,
        400,
        400,
        13,
        400,
        15,
        500,
        '0.04,0.15,0.25,1.00',
        '0.04,0.15,0.25,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.00,0.00,0.00,1.00',
        60,
        1,
        800,
        1000,
        40,
        3,
        '',
        '',
        FALSE,
        '{"button": {"borderRadius": "14px", "borderWidth": "1px", "borderColor": "rgb(231, 236, 241)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        '{"cards": [{"title": "", "description": "", "link": "", "button_text": "", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(0, 0, 0)", "title_font_size": 13, "title_font_weight": 400}, {"title": "", "description": "", "link": "", "button_text": "", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(0, 0, 0)", "title_font_size": 13, "title_font_weight": 400}, {"title": "Slack logo", "description": "", "link": "https://stripe.com/in/customers/slack", "button_text": "Slack logo", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}, {"title": "Twilio logo", "description": "", "link": "https://stripe.com/in/customers/twilio", "button_text": "Twilio logo", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}, {"title": "Linear logo", "description": "", "link": "https://stripe.com/in/customers/linear", "button_text": "Linear logo", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}, {"title": "BloomNation logo", "description": "", "link": "https://stripe.com/in/customers/bloomnation", "button_text": "BloomNation logo", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}, {"title": "Instacart logo", "description": "", "link": "https://stripe.com/in/customers/instacart", "button_text": "Instacart logo", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}, {"title": "Deliveroo logo", "description": "", "link": "https://stripe.com/in/customers/deliveroo", "button_text": "Deliveroo logo", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}, {"title": "Karat logo", "description": "", "link": "https://stripe.com/in/customers/karat", "button_text": "Karat logo", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}, {"title": "Shopify logo", "description": "", "link": "https://stripe.com/in/customers/shopify", "button_text": "Shopify logo", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}, {"title": "Persona logo", "description": "", "link": "https://stripe.com/in/customers/persona", "button_text": "Persona logo", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}, {"title": "Dermalogica logo", "description": "", "link": "https://stripe.com/in/customers/dermalogica", "button_text": "Dermalogica logo", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}]}',
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 28: Support for any business type
    -- CSS Data: {"button": {"borderRadius": "14px", "borderWidth": "1px", "borderColor": "rgb(231, 236, 241)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"...
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
        27,
        8,
        'Support for any business type',
        'support-for-any-business-type',
        128,
        6438,
        'Support for any business type',
        '',
        '',
        '',
        '',
        38,
        26,
        16,
        500,
        400,
        400,
        13,
        400,
        15,
        500,
        '0.04,0.15,0.25,1.00',
        '0.04,0.15,0.25,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.00,0.00,0.00,1.00',
        60,
        1,
        300,
        250,
        20,
        3,
        '',
        '',
        FALSE,
        '{"button": {"borderRadius": "14px", "borderWidth": "1px", "borderColor": "rgb(231, 236, 241)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        NULL,
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 29: AI
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
        28,
        4,
        'AI',
        'ai',
        204,
        6710,
        'AI',
        'Marketplace',
        '',
        '',
        '',
        28,
        16,
        16,
        425,
        400,
        400,
        16,
        600,
        15,
        500,
        '0.04,0.15,0.25,1.00',
        '0.04,0.15,0.25,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.78,0.39,0.49,1.00',
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
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 30: Enterprise reinvention
    -- CSS Data: {"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(99, 91, 255)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"bord...
    -- Cards: 8 items
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
        29,
        3,
        'Enterprise reinvention',
        'enterprise-reinvention',
        1163,
        7201,
        'Enterprise reinvention',
        'Millions',
        'Quickly build great payments experiences, improve performance, expand into new markets, and engage customers with subscriptions and marketplaces. Get expert integration guidance from our professional services team and certified partners, and connect Stripe to Salesforce, SAP, and more through the Stripe App Marketplace.',
        'professional services',
        'https://stripe.com/in/professional-services',
        18,
        6,
        18,
        500,
        400,
        300,
        18,
        425,
        15,
        500,
        '0.39,0.36,1.00,1.00',
        '0.39,0.36,1.00,1.00',
        '0.26,0.33,0.40,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.39,0.36,1.00,1.00',
        60,
        1,
        800,
        1000,
        40,
        3,
        '',
        'scraped_images/stripe_test_1768408494/img_13.png',
        FALSE,
        '{"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(99, 91, 255)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        '{"cards": [{"title": "professional services", "description": "Quickly build great payments experiences, improve performance, expand into new markets, and engage customers with subscriptions and marketplaces. Get expert integration guidance from our professional services team and certified partners, and connect Stripe to Salesforce, SAP, and more through the St", "link": "https://stripe.com/in/professional-services", "button_text": "professional services", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 18, "title_font_weight": 425}, {"title": "certified partners", "description": "", "link": "https://stripe.com/in/partners", "button_text": "certified partners", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 18, "title_font_weight": 425}, {"title": "Stripe App Marketplace", "description": "", "link": "https://marketplace.stripe.com/collections/enterprise", "button_text": "Stripe App Marketplace", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 18, "title_font_weight": 425}, {"title": "Explore Stripe for enterprises", "description": "", "link": "https://stripe.com/in/enterprise", "button_text": "Explore Stripe for enterprises", "bg_color": "rgb(99, 91, 255)", "text_color": "rgb(255, 255, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "BMW logo", "description": "", "link": "", "button_text": "BMW logo", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(0, 0, 0)", "title_font_size": 13, "title_font_weight": 400}, {"title": "Amazon logo", "description": "", "link": "", "button_text": "Amazon logo", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(0, 0, 0)", "title_font_size": 13, "title_font_weight": 400}, {"title": "Maersk logo", "description": "", "link": "", "button_text": "Maersk logo", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(0, 0, 0)", "title_font_size": 13, "title_font_weight": 400}, {"title": "Twilio logo", "description": "", "link": "", "button_text": "Twilio logo", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(0, 0, 0)", "title_font_size": 13, "title_font_weight": 400}]}',
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 31: Enterprise reinvention
    -- CSS Data: {"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(99, 91, 255)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"bord...
    -- Cards: 4 items
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
        30,
        8,
        'Enterprise reinvention',
        'enterprise-reinvention',
        293,
        7329,
        'Enterprise reinvention',
        '',
        'Quickly build great payments experiences, improve performance, expand into new markets, and engage customers with subscriptions and marketplaces. Get expert integration guidance from our professional services team and certified partners, and connect Stripe to Salesforce, SAP, and more through the Stripe App Marketplace.',
        'professional services',
        'https://stripe.com/in/professional-services',
        18,
        6,
        18,
        500,
        400,
        300,
        18,
        425,
        15,
        500,
        '0.39,0.36,1.00,1.00',
        '0.39,0.36,1.00,1.00',
        '0.26,0.33,0.40,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.39,0.36,1.00,1.00',
        60,
        1,
        300,
        250,
        20,
        3,
        '',
        '',
        FALSE,
        '{"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(99, 91, 255)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        '{"cards": [{"title": "professional services", "description": "Quickly build great payments experiences, improve performance, expand into new markets, and engage customers with subscriptions and marketplaces. Get expert integration guidance from our professional services team and certified partners, and connect Stripe to Salesforce, SAP, and more through the St", "link": "https://stripe.com/in/professional-services", "button_text": "professional services", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 18, "title_font_weight": 425}, {"title": "certified partners", "description": "", "link": "https://stripe.com/in/partners", "button_text": "certified partners", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 18, "title_font_weight": 425}, {"title": "Stripe App Marketplace", "description": "", "link": "https://marketplace.stripe.com/collections/enterprise", "button_text": "Stripe App Marketplace", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 18, "title_font_weight": 425}, {"title": "Explore Stripe for enterprises", "description": "", "link": "https://stripe.com/in/enterprise", "button_text": "Explore Stripe for enterprises", "bg_color": "rgb(99, 91, 255)", "text_color": "rgb(255, 255, 255)", "title_font_size": 15, "title_font_weight": 425}]}',
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 32: Millions
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
        31,
        4,
        'Millions',
        'millions',
        397,
        7686,
        'Millions',
        'Products used',
        '',
        '',
        '',
        24,
        12,
        16,
        500,
        400,
        400,
        16,
        600,
        15,
        500,
        '0.04,0.15,0.25,1.00',
        '0.04,0.15,0.25,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.78,0.39,0.49,1.00',
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
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 33: 350+
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
        32,
        4,
        '350+',
        '350',
        87,
        7822,
        '350+',
        '$10+',
        '',
        '',
        '',
        24,
        12,
        16,
        500,
        400,
        400,
        16,
        600,
        15,
        500,
        '0.04,0.15,0.25,1.00',
        '0.04,0.15,0.25,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.78,0.39,0.49,1.00',
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
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 34: Products used
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
        33,
        10,
        'Products used',
        'products-used',
        300,
        7966,
        'Products used',
        'See how Amazon simplified cross-border payments with Stripe',
        '',
        '',
        '',
        15,
        3,
        16,
        425,
        400,
        400,
        16,
        600,
        15,
        500,
        '0.04,0.15,0.25,1.00',
        '0.04,0.15,0.25,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.78,0.39,0.49,1.00',
        '1.00,1.00,1.00,1.00',
        40,
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
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 35: Built for growth
    -- CSS Data: {"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(99, 91, 255)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"bor...
    -- Cards: 4 items
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
        34,
        3,
        'Built for growth',
        'built-for-growth',
        800,
        8364,
        'Built for growth',
        'Incorporate your company',
        '',
        'Learn about Atlas',
        'https://stripe.com/in/atlas',
        18,
        6,
        16,
        500,
        400,
        400,
        16,
        425,
        15,
        500,
        '0.39,0.36,1.00,1.00',
        '0.39,0.36,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.39,0.36,1.00,1.00',
        60,
        1,
        800,
        1000,
        40,
        3,
        '',
        'scraped_images/stripe_test_1768408494/img_2.png',
        FALSE,
        '{"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(99, 91, 255)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        '{"cards": [{"title": "Learn about Atlas", "description": "", "link": "https://stripe.com/in/atlas", "button_text": "Learn about Atlas", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}, {"title": "Start with Checkout", "description": "", "link": "https://stripe.com/in/checkout", "button_text": "Start with Checkout", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}, {"title": "Try Payment Links", "description": "", "link": "https://stripe.com/in/payments/payment-links", "button_text": "Try Payment Links", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}, {"title": "Explore billing", "description": "", "link": "https://stripe.com/in/billing", "button_text": "Explore billing", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}]}',
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 36: Built for growth
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
        35,
        2,
        'Built for growth',
        'built-for-growth',
        236,
        8492,
        'Built for growth',
        '',
        '',
        '',
        '',
        18,
        6,
        16,
        500,
        400,
        400,
        16,
        600,
        15,
        500,
        '0.39,0.36,1.00,1.00',
        '0.39,0.36,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.78,0.39,0.49,1.00',
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
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 37: Validate your idea
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
        36,
        2,
        'Validate your idea',
        'validate-your-idea',
        103,
        9210,
        'Validate your idea',
        '',
        '',
        '',
        '',
        26,
        14,
        16,
        500,
        400,
        400,
        16,
        600,
        15,
        500,
        '0.04,0.15,0.25,1.00',
        '0.04,0.15,0.25,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.78,0.39,0.49,1.00',
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
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 38: Incorporate your company
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
        37,
        2,
        'Incorporate your company',
        'incorporate-your-company',
        103,
        9340,
        'Incorporate your company',
        '',
        '',
        '',
        '',
        26,
        14,
        16,
        500,
        400,
        400,
        16,
        600,
        15,
        500,
        '0.04,0.15,0.25,1.00',
        '0.04,0.15,0.25,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.78,0.39,0.49,1.00',
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
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 39: Launch any pricing model
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
        38,
        2,
        'Launch any pricing model',
        'launch-any-pricing-model',
        103,
        9795,
        'Launch any pricing model',
        '',
        '',
        '',
        '',
        26,
        14,
        16,
        500,
        400,
        400,
        16,
        600,
        15,
        500,
        '0.04,0.15,0.25,1.00',
        '0.04,0.15,0.25,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.78,0.39,0.49,1.00',
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
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 40: Sell products and services
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
        39,
        2,
        'Sell products and services',
        'sell-products-and-services',
        103,
        9925,
        'Sell products and services',
        '',
        '',
        '',
        '',
        26,
        14,
        16,
        500,
        400,
        400,
        16,
        600,
        15,
        500,
        '0.04,0.15,0.25,1.00',
        '0.04,0.15,0.25,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.78,0.39,0.49,1.00',
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
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 41: Designed for developers
    -- CSS Data: {"button": {"borderRadius": "16.5px", "borderWidth": "0px", "borderColor": "rgb(10, 37, 64)", "boxShadow": "none", "padding": "3px 12px 6px 16px", "textTransform": "none", "letterSpacing": "0.2px"}, "...
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
        40,
        3,
        'Designed for developers',
        'designed-for-developers',
        800,
        10188,
        'Designed for developers',
        'Use Stripe with your stack',
        '',
        'Read the docs',
        'https://docs.stripe.com/',
        18,
        6,
        16,
        500,
        400,
        400,
        15,
        425,
        15,
        500,
        '0.00,0.83,1.00,1.00',
        '0.00,0.83,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.83,1.00,1.00',
        '0.04,0.15,0.25,1.00',
        60,
        1,
        800,
        1000,
        40,
        3,
        '',
        '',
        FALSE,
        '{"button": {"borderRadius": "16.5px", "borderWidth": "0px", "borderColor": "rgb(10, 37, 64)", "boxShadow": "none", "padding": "3px 12px 6px 16px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        '{"cards": [{"title": "Read the docs", "description": "", "link": "https://docs.stripe.com/", "button_text": "Read the docs", "bg_color": "rgb(0, 212, 255)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 425}, {"title": "See libraries", "description": "", "link": "https://docs.stripe.com/libraries", "button_text": "See libraries", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(0, 212, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "View docs", "description": "", "link": "https://docs.stripe.com/agents", "button_text": "View docs", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(0, 212, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "Browse App Marketplace", "description": "", "link": "https://marketplace.stripe.com/", "button_text": "Browse App Marketplace", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(0, 212, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "Learn about Apps", "description": "", "link": "https://stripe.com/in/apps", "button_text": "Learn about Apps", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(0, 212, 255)", "title_font_size": 15, "title_font_weight": 425}]}',
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 42: 
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
        41,
        2,
        '',
        '',
        98,
        10249,
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
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.78,0.39,0.49,1.00',
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
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 43: Designed for developers
    -- CSS Data: {"button": {"borderRadius": "16.5px", "borderWidth": "0px", "borderColor": "rgb(10, 37, 64)", "boxShadow": "none", "padding": "3px 12px 6px 16px", "textTransform": "none", "letterSpacing": "0.2px"}, "...
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
        42,
        2,
        'Designed for developers',
        'designed-for-developers',
        369,
        10431,
        'Designed for developers',
        '',
        '',
        'Read the docs',
        'https://docs.stripe.com/',
        18,
        6,
        16,
        500,
        400,
        400,
        15,
        425,
        15,
        500,
        '0.00,0.83,1.00,1.00',
        '0.00,0.83,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.83,1.00,1.00',
        '0.04,0.15,0.25,1.00',
        60,
        1,
        300,
        250,
        20,
        3,
        '',
        '',
        FALSE,
        '{"button": {"borderRadius": "16.5px", "borderWidth": "0px", "borderColor": "rgb(10, 37, 64)", "boxShadow": "none", "padding": "3px 12px 6px 16px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        NULL,
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 44: Use Stripe with your stack
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
        43,
        3,
        'Use Stripe with your stack',
        'use-stripe-with-your-stack',
        80,
        11017,
        'Use Stripe with your stack',
        'Explore pre-built integrations',
        '',
        '',
        '',
        15,
        3,
        16,
        425,
        400,
        400,
        16,
        600,
        15,
        500,
        '1.00,1.00,1.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.78,0.39,0.49,1.00',
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
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 45: Launch with ease
    -- CSS Data: {"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(99, 91, 255)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"bord...
    -- Cards: 8 items
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
        44,
        3,
        'Launch with ease',
        'launch-with-ease',
        800,
        11346,
        'Launch with ease',
        'Use a pre-integrated platform',
        '',
        'Squarespace',
        'https://stripe.com/in/partners/directory/squarespace',
        18,
        6,
        16,
        500,
        400,
        400,
        18,
        425,
        15,
        500,
        '0.39,0.36,1.00,1.00',
        '0.39,0.36,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.39,0.36,1.00,1.00',
        60,
        1,
        800,
        1000,
        40,
        3,
        '',
        'scraped_images/stripe_test_1768408494/img_3.jpg',
        FALSE,
        '{"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(99, 91, 255)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        '{"cards": [{"title": "Squarespace", "description": "", "link": "https://stripe.com/in/partners/directory/squarespace", "button_text": "Squarespace", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 18, "title_font_weight": 425}, {"title": "Lightspeed", "description": "", "link": "https://stripe.com/in/partners/directory/lightspeed", "button_text": "Lightspeed", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 18, "title_font_weight": 425}, {"title": "See directory", "description": "", "link": "https://stripe.com/in/partners/directory", "button_text": "See directory", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}, {"title": "View partners", "description": "", "link": "https://stripe.com/in/partners/directory", "button_text": "View partners", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}, {"title": "usage-based billing", "description": "", "link": "https://docs.stripe.com/billing/subscriptions/usage-based/implementation-guide", "button_text": "usage-based billing", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 18, "title_font_weight": 425}, {"title": "in-person payment", "description": "", "link": "https://docs.stripe.com/no-code/in-person", "button_text": "in-person payment", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 18, "title_font_weight": 425}, {"title": "payment link", "description": "", "link": "https://docs.stripe.com/no-code/payment-links", "button_text": "payment link", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 18, "title_font_weight": 425}, {"title": "Explore no-code", "description": "", "link": "https://docs.stripe.com/no-code", "button_text": "Explore no-code", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 16, "title_font_weight": 425}]}',
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 46: Launch with ease
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
        45,
        2,
        'Launch with ease',
        'launch-with-ease',
        228,
        11589,
        'Launch with ease',
        '',
        '',
        '',
        '',
        18,
        6,
        16,
        500,
        400,
        400,
        16,
        600,
        15,
        500,
        '0.39,0.36,1.00,1.00',
        '0.39,0.36,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.78,0.39,0.49,1.00',
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
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 47: 
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
        46,
        2,
        '',
        '',
        75,
        11977,
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
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.78,0.39,0.49,1.00',
        '1.00,1.00,1.00,1.00',
        60,
        1,
        300,
        250,
        20,
        3,
        '',
        'scraped_images/stripe_test_1768408494/img_10.jpg',
        FALSE,
        '{"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(0,0,0)", "boxShadow": "none", "padding": "10px 20px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        NULL,
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 48: 
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
        47,
        2,
        '',
        '',
        65,
        12062,
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
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.78,0.39,0.49,1.00',
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
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 49: Use a pre-integrated platform
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
        48,
        3,
        'Use a pre-integrated platform',
        'use-a-pre-integrated-platform',
        71,
        12129,
        'Use a pre-integrated platform',
        'Try our no-code products',
        '',
        '',
        '',
        26,
        14,
        16,
        500,
        400,
        400,
        16,
        600,
        15,
        500,
        '0.04,0.15,0.25,1.00',
        '0.04,0.15,0.25,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.78,0.39,0.49,1.00',
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
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 50: Ready to get started?
    -- CSS Data: {"button": {"borderRadius": "16.5px", "borderWidth": "0px", "borderColor": "rgb(255, 255, 255)", "boxShadow": "none", "padding": "3px 12px 6px 16px", "textTransform": "none", "letterSpacing": "0.2px"}...
    -- Cards: 4 items
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
        49,
        3,
        'Ready to get started?',
        'ready-to-get-started',
        612,
        12537,
        'Ready to get started?',
        'Start your integration',
        'Create an account instantly to get started or contact us to design a custom package for your business.',
        'Start now',
        'https://dashboard.stripe.com/register',
        24,
        12,
        18,
        500,
        400,
        300,
        15,
        425,
        15,
        500,
        '0.04,0.15,0.25,1.00',
        '0.04,0.15,0.25,1.00',
        '0.26,0.33,0.40,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.39,0.36,1.00,1.00',
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
        '{"button": {"borderRadius": "16.5px", "borderWidth": "0px", "borderColor": "rgb(255, 255, 255)", "boxShadow": "none", "padding": "3px 12px 6px 16px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        '{"cards": [{"title": "Start now", "description": "Create an account instantly to get started or contact us to design a custom package for your business.", "link": "https://dashboard.stripe.com/register", "button_text": "Start now", "bg_color": "rgb(99, 91, 255)", "text_color": "rgb(255, 255, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "Contact sales", "description": "", "link": "https://stripe.com/in/contact/sales", "button_text": "Contact sales", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "Pricing details", "description": "", "link": "https://stripe.com/in/pricing", "button_text": "Pricing details", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "API reference", "description": "", "link": "https://docs.stripe.com/api", "button_text": "API reference", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 15, "title_font_weight": 425}]}',
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 51: Ready to get started?
    -- CSS Data: {"button": {"borderRadius": "16.5px", "borderWidth": "0px", "borderColor": "rgb(255, 255, 255)", "boxShadow": "none", "padding": "3px 12px 6px 16px", "textTransform": "none", "letterSpacing": "0.2px"}...
    -- Cards: 4 items
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
        50,
        8,
        'Ready to get started?',
        'ready-to-get-started',
        197,
        12665,
        'Ready to get started?',
        'Start your integration',
        'Create an account instantly to get started or contact us to design a custom package for your business.',
        'Start now',
        'https://dashboard.stripe.com/register',
        24,
        12,
        18,
        500,
        400,
        300,
        15,
        425,
        15,
        500,
        '0.04,0.15,0.25,1.00',
        '0.04,0.15,0.25,1.00',
        '0.26,0.33,0.40,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.39,0.36,1.00,1.00',
        '1.00,1.00,1.00,1.00',
        40,
        1,
        300,
        250,
        20,
        3,
        '',
        '',
        FALSE,
        '{"button": {"borderRadius": "16.5px", "borderWidth": "0px", "borderColor": "rgb(255, 255, 255)", "boxShadow": "none", "padding": "3px 12px 6px 16px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        '{"cards": [{"title": "Start now", "description": "Create an account instantly to get started or contact us to design a custom package for your business.", "link": "https://dashboard.stripe.com/register", "button_text": "Start now", "bg_color": "rgb(99, 91, 255)", "text_color": "rgb(255, 255, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "Contact sales", "description": "", "link": "https://stripe.com/in/contact/sales", "button_text": "Contact sales", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "Pricing details", "description": "", "link": "https://stripe.com/in/pricing", "button_text": "Pricing details", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 15, "title_font_weight": 425}, {"title": "API reference", "description": "", "link": "https://docs.stripe.com/api", "button_text": "API reference", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(99, 91, 255)", "title_font_size": 15, "title_font_weight": 425}]}',
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 52: Products & pricing
    -- CSS Data: {"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(0, 0, 238)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"borde...
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
        51,
        3,
        'Products & pricing',
        'products-pricing',
        800,
        12946,
        'Products & pricing',
        'Integrations & custom solutions',
        '',
        'Stripe logo',
        'https://stripe.com/in',
        15,
        3,
        16,
        425,
        400,
        400,
        16,
        300,
        15,
        500,
        '0.04,0.15,0.25,1.00',
        '0.04,0.15,0.25,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.00,0.00,0.93,1.00',
        60,
        1,
        800,
        1000,
        40,
        3,
        '',
        '',
        FALSE,
        '{"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(0, 0, 238)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        '{"cards": [{"title": "Stripe logo", "description": "", "link": "https://stripe.com/in", "button_text": "Stripe logo", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(0, 0, 238)", "title_font_size": 16, "title_font_weight": 300}, {"title": "India (English)", "description": "", "link": "", "button_text": "India (English)", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Pricing", "description": "", "link": "https://stripe.com/in/pricing", "button_text": "Pricing", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Atlas", "description": "", "link": "https://stripe.com/in/atlas", "button_text": "Atlas", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Authorisation Boost", "description": "", "link": "https://stripe.com/in/authorization-boost", "button_text": "Authorisation Boost", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Billing", "description": "", "link": "https://stripe.com/in/billing", "button_text": "Billing", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Capital", "description": "", "link": "https://stripe.com/in/capital/platforms", "button_text": "Capital", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Checkout", "description": "", "link": "https://stripe.com/in/payments/checkout", "button_text": "Checkout", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Climate", "description": "", "link": "https://stripe.com/in/climate", "button_text": "Climate", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Connect", "description": "", "link": "https://stripe.com/in/connect", "button_text": "Connect", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Data Pipeline", "description": "", "link": "https://stripe.com/in/data-pipeline", "button_text": "Data Pipeline", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Elements", "description": "", "link": "https://stripe.com/in/payments/elements", "button_text": "Elements", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}]}',
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 53: 
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
        52,
        2,
        '',
        '',
        98,
        13049,
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
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.78,0.39,0.49,1.00',
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
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 54: Products & pricing
    -- CSS Data: {"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(0, 0, 238)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"borde...
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
        53,
        3,
        'Products & pricing',
        'products-pricing',
        972,
        13233,
        'Products & pricing',
        'Integrations & custom solutions',
        '',
        'Stripe logo',
        'https://stripe.com/in',
        15,
        3,
        16,
        425,
        400,
        400,
        16,
        300,
        15,
        500,
        '0.04,0.15,0.25,1.00',
        '0.04,0.15,0.25,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.00,0.00,0.93,1.00',
        60,
        1,
        800,
        1000,
        40,
        3,
        '',
        '',
        FALSE,
        '{"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(0, 0, 238)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "normal"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        '{"cards": [{"title": "Stripe logo", "description": "", "link": "https://stripe.com/in", "button_text": "Stripe logo", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(0, 0, 238)", "title_font_size": 16, "title_font_weight": 300}, {"title": "India (English)", "description": "", "link": "", "button_text": "India (English)", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Pricing", "description": "", "link": "https://stripe.com/in/pricing", "button_text": "Pricing", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Atlas", "description": "", "link": "https://stripe.com/in/atlas", "button_text": "Atlas", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Authorisation Boost", "description": "", "link": "https://stripe.com/in/authorization-boost", "button_text": "Authorisation Boost", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Billing", "description": "", "link": "https://stripe.com/in/billing", "button_text": "Billing", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Capital", "description": "", "link": "https://stripe.com/in/capital/platforms", "button_text": "Capital", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Checkout", "description": "", "link": "https://stripe.com/in/payments/checkout", "button_text": "Checkout", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Climate", "description": "", "link": "https://stripe.com/in/climate", "button_text": "Climate", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Connect", "description": "", "link": "https://stripe.com/in/connect", "button_text": "Connect", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Data Pipeline", "description": "", "link": "https://stripe.com/in/data-pipeline", "button_text": "Data Pipeline", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Elements", "description": "", "link": "https://stripe.com/in/payments/elements", "button_text": "Elements", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}]}',
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 55: Company
    -- CSS Data: {"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(10, 37, 64)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"borde...
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
        54,
        8,
        'Company',
        'company',
        144,
        13565,
        'Company',
        '',
        '',
        'Financial Connections',
        'https://stripe.com/in/financial-connections',
        15,
        3,
        16,
        425,
        400,
        400,
        15,
        300,
        15,
        500,
        '0.04,0.15,0.25,1.00',
        '0.04,0.15,0.25,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.04,0.15,0.25,1.00',
        60,
        1,
        300,
        250,
        20,
        3,
        '',
        '',
        FALSE,
        '{"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(10, 37, 64)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        '{"cards": [{"title": "Financial Connections", "description": "", "link": "https://stripe.com/in/financial-connections", "button_text": "Financial Connections", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Identity", "description": "", "link": "https://stripe.com/in/identity", "button_text": "Identity", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Invoicing", "description": "", "link": "https://stripe.com/invoicing", "button_text": "Invoicing", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Issuing", "description": "", "link": "https://stripe.com/in/issuing", "button_text": "Issuing", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Link", "description": "", "link": "https://stripe.com/in/payments/link", "button_text": "Link", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "SaaS", "description": "", "link": "https://stripe.com/in/use-cases/saas", "button_text": "SaaS", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "AI companies", "description": "", "link": "https://stripe.com/in/use-cases/ai", "button_text": "AI companies", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Creator economy", "description": "", "link": "https://stripe.com/in/use-cases/creator-economy", "button_text": "Creator economy", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Hospitality, travel and leisure", "description": "", "link": "https://stripe.com/industries/travel", "button_text": "Hospitality, travel and leisure", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Insurance", "description": "", "link": "https://stripe.com/industries/insurance", "button_text": "Insurance", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Jobs", "description": "", "link": "https://stripe.com/in/jobs", "button_text": "Jobs", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Newsroom", "description": "", "link": "https://stripe.com/in/newsroom", "button_text": "Newsroom", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}]}',
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 56: Support
    -- CSS Data: {"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(10, 37, 64)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"borde...
    -- Cards: 7 items
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
        55,
        8,
        'Support',
        'support',
        88,
        13729,
        'Support',
        '',
        '',
        'Payment Links',
        'https://stripe.com/in/payments/payment-links',
        15,
        3,
        16,
        425,
        400,
        400,
        15,
        300,
        15,
        500,
        '0.04,0.15,0.25,1.00',
        '0.04,0.15,0.25,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.04,0.15,0.25,1.00',
        60,
        1,
        300,
        250,
        20,
        3,
        '',
        '',
        FALSE,
        '{"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(10, 37, 64)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        '{"cards": [{"title": "Payment Links", "description": "", "link": "https://stripe.com/in/payments/payment-links", "button_text": "Payment Links", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Payouts", "description": "", "link": "https://stripe.com/in/connect/payouts", "button_text": "Payouts", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Radar", "description": "", "link": "https://stripe.com/in/radar", "button_text": "Radar", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Non-profits", "description": "", "link": "https://stripe.com/industries/nonprofits", "button_text": "Non-profits", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Retail", "description": "", "link": "https://stripe.com/industries/retail", "button_text": "Retail", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Get support", "description": "", "link": "https://support.stripe.com/?referrerLocale=en-gb-in", "button_text": "Get support", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Managed support plans", "description": "", "link": "https://stripe.com/in/support-plans", "button_text": "Managed support plans", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}]}',
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 57: Integrations & custom solutions
    -- CSS Data: {"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(10, 37, 64)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"borde...
    -- Cards: 8 items
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
        56,
        8,
        'Integrations & custom solutions',
        'integrations-custom-solutions',
        116,
        13817,
        'Integrations & custom solutions',
        '',
        '',
        'Revenue Recognition',
        'https://stripe.com/in/revenue-recognition',
        15,
        3,
        16,
        425,
        400,
        400,
        15,
        300,
        15,
        500,
        '0.04,0.15,0.25,1.00',
        '0.04,0.15,0.25,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.04,0.15,0.25,1.00',
        60,
        1,
        300,
        250,
        20,
        3,
        '',
        '',
        FALSE,
        '{"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(10, 37, 64)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        '{"cards": [{"title": "Revenue Recognition", "description": "", "link": "https://stripe.com/in/revenue-recognition", "button_text": "Revenue Recognition", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Stripe Sigma", "description": "", "link": "https://stripe.com/in/sigma", "button_text": "Stripe Sigma", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Tax", "description": "", "link": "https://stripe.com/in/tax", "button_text": "Tax", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Terminal", "description": "", "link": "https://stripe.com/in/terminal", "button_text": "Terminal", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Stripe App Marketplace", "description": "", "link": "https://marketplace.stripe.com/", "button_text": "Stripe App Marketplace", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Partner ecosystem", "description": "", "link": "https://stripe.com/in/partners", "button_text": "Partner ecosystem", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Professional services", "description": "", "link": "https://stripe.com/in/professional-services", "button_text": "Professional services", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Sign in", "description": "", "link": "https://dashboard.stripe.com/login", "button_text": "Sign in", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 425}]}',
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );


    -- Section 58: Developers
    -- CSS Data: {"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(10, 37, 64)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"borde...
    -- Cards: 6 items
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
        57,
        8,
        'Developers',
        'developers',
        200,
        13953,
        'Developers',
        '',
        '',
        'Documentation',
        'https://docs.stripe.com/',
        15,
        3,
        16,
        425,
        400,
        400,
        15,
        300,
        15,
        500,
        '0.04,0.15,0.25,1.00',
        '0.04,0.15,0.25,1.00',
        '0.00,0.00,0.00,1.00',
        '1.00,1.00,1.00,1.00',
        '0.00,0.00,0.00,1.00',
        '0.8,0.4,0.5,1.0',
        '0.00,0.00,0.00,0.00',
        '0.04,0.15,0.25,1.00',
        60,
        1,
        300,
        250,
        20,
        3,
        '',
        '',
        FALSE,
        '{"button": {"borderRadius": "0px", "borderWidth": "0px", "borderColor": "rgb(10, 37, 64)", "boxShadow": "none", "padding": "0px", "textTransform": "none", "letterSpacing": "0.2px"}, "section": {"borderRadius": "0px", "boxShadow": "none", "border": "none", "opacity": "1", "backgroundImage": "none", "backgroundSize": "auto", "filter": "none", "transform": "none", "textShadow": "none", "lineHeight": "normal", "letterSpacing": "normal"}}',
        '{"cards": [{"title": "Documentation", "description": "", "link": "https://docs.stripe.com/", "button_text": "Documentation", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "API reference", "description": "", "link": "https://docs.stripe.com/api", "button_text": "API reference", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "API status", "description": "", "link": "https://status.stripe.com/", "button_text": "API status", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "API changelog", "description": "", "link": "https://docs.stripe.com/changelog", "button_text": "API changelog", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Libraries and SDKs", "description": "", "link": "https://docs.stripe.com/development", "button_text": "Libraries and SDKs", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}, {"title": "Developer blog", "description": "", "link": "https://stripe.dev/", "button_text": "Developer blog", "bg_color": "rgba(0, 0, 0, 0)", "text_color": "rgb(10, 37, 64)", "title_font_size": 15, "title_font_weight": 300}]}',
        '{"padding": {"top": "60px", "right": "60px", "bottom": "60px", "left": "60px"}, "flexbox": {"display": "block", "flexDirection": "row", "justifyContent": "normal", "alignItems": "normal", "gap": "0px"}, "grid": {"gridTemplateColumns": "none", "gridTemplateRows": "none"}, "background": {"backgroundPosition": "0% 0%", "backgroundRepeat": "repeat"}}'
    );

END $$;



























































COMMIT;


-- Template import complete!
-- Template name: stripe_test_1768408494
-- Total sections: 58
--
-- To verify the import:
-- SELECT * FROM templates WHERE template_name = 'stripe_test_1768408494';
-- SELECT COUNT(*) FROM sections WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_test_1768408494');

-- Update sections with BYTEA image data


UPDATE sections
SET section_image_data = E'\\x524946463804000057454250565038202c040000b018009d012a840084003e793c9a49a4a3a2a124d40928900f09656ee17129cc7300f71827da97d087f99f4a3e817cea5fedbd4eef37ff3df518e98d7dd2633dd39d9bccfd30d9900a15fee591a279766ee567d2ff38b9e153f30cdb04743f3b2d590537453fe49bc2b2fa300b9d6a7aaa3c6de57b3a9d6768597a269ac6284d95e03b41c6aa6faf331c398be33e3c94e4deda4aca71398b77a15156925d89806c4bbd1c409718d1c6303122039adff1a6a0fa7f24c7a889b8747c1f2be29b3b09af3b1ea814281df689e5d9b9c000feff0d0c613303080f3efaad49bd7ef8b4925722eadba31efdb47acf27223bbfcc2b9973694b4573c5c8461742b9ff40e822d61b7e570b6ede6bf60f676c2a85bd2003c718d0b796bf4f1c866d03edae2c7d5c6456d69de052e91206cfa88c07185066654386547a36401e9203ad4fd067fe8de75c2a7b218fa70a5fcf9afda6c6b2ef1e50073d60923ac8cebbe22843f7893126aaf2282f402fb0c70174eaa7fd2117c750ed818ca06c2c8026f8f3db18c906944025b44d4ea707d9daaad2ef0360dc43bf8b5f8f26bbf13e3702ee41bb4969d0b8e2ebd9041e97c0d462ae1193f0922ad1e44c993300543e9af144185aec7c2753770b637da4af6431547ca8e6d3dfbc83b48bf08424c68055b12e2727c7b6f5d4f6a9739c4206fa45971695b586534bb28a670f52df196f96c3b3cb2389428b2ef4a283dda73a97c15a9bd7c3c6110e88fd90910485539edff64adafa78651aefe9fe3067bfcac15131ced9c6e574fd9549c141f328f9512a29dba3e03640c246da85f2a1575ed227f98e7c73efeb66dec0e390ba276220d549073b5b4faaa72bff410c864752a660c7827dcd7fcbff797ecf1291983503aa4ce0763683d42b89807148812e6f3c3ae0f44e93392feffae4f98b7a8fa109a3494f0fcbaec6bbb8852033b8b0e752f29bee1a4437f66d9658586f7b09880bfaa0dda3d6ca3cec90507fa7200cfe173415926c21bbb7e0449f3997fe255aa24d02e67d039210166ebacbbeeb3b443f8153ab608f5ccaf8387197c34d77ccacb5940d3acbd1a536e2104dd304c00293fe573c71784004071cc38e7b0763ec84d8a773423387cbd5620eba76dc53faf63c68b16f9cce351041508bc3548ca014ccde504358b87b7cceee1a52b0caaa2da1312434b1f56c1648fc33eebc93aebd39fc9bd3d7f870a9b48af0e62e39af9bd52bee390d1c4d6e9956b7e30fcaa645f3d5b7b2e5c883800e9ab09ed1a8beb942cecca7895365063668474e3d168642b9eb65eab1409ae8396b2aa2c5faa2f1401d3647865053b3f11baa2b1bb0b7b909c80dcaf8e770bd6b3e53a5e2377c447c5b11a8563e4e8ba0cb47ec29009d645f5587866beff936146e4a99aa6c1ac9a76e13aee038d2e116ad637d4fb57e1f458a5bf9cb60ef245d6ae7f40de19e99a4f591896e7095690eccab7755538acd8b3bb36dd6832280894699dd8e00000000'
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_test_1768408494')
  AND section_order = 0;


UPDATE sections
SET section_image_data = E'\\x524946463804000057454250565038202c040000b018009d012a840084003e793c9a49a4a3a2a124d40928900f09656ee17129cc7300f71827da97d087f99f4a3e817cea5fedbd4eef37ff3df518e98d7dd2633dd39d9bccfd30d9900a15fee591a279766ee567d2ff38b9e153f30cdb04743f3b2d590537453fe49bc2b2fa300b9d6a7aaa3c6de57b3a9d6768597a269ac6284d95e03b41c6aa6faf331c398be33e3c94e4deda4aca71398b77a15156925d89806c4bbd1c409718d1c6303122039adff1a6a0fa7f24c7a889b8747c1f2be29b3b09af3b1ea814281df689e5d9b9c000feff0d0c613303080f3efaad49bd7ef8b4925722eadba31efdb47acf27223bbfcc2b9973694b4573c5c8461742b9ff40e822d61b7e570b6ede6bf60f676c2a85bd2003c718d0b796bf4f1c866d03edae2c7d5c6456d69de052e91206cfa88c07185066654386547a36401e9203ad4fd067fe8de75c2a7b218fa70a5fcf9afda6c6b2ef1e50073d60923ac8cebbe22843f7893126aaf2282f402fb0c70174eaa7fd2117c750ed818ca06c2c8026f8f3db18c906944025b44d4ea707d9daaad2ef0360dc43bf8b5f8f26bbf13e3702ee41bb4969d0b8e2ebd9041e97c0d462ae1193f0922ad1e44c993300543e9af144185aec7c2753770b637da4af6431547ca8e6d3dfbc83b48bf08424c68055b12e2727c7b6f5d4f6a9739c4206fa45971695b586534bb28a670f52df196f96c3b3cb2389428b2ef4a283dda73a97c15a9bd7c3c6110e88fd90910485539edff64adafa78651aefe9fe3067bfcac15131ced9c6e574fd9549c141f328f9512a29dba3e03640c246da85f2a1575ed227f98e7c73efeb66dec0e390ba276220d549073b5b4faaa72bff410c864752a660c7827dcd7fcbff797ecf1291983503aa4ce0763683d42b89807148812e6f3c3ae0f44e93392feffae4f98b7a8fa109a3494f0fcbaec6bbb8852033b8b0e752f29bee1a4437f66d9658586f7b09880bfaa0dda3d6ca3cec90507fa7200cfe173415926c21bbb7e0449f3997fe255aa24d02e67d039210166ebacbbeeb3b443f8153ab608f5ccaf8387197c34d77ccacb5940d3acbd1a536e2104dd304c00293fe573c71784004071cc38e7b0763ec84d8a773423387cbd5620eba76dc53faf63c68b16f9cce351041508bc3548ca014ccde504358b87b7cceee1a52b0caaa2da1312434b1f56c1648fc33eebc93aebd39fc9bd3d7f870a9b48af0e62e39af9bd52bee390d1c4d6e9956b7e30fcaa645f3d5b7b2e5c883800e9ab09ed1a8beb942cecca7895365063668474e3d168642b9eb65eab1409ae8396b2aa2c5faa2f1401d3647865053b3f11baa2b1bb0b7b909c80dcaf8e770bd6b3e53a5e2377c447c5b11a8563e4e8ba0cb47ec29009d645f5587866beff936146e4a99aa6c1ac9a76e13aee038d2e116ad637d4fb57e1f458a5bf9cb60ef245d6ae7f40de19e99a4f591896e7095690eccab7755538acd8b3bb36dd6832280894699dd8e00000000'
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_test_1768408494')
  AND section_order = 6;


UPDATE sections
SET section_image_data = E'\\x524946463804000057454250565038202c040000b018009d012a840084003e793c9a49a4a3a2a124d40928900f09656ee17129cc7300f71827da97d087f99f4a3e817cea5fedbd4eef37ff3df518e98d7dd2633dd39d9bccfd30d9900a15fee591a279766ee567d2ff38b9e153f30cdb04743f3b2d590537453fe49bc2b2fa300b9d6a7aaa3c6de57b3a9d6768597a269ac6284d95e03b41c6aa6faf331c398be33e3c94e4deda4aca71398b77a15156925d89806c4bbd1c409718d1c6303122039adff1a6a0fa7f24c7a889b8747c1f2be29b3b09af3b1ea814281df689e5d9b9c000feff0d0c613303080f3efaad49bd7ef8b4925722eadba31efdb47acf27223bbfcc2b9973694b4573c5c8461742b9ff40e822d61b7e570b6ede6bf60f676c2a85bd2003c718d0b796bf4f1c866d03edae2c7d5c6456d69de052e91206cfa88c07185066654386547a36401e9203ad4fd067fe8de75c2a7b218fa70a5fcf9afda6c6b2ef1e50073d60923ac8cebbe22843f7893126aaf2282f402fb0c70174eaa7fd2117c750ed818ca06c2c8026f8f3db18c906944025b44d4ea707d9daaad2ef0360dc43bf8b5f8f26bbf13e3702ee41bb4969d0b8e2ebd9041e97c0d462ae1193f0922ad1e44c993300543e9af144185aec7c2753770b637da4af6431547ca8e6d3dfbc83b48bf08424c68055b12e2727c7b6f5d4f6a9739c4206fa45971695b586534bb28a670f52df196f96c3b3cb2389428b2ef4a283dda73a97c15a9bd7c3c6110e88fd90910485539edff64adafa78651aefe9fe3067bfcac15131ced9c6e574fd9549c141f328f9512a29dba3e03640c246da85f2a1575ed227f98e7c73efeb66dec0e390ba276220d549073b5b4faaa72bff410c864752a660c7827dcd7fcbff797ecf1291983503aa4ce0763683d42b89807148812e6f3c3ae0f44e93392feffae4f98b7a8fa109a3494f0fcbaec6bbb8852033b8b0e752f29bee1a4437f66d9658586f7b09880bfaa0dda3d6ca3cec90507fa7200cfe173415926c21bbb7e0449f3997fe255aa24d02e67d039210166ebacbbeeb3b443f8153ab608f5ccaf8387197c34d77ccacb5940d3acbd1a536e2104dd304c00293fe573c71784004071cc38e7b0763ec84d8a773423387cbd5620eba76dc53faf63c68b16f9cce351041508bc3548ca014ccde504358b87b7cceee1a52b0caaa2da1312434b1f56c1648fc33eebc93aebd39fc9bd3d7f870a9b48af0e62e39af9bd52bee390d1c4d6e9956b7e30fcaa645f3d5b7b2e5c883800e9ab09ed1a8beb942cecca7895365063668474e3d168642b9eb65eab1409ae8396b2aa2c5faa2f1401d3647865053b3f11baa2b1bb0b7b909c80dcaf8e770bd6b3e53a5e2377c447c5b11a8563e4e8ba0cb47ec29009d645f5587866beff936146e4a99aa6c1ac9a76e13aee038d2e116ad637d4fb57e1f458a5bf9cb60ef245d6ae7f40de19e99a4f591896e7095690eccab7755538acd8b3bb36dd6832280894699dd8e00000000'
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_test_1768408494')
  AND section_order = 7;


UPDATE sections
SET section_image_data = E'\\x524946468aea000057454250565038207eea00003003039d012a96035c013e612a91462422a1a1aad32c90800c094cd51cfa9bfb189affbf35982cefb0d039fdb3febb5f1fb90a62bd91c43042344b8dc91a81f5f3bf7fd6bfec7f7cf206f2dfe89feb3fb0fb08ff90fe81eb37faef71f72ffec9fb01f005fcd7fb0ffe7ff15ef45985ffa7d21bcc0a8f3fe67edf7a18fadff6abdc8638a716cd6bd1eabfed79caf28f7bdf48fc47b01ff83b58facffbde611efffdaf9c8ff8ffb63eec7fa47f9effe5f9fff40dfb0dfb1dee03ff37eea7bf7fee3ff87d4f7f58ff6ffb97ef61e95ffcb7a877f72ff89ffffdbbfd567d047f787d64bff8fef3fc407f77ffc5fbc5edbdffffd803ffffb7273cff97f91ff997f2bfef3c21f2ddf15fdf7fd1ffe3ff29f371f92643fe2ffbcffe3e83ff41fccffdaff23ed07fb0ffc7fe93c73f8f9ff27f92f60bfcbffa87fc1feffea87f87ffa7fe0f88bec9ff0bff77fbcf61af78fef9ff67fd0fe5bfc71fe679e5fbe7fbaf608fd85ffb7ed27fe2f19cf57fdaff809fd41ff7ffc7ff95f78affdffddfe717c1ffaffff8ffb9f817fe81fe07ff17f92f6e8ffffeef3f747ffcfbbdfedbffff187c2870dc16df04d4a374b13c23ece6abe80ca108ffd4b98060b1212e66b47295ad5d70e93f444d842cecabcbbcb52193489c1b266e4d8ab2df1b3d7ab4352957a222923fcc3ad21cb9547b6fc4619a5ec9ee41167773c3dd9f7c46a2796d894f25ff32c978ead3978bddb24fd13ab90337697c8f5804309999e2e74b74e45ce77c688add99eaee3f2748dd6538882b046a1e9e5ebc59b8a30721e79159abf9862ae75f803f792b7697f2f4948b2cf58adba1ec64b2525be6d6f1aa429b742760b723527279242f3f026e5fa1dd3cc78ae6bf7edcdf4ca754d4ae5e971eff02ec5bd7406d070f67557a2186cd67b0beb1023d4de1f14a228676e63ad248370542c7d6becc2f0b2276017f0fe3e0eb0bf45e0e3409888a72638d4052ddaf7bd6b4e8f93f44558fe4d02b7d2a6aa9b2397d737e1e3e8a88ee8929615566af6f402ee20b63f52e52b6b99b20736167583e89bc9ec44ffecad2dc20a5fc1c7df59f6cfdfc3f86c34410d07f1a5d4c70089719b48b70e126bace74698e9b15d8ca9ac2986c3f501b3a891dc6722d9019e0a6eb18cfc6678f39295ba41a6631072991de89791954d971270c949a90a2ea79f47269d1529c6596b75c6dcaddf3202c85260259f87ed8608cc89c382a339a3ed85f9d46f178a362117a5e4314946822e33698354699c8fb8485ad4274ddbe2737eaa4408e009cee95c3533cb63adb3746e193fa9cb87538f896236e62403c46deb0ba575bdbe1760ce756401445bffc205035e025638bab1bc75d4dc0890557bb029f2968c9496f6fd1f2e6bf7e16238bc3acb3104bc69b69036446eaea8b153ae8330038b145c153f7361729e537beb75376fbb25922beffc6d63ecba2d189ce61b09528b1156dce06eb1d30ac8db6397ea85893141bfad1ef5cb4d885207fc97ad40d046f72fcdf6bc48504bd9e2bfd25e1451de64405203ed37e9cc4196eb6ef11ef6ec49c8ba7ea2cf66ea582e804cfd7fdfb4053adab6307b8238d563b64415211ee60c8aeac4794a348efedd812f99fe8529a3051b4a0f1068ccca6b091372cd609aa21c161c56ea73160829aaa117dfd2bd62f25f5909a46cbcdaccdaa8865f8c8686432cab79b39120c9deb5c1187a280f51ae24f72b5d3af2dae1797f3e17eaf2745df8f30ad3ad755adee30fea4ed1e6f343902ebb3759922c15c3bbe35b7fbf072b47995246d541d2ea75254bfe2ee3ec43e0c2f2656f8d9c358cd70c68ee0b253b0f3b11fd50905ad31326fa367ed9a0e8eef2a71aea273553e8e1ced991f2cde242db2dad149468a6f19c25c2c4d6836f138d7c08923403a6360c44624ad2ec376d51a9e961cc63c77e4e57e679b70ef188dfcae86a7cec5269098c94da14d664bed1fb129853065818827329e43e0b4b20e3c3522c5de8f444525b479086398f70b0b8f7c2d6b17ee5cc5cf9495db856e4faf982647d5771634063bf28ceb6136ca3ca05c133fd33e8ca06602552a9427e14d0e718ed60b2f346f56d03927c4b17568eb3a703076ab506daac6a818084df0a0c77c1064c87979a8bc6e5013a621c64fa7a793d8882d3c1864523110113bc58996ca4ab7ca4dbc9242579d36a6b2eff4a215860cafc0a707af20e2805e24eacd2ca513977aeae26c3c384b9ddec3ce13c34006bff501462b1d2f5be5b2c17f35c450756f973b4b528afbab7d3573cc572d204a2e473dc5a2a037c3c54633010a26bdc08b8c3dfcbbee8d4cbfcfbcf70ea3965716c78e2a5b9c9f67c194176deb8493c7f2d85adeffdd3db80a0fdf383d9e5c250e31d857adc120e5d7d7f90c771715f8e21a4c64324976107bcfb6f01db6b46dcce96c55c4b796cbf0c1cf3ff57d19bb796e7ace4476e9749f62f850576e9e7fbf0375727dcb502f8bb32a3a5cb708f21649f5d47965a72a616acffff79eeaa811d147bdef1b4e8f8f92f96923eeb5f06a37395ed2ae152ebafbe8ce2b046f893a5b9dbbf4fa72041770c8eb02dcd293aa9a066cda5bb38b4fa0e391cacb736338eaa3fc4c15f0a1bd4104b50ffe8dff4b903ef73b1c2c02d88b9ec38acf465cb08c67df75f307947bb960f833e79c987243c9d2668c870da6ae97327fa386a0d23b0276bf8e7b77646587658bfe8a9579217c4bb0f68820480b869a97c72f48246a9a26baa40fd3d740533f5f72ca7981620dde6713ffb6b185ce8a5588b81f46ba3464682686c13b493b8d7d60abfc5ad003f3931a55f6d6bbcd1dd7123825f574d9fbf9aed96e2e29a831138505c29c347cac068662ca93ebc3283ece2b5d5d1286f154a01d1cdfe0a89a5d29ccd5bc41851327603f389618c51cddd581cbaf0e6fa4ef2081ffe80522a4f6756918873985cfa3223a9bd6352a1fa59d6dc61bffb13d5b4b4d13769c70b2dd89c569f7abb1c360fe3d28b94940d7287664b13a28220b0d5f38a97bf42723c62b7b999a2cc31f053ec38539915a6ed359ae0306a345c241c07f2ebfd33a1e7e8eadf03c6842fd1a5477a9eef5c279dad11c08f19a94c093477a4a9fa1bec7d3e135eaf3007f9d91ea0497fe3663fef96dfe4eb997fb3ffd1c802bf04ebc6839d9459475bb0fc861e6d1cdef9dfe4a9a57b5af0f71c6f82961df30fb2b0fa9b99e339277bf1cf41ab4fec821a9ea1a7d798eaf80065013e5bf14d1f692c9f794febf0660cee428acd7cf5f8df4a283cdc47ce955183d52981c5451f9555fa63d620669d155a7bec6fbc26cd1c152e7853e257cd84255aed1fac0de0a9e45bf2abc98f0f3e6c2b4bef2c556ea34d3587310feaff5e407a416f9556de372abd5896984c08c2548c1bacded7878812775bf8d07a4bd12f2573fdddd7781669dbc1f38b56186863acfa178ff3f993281f29fcb01abb31690f5aa7fd53e8bacd470bb7c295dbed7756c718b775fd9334b95ce56ee777f60ea571f7f396b9b859d57f3f54e09b4428f97cbba4f62adc719ab705988dd60f93bd234a24292fcd04f16607ffbc31ed41fddc479884ee14b53566674d51fbf0af3cd0f6e1562498d068a6d9c19c72d393688af57579b4d17625340d7b2df54d55acee5654da0547e1616cbf61658386d4e9e268c2884456e18e3e53d37d2ab58753c4c7371de81b89965ad99bd779764b18f9dddc2bf5fe1652299767dbec792cc1b1424dd6afffc9ddb68371583156037cfdf36c4874b08cea0955421cbcd5418b138799df73906bdfda63e1bffa83d7eadfc72a3fc9177859db24c41fe5fa9d9c2da6f59ac044d022faeb3658d3ff983f1a4f78f92a5e5600ca9109879a5777b965efa0e65fcc9376de243c6c8c2659c97b372451540d8c7aaacdc84f2beafc943ac665eee27b1a572a7a3f71ab3612c14a585d61d742420f6bae98d51bf7f0b79c08bd459330e5f2fcf9d3ba328787909a540e82e30f467503f70b78eb941b33729b6fcb74015cf1de68eb574358d2b6445e11527e7b111f9b9f325e57883f34e55b15432301de2a900bda63b87b05056d433339e88d9e39b5b4bcd28042956d720037c55e03c5a17aca25f8ebc23f6c936c117c620eb7696c50a27cc6b8fb4122ff051a145e65dc0b81c5599f4e8ef51e7c8c79498f793c40fb59dc0f5a86e5fa7d2e1cca8a0dd07740f49ef831a482344b95a0a71d4f5cae03632806917d7aae3d03727a8f4abc8c23a81fd1134cc329d75b98323e17d285424a2740c2e33fed1aae918079c2fbb717a4c5f2c75ff03bdd53d92bda2a844ff7cde247de08c1921aaefd6c4d351de1bf928f73ae93d50478695a09543ff0b99d3edf7166fc1547b3925f97309d1cf55ed04ea1a8b9ef702d9e70cd95ab64e4beff0093fda18351fbbeb9783103fefe48ada7247c272926d98735ea101d48fd0ab77b16650fca4ea437e1695eed9587f39ca1b2487368c7dbd824ca6d228d039585ecee4ff30a9ec9ffffaa93d9590dd446b7eabff29778ddb8c3d28c06bec8b362600ee2f6d3bd39a688df4c10383bdbe5ada910435aa77a511db0a08cb750794c4d5f8ce33055977efcb5d0a2ee316ce0f7c712f012dddd4ad66ce2bc056bc795f85d53e5f56376b16b2685feeb05789ba2bdd1b279e4252213b440be63da3743ae633902c1a4ddb2104c40d190b142eeeaae61fa3d63e5fdab0182ec52edd1843b0a99fb8d54fff993b8357f02bfacd9b9b7dfccbe2b715638a9f530334dea2fa901b3a6704eb474e5c663031d1b50a299fc31ff9176912f5eaeea0bce8cf7724306d53bde42c57bb2355ab64bcbe1a76959489afdaa58a5c4018731027701db4cfa717f8e55618940c0a3de519a5a84474673766455f97c17cffb975367a1ab38e2d55de33fdcade67562f4f3f2c2964df7b10986d6ae9e3ec30060c407c3b219acb974768d9b4e145daa15028955bba56bf41043db26ba1e3aee5c8056e46b6352fcc8dbaa65c528b8e70e5cbc565c7bfa9c8bb90e8ebf424705818c9a58232be42b48e6e2c20970ce14bd86b516d3ff0cba91aa99f1efe40a5f2b73eea15939c54e9a7a8df69d2b1ce819db8527f12f1576bffd888422f113800c638f7690151a3f07f3ed74eabe353c641296aa384b142c3fefa6bf937e52e446d446ffbdf2ec7e23fd03e9d94ef07bca5f1adfefe755fafd23e4f922d49788428346d18dcd34e137ff983f096bff929b61319744b142776902d26c4740c58fa466f74bbf0f19a1c3b754bcc20ca8bd75b1ebccd481249eaf794f012c9c26e43e7b9b814937de53c3e39d65863fbb93dc1a2a78fd4c44fe4dbe84c13413f081d1be6c17fdf1061202529fdd358869c8ea847292aa4710709169ec016fa0593d64077c5a62363046de329902be9f314c3ae9bf808a768f6410dd46e683593648b5df16244c707fbc59b7b69ff665a4d43a77b9ae91beafb81597316ab73e5d619efe936c46df26d3be94bfa2ef623ef5cab8f6bae9bb7be5c2232c3ba52f096cf3fa4f6769151561e15c972604acea95b4c3b294f75dbd79ce462d5d544f49017c30fd61ca65ba7fcad9c9d407fdf6c082c6d62800f77d23f73eb35c84d7248fe95e805b21da2ee73fffffc259a9d4cb808bfcfc79b85fe34d39a9912bc79675f4b382703a9d84ba6a4a888e26335f7bd29f77f8eccee62ec19356281045415b9d538a8bc936abb9891d7db01c38f8cb78cffeff98370904c372848366e87cc946a63908a526339b4cac44b49ef7bd8b1b8ff1539d96d196b06902db766e523dc4546080087cba11a2d65a56619fd5d4d048043afebe074aa0f985d263967e6f4907ca82e4ef7a50684a139c7dfa2fb39475ef1aa9478089ebd04ca20b77d8ff59f23adf16b52ddc7d3a4192304ece0e3332172d26e442afffec65aff999bd605475979fdab3a32d908547bd53338e6394204f7032bc4ef2ab1409ea27b9670cb289d6dd5f1ffff6ca726022e11d693294f48de776548a79264f7492a03a43020364d7b2c16e7e9b35d1113689323a256262b21280ba115b9db10c2f4f7646c05ef25847693af1f048b6f164198d552b40e4e34219cbe5edb6c47d6c4e8a6b46cf0f7aeb652e1a2fa501869dd13cd9d8b0cd2fb1cfca2478c141c1e04e92b63a71469055c06023561e78087d3e86223050a61ce0a7cbb4caa637696bce3aedb9b82128ebfb3b996d41aca9b0b54cfad27956589791b48e6bfaeba24f2ccd155e5850284655a1de9ed649695735ae355fd34caf1a09e53506ef65f643d53cd7bfb73fc17fd5aa17dd0f59d391f82e9abd104e9e55219c63c2637b560d8ef4a3850c518587b63be40ce08818b0a2383eb0ff8d528f124c194950067d03936d8e0a0f950823ceb7f66b071c48b79bb1298dcd0399f5b055826e4b17d6a3df7fb74e44c122f2d0ab78a70c656d942e65d27d1f315596edacb90e9ba26c40291b16c57372b6c90d8ce4c3583017be2f2f1b8d935e8f12529a465d62a55416a185e0a6b98d6f0502b65256764b88b111365e37dada1c946c105fe6880f8ef9cb765f9e6fe9579c0361ddc51cce4cc5f670449378cd893ca879e2a3462b59f05fdc8e9ddb4c210990e2b7d7d19dac42ccb42fbf37a8e5ad333c34755277ed3b1e7e8aeea0cbfcceb33bbb6aa133659bb2205d51fdeeab903deddb7b0a1891f0e8d9fcdec63da5db54f88a3f351bee17d28bc3379173a51b46c94fa87af7c2e681c64abbd241e550c75f1fcc628a911d75e0d368d83089fd051fdc85d1b4ca1ec227a9bdef503d807c4308ac9d58b0d7b5a6df16f20c862372e0f153bed0f2103ee475b67563fc7c0ae16effb5efc6eb2cf616abbb15ec6ad7543a4342e6812d5a81925914a4711e67f31e1dad9e7f08cdc053165a24b15835fcff7063f2ad822debe405ce04ca3524e9973c98f4922adc6b26428b6961b40732799e8df3f5def096ab7617beb79fb1bf23f6a4f9157f9fa7d63bffe0b8d0d671885c6199b321ee88e12b37c7c281eec4b3e045aa3e5ae99c4a0bd005ac4e5e2a8451d1204d3c6ca8a25c040c11d1fb7e5e4780709b618ad74cd5264006811bb334f6a028cbcc2f3a99943cbf8b0817a2496250842681d9b3e956f2c212df164d85573864afc6540d2cf9c4ca9592145636039fb7194494179bf27b53f5e6d47dd4cc483d9d7c92b39512d9ef27e495482e6d7e3bfbf625183e443570366c8f9b9b38f41709f80f05e445569fb1b48832fe6ddb3468c22c0a7bc1fc50bb7d472034ad2d98927eb36d82e9f3ce20dd43ed894289415bc88f33d5b252acb4461f843e01400449666c33d85d6e5e105ee7ffe4caea128f5abb04fb4e845e818a212d08d1372be0a9d739f03c9a879e8b6da6e1704a5cdaf695d2e4ab2dcbd1af75159a351b0d004186c0f2dec0950df7cc874aaf85aab7373f27b85da94cd8d80f44ad8b79f784942f19c24a75f110234689e807c011c0ec497fec172ecfc3df45d3eba8e2264c3fc04a5166358f439153f1bd1fd80e85854bd70b4fcecd4ebd1d3fbb6bc38b0ffe94d2cc0dab7d1eec76ea0a675eba8ea75c1258be91c0fed91f95c1f3ac654a090c100175792f583caa761c3ab6cab5617a361e8fac85ee0107951398ae5a0a78fefff242a5f8c5fc4aa595ba11b1f1bd8d8afffed99140828b28acc60e4ffdb8f39966c7372f2007e9b1cb179b3dada12d18ba08841957bc7668aa24c63bfedd92089207f07b8b555022d86578de9cc1c21011b551feeaf333725ee533cd195963ce42fda0e4bc3605549237472f7bd567d16414ace669b195b21553bde1d8c664947c81a9f1fcc7e282b692a7726734c63f7e3e8e3a26785864c92fc7ed10ca6be8dbbbcbfb282bc344f04ea0d6be87c9b466c6c7374dfb21ffd0a2534bdd290572b0c50e6c91426d6ffc6b884797f5c6e71dec7399e8a28dd62e4eb4a17e0e5d94fd13f068cc099f55b669154d8e6993606dcb532000412815f7f460caae50c4b7e014389bf1fc00bd63f68908b01304ab78c0c85529f20efd66431366b2aeded6bf56343749b693bb1414d95225d8c03271b9ee47385d9a735513895be060cd291d038e81468959bdfcc4ce515dd8b6ecc2aa6cab9807aea0247db2974c8542a301f4e15d44f3f8b6d4d77aa5014a2cbfe74869c6beec5b8901db10327eff869cd36db43ffe737e9fecef97fe015ffe9a7f8f536c038618eef53be07797685fef3b60ad20f2dbe6be005065c1d5d2ca43a08edd2c40ccb06de4c62568611c63bba4e9f035e5835d811516389a7bdd6a975cb918f2da9fdef8ef674387e77dc1a8d15a08015fedd5fb77027a63ed0de26bb1d6b2babf9a3d3b7911ecafbcd6f35a2d6d8e78c61053122506135621eb5a8804ecd72d919edaea349179bbc640e930c034ffe9f83c869de1cabc05044266cfcc0e1dd112fb9c88f160b77dcec8b30d2b27ad7ed819d89097a4ff08b3df68e4fffdc371341e3792820434957fff0a8d4f865b55df014a6750d3ebc9d6b206fe0e0c60056272dbdefcfeda528420d558394e38af544ef081de1084797e554d69f1f5acc252c48edb5457863d8b93cf995bddffe9c2176bacf38929248bb4c35dd5dffb34b566ef032d4c97f2a085ec068957505f3198805fa5f30007ffb7f543ab6ec637e9ee8f630180f614055b3903f7cd1a52ffdc2fdc7a70ebdb7d8547b0000fee708ab6d430a609c680b8953da1245301f47dbb45db1170cfd1b6cb396783fb1ff14e8d9a99ec67eb27ffe1704ff586fef996b6b104d403fd70edcf8b9897b68e878d2d9577717ce3f34110f3b55fd39bc98afa88f12e4e5917686164c1b410ac289b2cb8cd6c4fc20f256f5647d09d994b066948fb9331c7e75e232a39415ad541a3c096311d90d4dbb4da678d2c487c991654443703e4a9781d7c83f779f13193dd8cfd94a4a61a728578a6cdcb006cf41daa8ed750050aac8081c0b2d7f699e6255a5659ed066da0f74740d151caff1b1e1a0be29d806c8ce400da391508d8b43e052bf9095f09d6f0cd44d81d4d8f1fb32912ebbd0b83c99c9a456963496b75c584c77367e807ab8ddeb6830bcd67ecaf5568e4cee0bbe46b15b3cd88aa5f75b637cdd2b96227344e3f0b168e6e6a2811fae16f3247ff3f95a5550aba57735f6ce1e7754e12f2141d4848c68c524e78ffcdae4b2d29c40665b1ed51b191f395b7951c5fc400cb93a09aa2d5971074f904c24d643609534f7f3156340947b0ca2a014aaa36a5d7124297665981870498a33b1c03f6d0a764689dd86d09a0d75efa4fefed243a999e15523d7752c42d57baec1edb5debc3ee3d0d754b460d30af80fabc7f0092a05645f25aac6f2f1fa0090055bef379b9ec0dfb78a7f924fd49cd26f44d3f50d67de712a25e95eba0f10b48ad030c7dc4bf1d6403b4a4cf424597354ad5c4486fa2ebe0647c999d04bf2686f1519f7d5fb2665d333567bffcb8e051be29ab0f1bb1b59dddb34ee70e08317b914458b2d7ca0cd73f2c7718f272825c958f8fb93f6731dc02ebf6ab004cacc59c0902952ecf06d54bff23338035d7c9134322b8d65ef1dc2991533688da2e328d3e1098ccfe242a439a8fa3ae286d5a446c1be6768dcc3c81fbaed1b11130ad588b2aacc48a888d9d01376c478d7a549fe663b4af74f90c24c6b9c9a6f72288b1046eb581e9bd99ea126902033b51a9054279c5bef4463639ad718e57b15a5df59b293fd3c1626fc078d8327c1ecbc16ca805bd24da397b6be559129551b93376abf72a8da383dcbbe27208def515b0599522bf48a9014e4f629a5d90659f10738897ce7e559e72940af22d3791dc618f9a49d0f71e27cfb635a1a34f76d8303257a23f4e7e82cf11e3521c48d246cd51bf8352e65f02df224b1170002615c10defd84bf53c04876d2915f9268b17ec60268dcacf413bf6cd5cb3b3828408a1a51d1244756b54353a33af96a80fd3a9c19fd4bf822dcb59b6fa4e643a8e6c7aa7520b69e11f59e98d8b2796e2279bbd68f036a5ddd190636cdf70197e8904467ff9c65491bcfecdd6442cbbe14a38418475e0baa5d2dbbedec925a643ea16db5612aeaff9ccb371ad187a1e2144b945e938ad8957e962c97570db20cd1899ab81706f7ac2324d6d434b1e9b380355d992d816cd5ba6a4e7e2051d49321f6e80fdb4ea19ab4afddb390deede4f8348db8d4ab1529c71d1dce216ec6f20beda4946ce5bbc63e7d1fdf342cc3e058c68c17d617340ad679b467a2895945420821ed37bdf4a6f0b6c1678adcb14ef36c3c5c85088403f1cae07721943d2ec3ddcbfc65bd1b4903594eb3465aacc35f8becdfdebeec21fc5e5e4ab09458d62b4c206a99ea89b7bed385c1e58e1a2c6da5988de1271ee56e0bce4c7e01b96cbf9a5c932aa4be2cab9ab3bca158697b1383ee47d5228c15b77acb1786a2e65a57f9be66faa3503afa98bfb0ba551746685fdb62f20438663a40507e0b2ffcb6970efc9f0c003bea7fa76dcbcb6f8b4868a036327942cfedea65a53a7a0a0472c6ee456ca07a11c08c6d4bbd24f1de8d3905d47bcbbdecc85dd0de7424e34a08e478f2a635d4aa0c615fc110beecb96536a64c04ae6d654c3c1cf0eebe256938f005c74b82b8a7c2b26abbcf0a3efb12787e1d05f56a38c44dfe7149dd9d08cafa97fa284470601d6e51c60beac9e966aa8fcf1559eb05fcba43205c1090bccb22fdf8e5c3da6f5ff9cc287fb80b85c0c7fd9970362722ffa94a8031f4225e1948bfe6afa88c8c9a40eead04682b07d65d02a7e2bb9a6d677dcbf89c9e85e68f4df27697142ba440503fa5bb0f95fa1bb2eaaf74def9fd90689c59b00f2b1cd34b87cabc3566935118e9b1769eaf10ba9bb2a55894abf8467973f14a35abdece23cd0e1fd34a88a94a5bd3a1c1e67351efa7e8b7fb4df7da7c758f43d39bca0e75ca4bf37e1f7e48d415633142376467861190b3904e6b5983c08dc4d5164ad6373ad747dbde41ea0c086f8f0fd2e90f1701c4f3ee8e0238a9ce11bffb96178bfc5af90335783ecc289863d9d8ef2e8e6b5e36b70e84b995d9eb846aa7858537c3f9aa4f7c4e322fa704101c779266b583fc1bc134bd4b6adc44f8b72cebb1dcc93c82f47c6815e8bac9e77e48ac9748f54aeb4024eb95db5b09087d3cc3d628b1c75cae6607b58e96434ff676126d39ad30c827271c9fe07d8c097cdb9af624bdd0d67ac321eb198956ab267e81694d97f7adc5f805d4b35a5d6a5f11bf9d6185bc4f3cc49a7ecfbf4a6a6cd5b9cb3f9f2be3cdc2182428a0cce2acde6eb29ae9d19c3369d8413a58aad3991e3293346d6e8eb154ed7cbd916b525886a47b7af21b73f12fe164a187d678ceb5c36cb63e6ad3956bb27c3a21d538cd305192ae06fef552a9b200ccf23b23bcdf7052ca5c3c6d2d26085689a23ba895a4bb4e2e823c5669a096eebca4dbcb475fa2d5c49defd80e4b423594486bdc3afdb0549f8c574b53d5dd392c28b18f61a2542622782450a4ddfebc1114841b3a9b907bc6b8c204f080ef2564734dc545990436dd487103a149b913b7eb0fee841c59a0272955d0930595c8483a9c0da62511cf690ee344e5898db10b8651e491d90f6622ff8d02be7dc12633c483fa7cdce21e696df95e892e2ab84c253d96de72d758e73de71c6f330512ff449d6d32716b952b26cdff1aa5d86cabdc765693f31825c30c93fa25ecf696820778892761b8d4ecb26986ee73e3b144344cab26fa9dec9f2eb414b4355f01f74a89963da90c3c9e0dd17f8a6d2d8bad4f77fae25298c9c9c19673ad7836b85c3ef22d4ef0523b157d8d0adba68d0f195b85c4b5716990006bb8b730e0dfd196a2595337dcc1020199d595a7b96440d95f472b9b8796b13bfedd88fe42a89e65e7fbb31fdab5820061beb257fe7bf35882a152a97ba08c6e4975f0f05635581936da322389410a105a07db78a9bc9784b8c3033b3102c4efa26757d77a3e0a79e5d5e39c5c48125fb911870a1ce4c1cd17031b07641f89876d3ed9f715570f96460d03fe484a4d40790d0cdb5861540eb5e95cfcc3c5a23604c8614666a0c3e559912aa061e566e10a4c3c998b054a4a2539bfaab72487f54e5736e3859a06c6a4593f8b79c7b494c355b3ce9c3815cad5db259ec23468aec4181085997d9032e7ab457769ba2f496cacc65fb7fd0ed9942c7af66b932e126b404f42399aef9d2c53093012533faf1b260e5fa92e6ae18cc52a62d11d295dd4ad77919577bc66167cb86c110e938d7cc2f839a988c802eb883f534842dc642f8b8bc2a34e5468a0b65e352b6b0b13718e348595171b8850da88ef8ddd11a26141937cf10628b18ed0b2bb7211aa2b22daf9643d48c18dc43a42b7529f8488b29563230bc86b2ca1702ea922b0aedbee823518f564687ff76dd341c6e354ffd46b3748bf97b3427f1549a4dc601d4319ec1e37a363bb338ce0cd77edc1df49b6118dddc706eb8e0de82e17d42093212734de81b4c35c6869b9d39e4676c3de8be76cafb5ad9668c23f3c50f0c916f28819a9a260c86eb169d8e312c5e7740fd7a6beb7352e1097869d1822f282dd44e0d1b00809db6b01a36c3a616c3c562bebefd03a887910f28d52d34648fc4014e949b2f821ba5dfeb5afa7f66a7e2d7deb6bed1b16ae8d91036c12715974fbd200be655b2d944ade3e6ab3d438b3b977a9cfe949c32163ea1f8b268a017d37f26548cf166db42b5a0cb10732ceb7b95f86ed457c8d08f5da9ef4383f8595b186ac48f144d87f58c53ae6827bec6d2a0df52339037e7390b6366e49b4fbbfdc0baec82ce5f030e6653aebd3b763d4a9feb212a2cba665be13aa4b0f6085441f22cc53c345312625f1fca9af08bd79348e891ddbe5fabda8ca65b98387057b70ffd4337555e242081dca2a73d4db0b5dc2c2be03cf58a31adc8e15661132fa8ac80d9ff5928a0a05548d696624d89704e50ed26f692905e5841aed09253fa14aabfe03e1aa45fe24df897bfb9e5de78f52c7c7ecedb096746f6edaca5ed6762b4fc7c7d6b47414be5a0d9fc58361613b3682eebd81229220d5946ffea7feb69aaca9a39fab38234940bce262737baf392f4801de99e190465b39132f0b4eebf7771e0d07d6c5ea9dadf358750cef63e989822f16c3f70109fb29501bb593161af95eb156ec0b1d5fc0c2cd3d62cc7e799d68279fd6a01de6f1b1978f57bec1311b60bac3e619ca9ba03c95828d8e1ef31250ba8298b63f777663220f1d55d48053157261ab69339d721ffa278540d3e12acce189554308e1fc2b39586b6d6fc7c81173f8e44b407ac964e287ac7af5571f1c5d74f02d42320c6bfdbe6bf613596bd9e2199a2a184188409c8a656891ef1e25ac51ddb6c285ec59b2af56d1feecf53f389983eed663b1003ccbb0bdb26f620f18524c547f26a33cf6d3014e4c654623e173ac1bf1fc60aa0eb653ce2c6746884de0efdaa6ba531709a134dc068a4a53589608baebb3f62144c9ed44eb8731d69bae5bdba70d2983135c5513ef62064da1ea0c29b887f9661c84a4851a7134be9c81721ec66a48919b74a891c64b0685abb50f08a4f3fb2f5dcde2b37aa91edd538c977cde098723a494c4fb54d345eac70433be2e418e5d0fa028b0e0c2b9ac76558f4fa4737217b965c79d8d8dbbec9058a9bd60fa696c5aee7a5d70f0e5e52c2c2fe9ba27a782c9cc96303f6af24688d6da382982d48d009122285fbd0baa8054bfedf99b1f3d831715028072bb3264e1d7f329f57298d3ee48ff6d8c2698449bcdf50637df281750e32842ef792cd2f805faf682072ea19f3d63e567d972760d0a9c1d789a83c3a04ba4e130b7abc9a6bf2e5aaa86b8ecbe60d831d43f94afb14080a2a684709b872557403589b51ebb808ba3eeeaf790fe08865fcaea4dc06fb349c3ca739161f27b0e0d2e02772e7635603a6cc73b5cf5e67cc48201ff64e64884e576699727541ee8d78f2a9ce3cfb82f1dca0fc8a1c2ed969f8e4072aa4409ab78a9cd40169a50145f61ea3499882a1c941ef4e1798ab4dbfea316799aca7e4cf2c5091603c08b558650205053d787f5d5f39441c5904d4f771e4ba9008bc9753c7058da5241f9f9b7226c0ae90a2534eedddf96def434e3c6357b40c758b8cc6d5139a65cccbf335d7c3a1d071e07c30942179764ba06e2ac2c8a8315e6c75c78f4119da20ed01342ea2173d0c7aeace1e5035677488754765f3c4146ad7245b34583e0d4d385e390bb0650e456722457d80df0aa8398428df1450e8bbdac12b46592ebad79d6713b901ea7bc01c6400b3f00ad49dfffd7089b173e240449902b4a51df171e03bc9ea77afd5efeb7a49eab3bc42114e8b5db6f1303f8c53033e4ee7121737997b8989f8a0a5a44b370ee3e141fa3e5727fbe4cc2b73d498e3325c5abd54781ccd048a40fa50451296758042b4a6509cf46abb711fd3c543e2c1098bd6896e9d99c7ef842dc451d63af329be331bb76a67a6f59637668e49c324f718b79f629ffb37b4451b9dff8b9f16c4af9d681e8c2ec30cd68da5c81cddf874017c46a7f7e638cf8a6c6e293bca31538257fc16179ec3e31fdacb6969d183d34ff23af4e968a5ef14db834d45cabbcc3bfab77597aed8b4a08011c0fcbcda410832e0453971af73acd6a9f79fc6957077932d324792b550d305c1a7d8e3dbea814a0604b7163bfd578dfdbcf53182009337314d56bef273ff93edc9f64c1e3e0a044638e889411e6c1a41a6e9da5c42696f5413cdd10390f440a2f787a49c27c8afb38a5d0b20157e5daaba776a07358c9137853e5c3573f8b4241e75bd99bf5ee519119a07aa664b3c060e23333e858188e69a34269aa0633b4c5bf8203d9cdabadcee2990aee6c5c8ec110b191845ca0afba1cb496435c3b2b0c641f9e587eb078727caaf35eefe4e4a737e8702069ce46c1ee04410046e00a7112fd3999c5de5a93a46dcad66728812dbfc6b2e72d66578caae95fb59a24a012f974b3806a4f18164d80446ab471b41b4a11df0a4179cdf268efa275685d855531e1dfa3ddbd6ecd5ae2745fd5d0e993b1b486a13417749d2fbe7ee884d84d58af1419b2f8469343f964bdb68ac33f60010d8ad9c01b8a52ca85f6f500d812841c4938f828ddb6f4eb23bf7b9e2b7f0bc73d243dd505c2f62aefcccf9c97a2707568216d34e4880caee76a9087b9cb91af7bc4969a1ba9e217d2b93b53e7f71790ac2ea8975a49a03560040264753b709dcf0480307af09712aef37fd14f682bfbf39d2d52581024ce9790b60eb90cbef11b01f3d9d897dd811eca27624ff9a09358d5192c3055189beef0745aa162f53cecbcc06878dd9f845f05ffe14982217e76335910ac7acf01d5668b1d465a36c3152d64d286071c028ef3657adfb843b2f28cf4e3941b4e5d47552acb7f0d1fe0649012474f81894b4b1565a665e3a905e4296b10beab92ddfdad3a9b03948812fb6beea14a2ddcdbc60e97f8ba9b7d7d9cd4981d5b43287ab127732c45310841162afdae6ee2999b6f8f4ec01bcc3ecf9544ed9ce41c1c7d45df429b0f08aa916a52c89f9c89f5ccb3e150b2c9aaed94e1f68af3648036439ac0b5d6cb1748ac4a77c57263652524a3fb43fd9e8fd6e030667acf5f24dc2a31fa383815f1fbc9c9201dd7962b7e81af56314e32cc720b572cebbeeffa19f5333b1f12fab84056f8198ed36755ee9292b8a34935e03503a340aa77e1baaeeedcc91f121d5116d06684833cdce434d0409e7875af43668ccd88aea084838e345072184faf45f0f7370f2053097d493245ca0f91292f537e85719f44028805ee640a734a71b18a1f15c748d5a526fadf5f19c1cac293093b3ce0d2b462836bd9b86a3ee0178213f1e967dd2be8fb56117816ae6a3529cedf09ee9e4f1cd2ba56e1bf9a0c77f4c2acb465b2e48a55c33253a160fea5719f5a907c47adb0a80e6128b3ed4be26290a7911cb79075b648476b1e26e3d0d7756e9cb9ec1418c4f7a4f543087282623d1e2aa0cdf9062d6343e02e9c31e56eebaf39a67c6e99fef269cffc0c7b5841f9a64d91451e2063b3ccb0ddbe8ddc20a0a8ae7292ec423b45b036d3cdcbe8029acfbdb61484cda19310d6c117af763bb8cf71662d0dca2124e3434590cb1c358c8c832c28d17ce63a9e1351a4312612a2ae89122323e556ebbd4877e62ec1ed2231b70df8c6509b64e50bb84d1f6565a5040d9dbad02bd6656891138f202454d1c4721a35141edad591e3c072e76e54eb35d699f423c1bc699f623fc6a9109f7fbe2e9246d15affb8aa1e649e3d56bd628893a3fd2ebd75f473e8fc8ce3d586094a45eb32ced016e51ead88f38bb8011d6bd32c39e394883f238ca10c85faffa99967f69ea5f95b4808b3646329e4274ced23739943ffd057c79b24a218eb82ebf312351d2ebfeed9739ed9dc9d013d371c95a95067b2dbae6889c5c40dfd8a5446b42b6f04bafb5533d9b32ca2849027be064d594e90d94e2d141ee5ea2dc301b169fd1ec6678b35907393ca9ba2f18947bf2fc4a644377ef62162baf087100477fc5f60d3b352c0a20eb7806ef273c31fb33e9f8f1c16c23d4e48199cdf146d32fd3cad44a14e906423ec3dd87eaa9c635a71fd6700cb163bd8cd00aec7c34d398fe2937c2f83a9e55563ba2ab884a660bcf4f5bc0e825436507a0df45d2bef70a39c5ecdab27bd698622411dd93461e28c5cb1bcf216d6da8944a594f71b641a26b62b684abd74cdd1aaca7fab0c7bb07d693ad9f434cde51f134b282f9095170c04689c8893d4fc9145f661c57c022c9dde5497c477998a13652057e2ebde05229c1cbe63abc091bb9882a6998a3bda8496cea63165e6cb61d14090650fef229bb78df2b8e1329ecd408daeee69ad1f7f2b90264c619ef47760b2d14eeee0ec92d4190ad502517f6a44cdf4e4deb45c4c455ea67c75da6d29efde124f049000980030b11b9ddb26be19ccfccdbc21bc0a82d29534f860ed55eec895191c2f61b5ec2a073ad6c9d9c18fd543900e1aa580ded3552f3d5ce453177945848d90dfdf250876e3914297fd8f545d9d63bc8e38328b24d5ae7f92709be5893afbf9b43f741b83f8cd3c878340c037d25331cb69b227d1f4e886dbf1de0917afee72e1ad8d3ac5c0e27e951fd46926385e50c1c248047a4c94c7714faab00770ccea598ba79fdf65b3584fc4a15b9a3b8a2c5bdac80a6f0575291ef25254537c828f1f9db5371392a68b0687e2a85f4bd7af84ca61a2fcaa7576b81ec0b4acd063a5e64556ea367525552ca7c06a0ace61dc81665270f0ab40e468006ae947dbe2e50e7ff39e67edf2cb688a60af3b7a41f394278fbfe4105576ed4c64d58ae9e4be3aa471f7a975af7297045f5d10dedd90edbafd3600a40548f53bdc47f3ffeae9a8a2617dba33233802943a0f5a7a09f0e5fbfebc8c3b4975dfb4f345701a6b10682659dceb84d1515f98dec3a0a44dd1f3eb14edbe8a4054d4d8bb3e852764c4544cd36ac85f0da0b192da220ee5be69002d422f4c2ab6a9d5d08d52a53f6b66ed1e438ec2492547b52629681dbd31978338623988359c417209e2c33b87ff6ff7db2b8c726049eb49f31a3a70b7d0dfbc212abf03c76b678de4a4ac5e2cfa0d9204248928d68e4fd5833bd83b3a1ee820ffb51acf7ef64f48f9b4ef55bb57c9ee11b60d980c3843f433ce320a319fb9d99cb806a38685f975d15a8bec9305971c53808c4b3c8bccf952865a379f7a89499328b1d59042b621cf61e58734bd7c53647bddeb91613f17c2b08fcfa1b7225512c3a1b412343821d1515317fc907d3fb029e4429fdd5f5fec369a455863971b0ba9e50e365810976429139308ab01f58e8e618f31f05ecfb3695a40de8dd85a9b0d0bb3ca9d20695d644fd5d9b2034eec9f1af65a803c7120e1e0717cb7765dba73124eb88b5f50a6a084911f66688b326b6534a7b4b029296c2747652e9d40746ad28fd397d73bfc2a73f470b2270124a36b5ef375a83d3e14e3ef30c85e68dea8765a48f768f981e110e192648e448a42e50041db1cda2f3d67fdeb4ec3927ac0da2d107921363b61ae14630b56d4b66edbaa5f0a6d7bde6c5acd077343b7e16a39d51109c6d90d2251b80f656518af5d91dbe018ab0cb271bc9500ac1f4d9ff92e36efa90f4ae032bf42553e0935759cbc7f2fc5ebac2f3d137e7c06c2e4456df480fb222ff74e8590fcf5cf50dd917fd1bc6cc14a2430aa9e9574c4457872a61bab00d477aac8700d1da6a2d2f9919c72771d18f07e62b1aa170906ebfff3a72e6cba1801bf7fe641a6dc0712eeda22c8f400a42b85d913ed8414a855d5d7003020fe0288bcf2de7e23a987c1d7a53742adc80ab93d7df4fd87541e032bf921339e333b8b4aaa4c009ce24c296c55e28fc54d5e752b2e32cb86c144b726d10661e269d470a0715a3832fc02b29d9b52f8af1c2a480611cc20154f37f99adad04d48d74da8d2c62295ca1d24db597ae0c876598080612c662ddc50deb722658a331c4a0e1b44fba094f4f2a8b7beba038c674a19ff04b406b90d2191e9846b877541feade16d674bcc563cf4124e70f509c22f2c7bcb02b5963fcaec022c3b8974f794e74ec9f8da09776cc6d67452f501efd233359203ecff45c14bec39fab04f895388c93b29939071b2acad2aa788da4db5f61106e420bb5c6a8b3586b3c9fa0d3d2daaf61464e3c5818c1a886915402762cd64026cd689ffd66c27cb1523f40ea1462f9300a30bcf7f64fab7f4b82a557d7ea2074a952f4754991cc2ebf721f555361308970d63ec2ff1f4efa3097e4e911725bc25542e84d5e8a6366b5a6a06f09b93c019dfa4506a65f37675089527b70d63c191460abfcb3454de66a2dfdcd31a6c9bdcffc968f415ecc7bbe7351f53c1f5666b00916d7677f4f0d71f6d698bac27fb191430151e93db7eb7dcd5d175036e73ecf6ab3c4db3699964ba3c522216cff16296986134ddcb25801911bcc78742a09388822a84219c16bdd51176ca415fd770aea59d73054e16920048ae293fa7c17251c49a3248f24f1a147a3a5afed38e847a558a3e70e85fd35c35f735a65dbee3c76fd9707661381eb7aa074c850d6f518edda070bad1e3c326de5a18d392deab4fd0eb2d4588d7379333ea528cf63830530e1dd2b5d1265d7b3aefcacfe49f42e46a03dbf25c8760c2315c093ca3be12756617ef4669033ca95888538700209e8e2f5137b082718b9049eb0b6292fd5bdeee225105eb956d445d0df6799209520accca61c75d58198e4e8329eb1b579aee5ec48c015d9a4e76593c253cc2eeea14c1c7ff900cd42c6a363fffd9abd33e75e5f95e37d545ce65ac040ed2e0195bb7b0a5aa720e2c0f4961818547a46ac0a42997cba71f9af9e6439daa1bf1a6987e8997c75303e37ac8fd58aaea8a491c772df547d795e976ca4717028e54734bd908271045339d554d901f55d9a18064b82d570c0ba8d6584d27367a021a9caa6c8309a9ee18a5680be6eefecd7011b9106086a1266d3e7c27aec085840898cd8dd3b17b929eef55e1ee91f946f2190076a19f76507533a787e080a5ea28d614c546bd2c274f3303da576562c662a33257de2e2b9682f343635e8d72906391e4edf33606ce1f2c02c77dcc60f5afa3eb987ab8c1cf5e70c44b124e6a1289ca82171d21422f39a5a3f4e9338d22e028a6aa084dd75ae56c315f7cfa6552a926d5d86462d468a02392ee76e9416645a5d5def9d6763c7b7073d9aa08802781f2c01fd998638a5320ce45a834c393253fce622ea0708585ca8c0adc89cef25a21f3a91252cf90daae11c94a62598788ff4f854f1a8351825ebbe2adb50220f6b45f05be907122d2d833faf4d5ee1e818b6da9ffabd9ffaff08e91b7e26fe8c809e6c94f310d00d1adc039b1a2a6c16d7d288f71382d66f5d8bd81d634d3f1c9642b2e3a97ca97285cfca77b56b5040ecf1ac35e21868994d7638ff4a36ee43092461f4f2b7dbbf0c1981256266f7ec5a606d038da0c2504b29abc0a020d39ef47ffc1f4bd2f9f6b141ce3bca345b795cbe7a946aff0dde891519634dc6b1b45aac142973b61ca54ef5f0370a05d16f7493472ce83e45baf41bca67b80e388edca9fb26d593abc7e970ddbc3a935612e0e7bd0c1b9d1c6c759f1983b71bef94e4ee8e386c0353d8e1f6e88bf26560800dbb3e18cbab8ddd22a7a602070ed3a73c11a6f77ca145e0040e7f594f0a7e64ef7f342dbed59078fb7d98f01536926d4ec3d13193fde0454b746129bd941bf71cce9d850f891162136472368d7968c4b4f3e0f9da37bea221cb66b89d20e6db4c1fa27c86d68b0b2a1c1d09794d3ec0b46eaa581a25c8bfa613289f0e31364f650669c5c468837c8757607f4c5347298e4ea0dda4c6fca1dbff9992c98e086ae15cc25755e4ef165d904a88e274be718aeaea7e5cb8b3e7966353a9ec4ee5104af79844d4f80cd4e436b2c8a44a4c6f55dad78db3763f55f46d1f0d16c157f22468f00fbadfde3ff17a570ce0fb1a1369b973d519118a5e28be30296df09323b4b46588357c4a303a106d77ab88e945ec691ddcf7a77d5220f3e7e46dbac975cd80af542cdff3b3b45fc8ef5b7ed96c6b26daada1043a77508456d0af9c29d90c8077070b279043799008b5c0168bc1d85a93f5fcb983bb67b72d18672ef429fd602a07479c907ac1f92e63016c415f86f1600dad76251f81437bba65b3f41c9e420033b6256e39de19fa493e20956bd7196e9f67a271d5a9df4d9359bf1cf454d43be9dc7b87ef47e2d4eb0153a99cc3bbb98e70ea8c2ea58fd2b5a513be2166d444d5f29699f9170a00c7f7d1ede6f30631a1584a67277ef6b800bb36e21e41dd2796baef95f4f366b0211568bd2aae4853102d58b90f6bb429b368e9febfb7681d74d7bc78fe98e3e63ac9d32a55e7369c1cfd754aa5d62d1397cf96546ff8d9d7ab7498751224e21793de664856b632b4f37d1e3b078c1803564d63283fe4e3df1281d68f2549c8340837ea59b42e9da2a723a669953d0467801c84109ba26bbabb76078ccc05c580580872ca425a75e22d0eed03b07b21054436ed222bf6ec4562385a8eaefe8365778362583b1947c63c6f0e8b7b45a5f1e56c67954b36b3b168544a3fd68bb532f264b372a7fc0a41ce2780c3b368e653dfde164b18806064a393469b6b680242eaf96c1236b8fb1e6d662b24ae60d73a8392e682b7a37e72daa3b407cc1e0cdb76788fbc97e882b514e82cb6b225ee4bd282e8084218953151edf469b94f9e3363df1c5640d8f5738dc9cefc86a95bf96dadb0fc0e88531ac3569b127322bfea152c997f674a6f1ae418900bf9814a1fd96d208c7883800517b63a7fe46f9c9e521193343be3652a94fd28d205d0232697b801776a4b28c49169d9d479e2b0316b59ccf1d32f91d40a6622e048104a6fd995ae611296809bfe12755a915d308602798fe6993f6478bf33ac9e9eb8044477507c870f9c8b60875e4febbc388c17d4bd64c3f0d5ee88a5d08cf0646a8ff13479b836507ff65e728a0c2399c98f56321644037b04d11476a760f00389db6f139dc1cc4f616121c923454b0823a6ffb8e77cdf9d5018a3d0735a6f2a77923d69a0c881c4e157dc127fc546e27fea55c09574d665ae66efba4a3ae1bcdd60b05ed5c648bbde261e88ec2fbd082d2f900cdd063b1861afe37a3a19976b6cfae371697fb118d2ecdace3e2fae99452acf51a6ecac75e959657e75bd4160b1c6adb20570ad5ab676a9c6f4f3cd5c51dd7f7c52a546715c3a6939a54c0c5b2ccd9a1ef3b1b6a70eea2c92b077ea9478cc908a698d46973ba98bca2665f67ef1e8f949bcc7da5aea101d4fcc51d9e5204c39978bde68037594283b700c753c30d109d0a8c8dc6ff7ad1e6b4e5788a3b8462001778a86307a3b627ccc405164196748fe4216220f38be2467709cd5556a709c052df4129b7a2b34b531984107a12bac81206a61dc5b0bd94394668db78ffb8eca303510a84e573895716010a676b414d37e77d13a861b14963500a6c1ae9bc9fa1e6bcd12f528fe240ed474caa305e42c5678a3f10e6b89233c4e24164b593f6e8f5723cf85ae52bb23c77e0b5ae594a363a07024367c4ef6870ee81c63f21e184ca2b7faeb6a4e8a094b9831f35e52c2253ea3e6e2a1609ad5a7fd1c8892ff2c7c435a9674efa50698e3810645404eb1a99726b15461f77e83648aec19b9356ce42db91149015973da2f81e417b0ab61f1bd5a32a436fa96529c9bb9ec4790a96bb57703f32c392eea78e4ba39078243c926982da0b671a84fcf3486104d15d5e690c67c6e07dbd61207a9e8595c4ce26d97a8e55d2d3f989918e9fee3f9abc24e55245d808351be710b8d37908f0fd26cb85664a76b6af0a6957494c753f3549e1993942b4dda8219f52ad2ab02a6c83e21fec4f4a22bc737e65bba7b4645dafd6b319c9c9d6bf3eb7602eb3d47043b86149185debbf066ce7232db7261fc11a54f660639a0634c54965a247f9dcffd3346c9eeb6291bca708c630d3ef92e70a70acf0f74d8cd19a9a6505e575ad2c3bc7358374b9495c5e8cb089879bd463e80819150b1e4b51f6e0220726d2ab8d96f1f107b5b4fd3a9e250d2c0c57293aded6bffc50ef691255644599f319740d7dde13658635f5e2a3477471379a2d0820e21632cb6f6e41f042010efd7f2e65aa53758fee1870ecc8cad46b0d3836dd69301f1b253b35e3bce9720e1e172c54a048a23dd0b013d84c98b0e880f530a8eaa91c813daaee474395ea45761e163df9be63d4d3cf9e26184dd72100e6f5abd5f7b505fba58b8f8ada7742bcd592b62e73b0d2a8e0808b368a47f0c5377caa78539def392a5ae535fbd99fefa2cc0cb4b92872f0a02a025d48e5f60e9c88b9b3dd6b7031fbc4509399d3cd1cf721e4c599be7a50e62822956c447110b2cbd1289e1e9bb41b8b76daecbfa75e2520acfff3a9b5ab3ccf414a496419092c47e2dca655a4eb45ab0ceec9aa2598f4b40b941227d954d935558f14e3a9591f67e88cf6f690e1d5e39c4de49d5bea863448499fd4589ae7b16afc2b39cc10a9915d11cfed1ce79e85eadca2a83a543f8054827476353f706ccea5c561b0782c9b96af995ccd7d51d4a7c97f5fd389e680a202b57c178629e18506bd43ecdbb0bbc0e85adb347b8b139b1bf576fa8a06d5947dc91ea1e73ebd856eb53dc868950658fb4ca329a6ff32d71de3a015325cea93d66d8fe976e492c880a78409fef4669881deef784fe20d161512d76d65dd7c4572a971a80c5f6ace4765679671ae7e1463b5fb7575b5e466231ae57dc6694e08408cce3aed1355ff8e8ccb64f90415108553d63c97b9fd924fbd08c358d8e3d1ddfb9b88da2ae58fa29624be07a277ac8d6220d479eba573e0e469df5ec11a614c495f34f3c32c9e37588fef07f7884d9409ecfd7864b782aa3388dd04562f84dee46714a63f86427fc0276ec4050d80982cb0216763577a374fa11444b8be553e104cba4fe5fabeb8fe0400f56295f91943806f2bf82b977328ecbd20c4e97ffd708f737b2004c3ab3541b4b3e3172a03935dc13030a46aed99cdd5fee14a622966b6720af6d8510d0625a24e12fde7c03c0678e37942903b68a7068c9450faee157b00b3ae6ec06e0412ef06e6b39af031f22e0fe166a3466df38b70bea39c20ce491726aa9485d9ab5dc71fa834166ac8d9f4b7effb0825fc61c438bd4619bbddeb8cf69e718ba6f5c810316175cf25f3ead11fc60d0c369e7904fcfac2925bc5849b652868da1a6284b469b6dc058721544f5caa0e713f611d9a91e3e50f20c5a3bf21ef8bdc72102d59be086ffab42083411b25fb7890f65f410f1a3c8319362d3dfde6b7e6107e64bf4a7c575c8be5b9a63635b1e7c38cfc2f1f6c6ca42bc053068d9d0567a5c4358a8799c2fb736c01b48ee060a4a2637f29fdc803d65c3c8766e0cc9a2812b057bade7506e3233418c7f9d0f23ad77ff972fc1e46fa6d363a5a98e944d6c75d13687bfc28097ca929da33a0a6dd3bc1d7ef1603af8404f7882f5e0048bc2f8faff0310d180c1851ce060d07df351575193cf742c05e271384260180635f955acf88dcb58591e5ca89760a101e1ecbfd2326856697146e2758ebfff09747777b7231ff023d2de06765906e7e77a3d39dbd8a0524bc85d55366b2932473535dac7868b8f856509b48d7c351c2b7a00c4740ac11cd6f9ae9eb9265f3d262f42a7c37a72528a048484270a6c32d04f8ec0880f50c4e3c670fc75b5e156871d3be888b43b15c5dfe1d5fe270fc702ba7c3e24fba80126cca68081f7d0fd4ddb5fb7aa22ee7b5687f470e2e2c59df8f7f19f15d4170d1c7c77244048a0bf0d94cf7e90be43fa8e0bb3f012826530ff7930258e2ea0c8c0b48c684fdd92cf70edf0a3ab78bd6df9c0de22a9f3ea04cfaa7727cb829f050ab3487ea11ac74292c215e65fc2c5104ad9476a0d092799ab0c60a1589036553f417b249def42180e6434895ccfbb1d13cb74a15c6ba5f039b2835318f478054817251dd9159341b777644faac0d78e99b48419ebc475f9599985d3b912e052627c7292d87ee0e64b7a7684c9eb855c6f03fc8298754865a77ea3f56c9ca0be7c2a915a7cbcd9f250bb8bcf2cee8b9f23252be814d7e7331bf9381e5ed67b16e34d0f1ce2585c842c950cf19c44f7e0b65c0349ca397fefe00e0e3148f2b55574c67601a4ac6fcdce137801d38ced29f39dd9304b061ba5fce1cf271f0aedf53cd4fb0c4ada908c1a6e7a72701bde010c79ea09139455c31f8e8de40e531c411a8af0752090f159d621d45aa88f06733c74655743e1ef1bd9f4b6356cebd7ae5b75e42df99602f5fc990f0b7bf57db444154dc7b8682b203c4b1a96cca5967c3e2bcea8b868b4c19d1a88f8603f46bd54e4fc5c10d7b72a8e89ffab0905cf9d07854bf33bc8d44519a797e28ca238034e1fb07d7178add13738b7fabfd258770f6ae15d0f3a72a090fad3d702ffd0e0d45c3d3226aae7b838eae0024de54867a6429bdc80c132f5bc6b4237d22bdcb83946faf75e9ae39eb6e32c0cb4fa0aa9164c233455b4a91252171d98621832d31ffd7ad31b5b0ee90fd815a44423a83769af7aca5db4a9c28ed31ce868bbf1afe9d963779865b24aed8bb4f655a591506a60e4959fd1bc25cb250c280d6dc5dbc80e150b89c27f4ed45b27b3fb1fa8773d4714a4b1b27227099f9a0b3cee3fb708abbbeae97b4b3fedc7480da0c149377b5bea488c1e346b4ed59677d6c37bc4ab4597a7177df92dda5ce2a866d793b02a74b320aa0111bca2a5792c48f73f1d42b5b377cfad6a527b63788cd1aafe05883cae19662c0bee9ad53329e4094818d6d98fd9032eb744174bb3e56184b334ff204c775e5a443c475b9c441edb46b91974ed0edf3ebc509677952be6ad04d6566d2782cd27ea65e7b8896137c5c3d91b078d6634b3716542f4eac1744a66b606b4696c99e177c579dcf7e1baca262b95d71e8c9ca7041fcaa6c8f32fa97c78114d5022befbcf1c53eb912e00a048206c83da4d3ebb689ba90e9e242fbb26bcfa087b578c8b3e1645f7cef942d01b958761016769344fbb0194f7f3dc0a95ac43f299932e2082f5995301bc061d10c99b592895980d124a00ac442f4069afd2b521e468ade129c7defbe66b95cb470180d676d6f6c3f5ffb1062729e236400ca7f6ea952ab1ebdafba72feffdb76bf48d81bd65f02bf01d44620843ea6ecb6b6a62684976cf7a0adf5ca0aadb0cec0a8c1e482de2d3c3496b36dc91ae982e70aee83682250259f787fda0891f4fd93a05667d02ec7e0ee0315b59c5137b599ffbd8aa7670defdd1f8281379e062dd94203e6a36983ee5626d3dfe7c306536960b05b07afb6602fd7d65c7e35b97ae90f39d1ce5e1be139c9806afc538c5489065e541847c05c3d63780fe30c1a7df9ead4bbf6867e35062c2719a09816db8fcaf6d884dae54b9941f6574279bb354aeb9051e1cbe8fc16c1a48e76ac8a01197b00ecf2b2b3bd26c2001ad26ffbb02d23208689d1470112180dee86a8f807801db102e9085e483412e865365c357fb39ed8b16709f8c8a6df82d3135f34aa5a7056dfd6df3bed80fd97967151d70f09becc8273a769f07be95db0f688e1cf92018fb192e45a5f7fbce4879911279920a722c884fbb478d21f3c2c520292ac26419211cace6f5d052e3860c597846e82c891d2553436baabd607aadf571ad8ec23c64eb78e5fd332f2d14ee503e36f6e8bf4fa870a164985c77d36e170bf4e54a6b606187f97e11390da0c7e9cb7843a5cf3ad00e8735c45961f6a54ed801024f253968ad0c05d8815fef3541ee0003282e1b96ebc761cbf24bdb5ade75c060d732eb460e38061b6a3c97a3c675dec2842bdf1ce7c13d15cbbc48505094648c72f18ba419a074b24871f9efd3928f01db56a096f7be8c58a80700dfb378ce518958cb4d370530fba2036f0d6f8a7a867cd880a81e0f97cba21c4f3dee677b23654e54ff151fae456ca5cf495665788954c70bffabea4c35e0f83ad4280d70b0f2f7f1a4eb2cf12a066c906752dac7945370f5010723650a3a3534956c9365d404d6d054d59572539b04074470756dc8c33a722710e834ddeec1cecb2ead8abb9a7a397e82f495e65f3f08566c19a58f015ea3f7add50af0651ee3fbc78a5605b66571ca2f0ca1e15749cc6f532a6c044c348908fa089ec92fdaf58f8af125daeff7e5dbe886cbd24cefe1766cfce4290f8dab702cdfdd33334bc4d711c93e3d418fb1dd6d206cd3e80d1a7f84a2ff90dbf440a661b56baa63d84523674d5ab3f5a13387ac69b03c99560f7002e97f7f1b1fa198d4796cd5bb1176c8157bdf5af4d94c9a1094d27471b22ab6499e44525a219cb4e5e78fb6b100fcdaf2f2f5506a4c33a0d9c4f305d28d722a43bd4fa68f9893d9c1bbb161f77c9bdef9dc92284f6b9364a093742569993c197171e67543ac0cd0f13477a90bf0b598c729cc75129742aea2e7cdf7239d9b96fd45cfa2adf76e2764ec54283d80e220701ccd13f0f19b3b8044d6cf58cd20f727af0a21c01adb2e17e7c7602a8fc7f07cbb844680b03b0253a143de4f1bd515dbe9479441f0a81fe2993ad36b320d7cd40972a60a2901de2858ec1b3a21cd5131883cb271d36a9c1427630ade107966a4dd423abc92fa1c183effe43746dfe93a3a3a9cb4214cc6e3210fc4eddb18ea7c63a217d66bef019bad391fee3605773b6bc43201822939780b4d3f5b19e446994a023265920773b37ba2082c50d43d9f014c8a15e148304b47f353408e00ee80c9824c9736e87cf5e3d20c66120ea6f34990982407e778340bf26356157edb68fe70aaec34ecfb6fcb3b35211bfd93bae9d92614f39ba017afa8b46e4e80e9d3c867cd6c48014442c7398dd90d713cdcc3f5eaa3a800c5df4364f55fcea65b2b5c1926aecd970964d43ff4e81b3a8d06cd2b54ae154bd48af7844845e705f61ffeb64d6adb2ddc1b3820ba5f6ebc0d49ca131f4dc51ab253b4e5664752118965963ad713429a6f78a850f1522402c80656c37440747f3d9cbc535838500b7ffb9001df663f1c524cdec73b6ce619705fd1f6a49c97106fa0d390c57c925cd19b1fe2a80fd1778417b8f54d94c1c82ae748f554c385c4d81ec9eb9e9d2183dbedf3e849b7b6ccf7e5e14518d092b0aa8dd9d0855f2771c845b7547f66a7f4cc99d0c4e8c5804dd16b4eb72acfde789d8e9437c3b4dfd9212b5f1330d075f7300402b6e88f538de05cdc431857f9603f165d746367008ddef0bfb1ee741865fd3c2347e91c4e71560652fed0dd918383002dfd30bd47eb9ae4a601cc135dc80a3ead27c2eb0b933ebd911b806bec12f8a553e5e20f0387e686e1db21815931393f099be89b0d9ca2c9ea71e07307206df621f6da86132777f72e62a898cce9d27feccbc94b98e22c622e6f779d98867e84af6ed98ab53881e148366cdc195f2ba31171398fd1b0043ee1b65b929eb388311b646fac581caf33a5f31400ad8c88b36bd361873860be1d55c2f2bb182737ff04f473eab392ba5a67858887387074ebddb000c2cfd41744c4cf17fc1951cf3ea1ff581ce974eb3eb731c14e62c2f64e6222cd9fb4f5ae834b55c01abf7db414da39551f5965117ba1fa9f051a235508d1f2790bac38b0b41baeda475499d91905d5a84cd91a5a3e8af7c54d0e81ba11fc46a71a0e60c792301e472d5aa3fd5e4d64e2ecedfe5069ac5d8b8b7dc19a7a9b04cc900fbb1465607988745e171042424ca32049c3305e68c061ee0bf87d360193987f2b344f4383c7f959068e4a771c94315c202d4514162c25d04fbf83dae04ded8b17b58a8e84c726ad5a51d0fe9c8ff54a078907f8a4d365edf97408e8ca8c24073b74590076a2e111b0be990478e0edc46430bca2aa1fed5ee1a5cb6b22474cd523162a6e2bd8d614003a8dea78f0a2cbb92ff0becfedcc33d7b9f785ffbd3664278d4e874afb49ec1979fd54650c321d5602560907d10468f4a8ef451f80e689244b059011f987fca295e76b576b591e107f614733441a97ce7f42d19b1ef6b8a4bcafd310628eb295dff70a7896c52077ecf504151afa237fc958b4b13a5a652d848c99732a9b4dd4109e9ff6da060dc502d14ae9c3ac411e569569ba4e909adfe2eaf252d7ee699d3df4b2774947504464934fb3a6cf9c3fc011bc7bfea70315938288ae929fafc9a9a89b534d2dde96ac91b82f740046c48673e5bf18371289235b48652bdb3060a70ae01c39d35fda35b83d9c37d7d15d8eef893a56060e70784b07835c14f15bb183db873a2354e4bcb81695c2060c606222df4d3ac329af26735279434cb611755a15a0acfa2aceb4a452c6fba8979b917863ea152f47468379c589e57cfd9145f9a701bfcb3ce8a34e879aea6124e261ff4f0a907dbcfce7f1108abbccbe0f699c6b8713f38211826e08470d0d9cc0092cd243e230a9e374d1be0e6cb93319c8c83135b337b76fdac2feb0cf4354805215c3992779b3a2a7014d9fe4371b4d0349ab9ee181dd24d19e6e709ad3c2e0e3c7b595e43c9932089088d60fe1c42be8ada3b6c1b391d4fa88a85e025f2b6668f59b29c629f0528753f9b48559bb45925ce8cc0bf8f78c2ad0024e8bcadfd96f5a9aac152fd31483e9b2a473dfc489adc5a7983a89b1583d376a8a1f7c4e7ab21b89320397259e61cb190fd168e46f85385e1cdb3c32ea898536fc9e5635ec12b02617d42cd8758f1c0a0c2471ee622f6946b316af37643fb213d291faeb08cd57c2eb7b201a8f74b91ed7df5895cdab83101b7b7947eb40a72c55e57fd6719d4d53dad4a68436749f6a0ce71097404d57db7c6a6f420c39ae398798c63150e1c72eef75199c7c97e06064bac89a261b57dfbe23c047fde5645f4ea7f1dc67e3ed7de0a4514f1c32f251b7da00d4cbf24521fefb277492310bd134b9d8ead3be836460af8c690a59304814f783229670e3ea1148ed6868be05ac52cc07974d19d9691720dc759702cd12ac166d573f15c84a084a998f91958f310aa244d407ed72807917f3a2e0bcd06635b09915911590eadd5c272af2733fd624c278b347f2186c7f22d19b6e84d25b7983e3d73e7fdcabbee7fa0c8cee5a85dd1138ca7f15d3e44be733151da9e102e2e778149ec0a329e3f1d4c66e62dfb8f2f1e34f466f29acf22526b4cca847f1841309c7d932164c71e1c2cd0550a795d61e9572f69ec6bfa69147bf4970264b2c164f71250e967fe4dab3bd9d3ea9647bdad07f9dafb9ea9c06c31ee7918ca273959955e2dfa7e7e21d57a05f0433b6e0df38463874182b6ce5bf96d2e01bd04b6514f45694764d21e06c7a4399d65050d8a0a6bb6d8242a68bcf2cde9213aecc69401fbba61b61cea271574bbe79c90155702728cd5e890340f4d5185d3a83da0bb23ef2222617e867f841e68f7cc6e87007698fc8972ceb59d81fb2de017b6e943a0afd3001bfde8de3b68f7e34e18ec41b42dbba828ef81bcd6fc808f9ac0db90b39811fbd87fe3e4bddd39aa035a86cb8c0bfa8036e3c5021369a710defb2e67f3cc17099779756e90c9691e95396149a43c607f6ef663bd48c88520227c236a0b9d704ad444bb14375a8ff137a770d44871a5fec82d44a35dfb8d3c7ed693c52b69adc22a3b3fccb974efaf4ec83bcaec34024641971d598805ec56bf72bf30b34add6ba97100bbf6fb5e9c8063b23a1e3e186cc969a2bb17a34d454a626699e66384a79ea5a403b2a8bf14b5520ccc8c47951c755426792d2d21d7cc9a7cb641b00c444c437529b506eb31fcec904d4925e5fbe6e048aec493858f5468e24044664bf91caa2a542aed4096f1950227f7ee27d948a76011f555455c90ff2c1c5b18c28bf137c09b6c46c5ade5a7c33518b7dc2575959357938e867e89e3e60f3439304d6c18db6a7afb05da8bba0fb3dd45f82e150708bbe1b84db874e6076abf618aae98167de0b87ca7f3b2dde8421473b65a6df84a5d514c7c5c357d1ebafeeb156b9a91657765e9b05a31fbc0a48ccc9cd7e4b953596bca9a644609e6488111a9a4c996a7be128227db0573ecca3e7065e59e0ad9897cd05834626b06dfd50cfedaee9e87856fb4eed4eec0c8df024ae800d311cac29bee6e89e2617437a60e74d11b34ab129deec8696ecbdc406c474cdde9cd66a982f533cca7ec4c239792aa3fa1cc3eee1b2044d125ec82fe01c3fc49d512649ebf2f8374b26d9da3e81afa299cf6686e56c20e5219e7e6ac4e7c0fa8cd9b3fed5e2678ef47a8965c73536d61b6cce3bc6f6398f8d45a121831121f7eddcea2137df5801d58962d4bb57624f339f677d75e40f1d863ce93ab61348445114fbfdea569e257b6feb070cee74928ce15cff6767c2eb894e12aa7b580a65915b3bffd6377851435d89c02b0c470369dfee7e20588b3c21d879a547f183a87cab63eeb3484f2df5903105b752e29861a56bc24e44a807a45663c96a4c5ed44eebe717d60e8925be87348d52b1f4e844a009fc0d90b89b48564097903750699346da78716338f20d6a7a429e3d76a39074a8ae0e0b73c69c71a713470a389fe8ffe71521f6acfecaabca32c49f1e075b6f646c99c5bad70ae4bb173874ed9707e0077abc51e710ce1af388fd9e54a0548b23f3b23c0c9fff0c1ba70f8612a6dc727665f955aa0ee6ed01c1203bcdbdac5e955a11a7b87f1ee38e70cabc9b80511222bb17fc40d69c30da2922bae9b0cf5690bd69193d64138597278ab38e35534b221bd35fa2dc0748e748ff1f04fb2004586530a19442ebdcaee429d60c821b69d2f61d09d2d1a692e1431ef0ec3db8f1e521f2c41f985ab6e07a74f9a93ac0364f97b984e562d3bae6de27b14740ccb44f9b45c73d914f4a786efbe049bc6b6567d3ac91e71d30f448df8ca1630f0ae174c100e9bcf0f373298298f8075e7e1d58adfbd16f79eae607eee0e1305685039381867887e6e42e29f67cfd3174e9db6d69d60365d54a2812984fcc77d032d7ec938a1fc1d8ec325452dbd70e597f7a8d44fa193c32648134b7aba38b76c58b2e025502966abc3a79134c52c0a75d63cc87e279d4305a611d715a7ed855eb0ff524b022e7cfef340c42534659081f2058aba923886a9c78a985575faaa6ead83208d09590b56dbd4f1253621853097eb0865ac9209ac65c3cdcb3916bd1c93ead7ae6780f5bea12b7a02de28f109b25732c0a5cdd677518742b81a69ce85e7a73f8cc837af464771f1b89ce9e2bd8527e2005d8b223ce188e57e2cabac380bc9d80e039b37c20ac1e5f4afab69286560eb393074ebc90258da22192ebf5ca0576d382c6a48f4675cd7f1bb536f12765a836d269b66cc00830490dd14a09056b70acd7e65410d340c0dcf78d6edb529d85ba0c36fc2c210fb6478aadc241be6878c3beebb33746ea8c48839be14312ca386f773cad160693306764c4ebcbcbacf8a936b7a154aab9603b7a7bd10d4dc18c41da6ee5d704988b04d2485fa6828090df48361d090a80c148c09eeb07d3e11bbc1298f9a7f278798d20441103710161c76b6cfe0d0b17370ad653b3028f561fc13f46c254341adcbbef87e7eedacf6f04561f8cccc8981ec2fb757d840a970d1ac6bdf98efa3181856510fabebdbb1ec61a8d75fd0bb79bc293a1f6435f61a4d438146991b5ad23d4f53279dfabbbe90b02c34c7c02859a4c69fa614acbcca412e98f04990fda9c157d23c567c4caebf1c49d1699b8363c52e724e36d84c0d361c0d12c2a4dfa982ba35e36db2ed58ac78a90fddf8d89d4494aaea021a025671d22fa6507b214adda003bf42243475b01dd858f616ca66862a9cbf96798f8b33620b194f11aa06321b3a9d385490a4b4636136a2e84b1beb83607d996eaaa07a655e57d0a2efc55ce9d42b8612d556e4f164689c9c4ca78b11c55172f8f421eb8fa29ed0e6942b65a84272c4bfba7f4b77452f5abc03d27c43fb7727cb0b4bee67c9c11b4b590bc43234cee4cef00487fc85ecbc04029ff8c2f4a3ea4f124591f5f925fe95d2e26d330c6d29370009702218eaf55366d6614fe51ee0c54032f1c7a84e5337c5c103450869bf38b909bacddcd1c1d4486dfd5dc47b6d4710216ed0c9ea8fcf460cf87a02cc8849522b60f37eeacc8d89645e03a0d06f91631b80aa7b6dfe4d6ae389e9588329b3ab234740be24a0e4a1ae6d3923c2b7ec19948257e968592fd07fb50603be50685699e77c7ec46901bdec15dc467aa5b1cac0dc803e738b322f504422c72d64ec1863251885fe66e0fe6407944760e9a839460641b6bf6d27743da5d92a4e4823864d00ef09880c9aa06f82df1a23f6ee462013e4e4c26924383f151c11de57f6b3779d86f1b0126bb9270263443dcb1a8277ccbc2f4700838d70815cb95a0fea4b118503016a70225f45ce62504c85d4371b0f088a1011957015ac2dfe5ccfe1f6c90c27e78073861434aa8796ea96da92e5665708d2c7e26f35f43e27da622efdcf54627c54307f46b7b1e2f3958e61b7d5aa6d76fb2753ba6c84a4b31819ab4c0138ef8ba10288c4b72639c88ed9a1ee5119434e8a6c2b98f4b30649ce19821ac41eced19f45cabad407cdd27098177eb8523184eb39b96fb75574e3f3a00bdf8f479783267aa1e181585910af3ebe1fd4fd2775ba11d71a004439b7117d080417f12792468f46115488ea568ecb54611ce47bb4aa03031507e02458ca5dfa8fba086f1e8fd0fbbcf094bf4946fee8ae3962a9d1f9de6af2eb2dc4b7346c10ff6cdb7f5b3f99f262a1d77f303da2709beef2ade955ca6a6c9c3c20063424aef4b7e5f274e3b359194e53b5dcbbe8721915be23b803bcde6d0f7dbbe08af0bfa0d536ef7c2614c792b53886a0fdffba0c93c268c5ab1e9bfadaefbbde4c197a0d1d870fb33ccc34ef90f60ab9de5cf30b84875fce437057ddbaa3cf51b5b4fbe5212857e70585343f52c9a4492bde1f9ba23a94d4ecc9902d79aeb683fd4b19e964bdd09144850c1df135483bcedffd8fc0c9b3b14ce2c58a1b2e0d96db50c909b376649ebf28b55202c5d4266436074a6160cbee218fd6332730535184c3d8f8585724ed7d22848b927f0bc5b1919b948b03c06490e6f793f5870df566c023fcb99fbb3b34c0e49535afda2baaadd154b54fea027ba5a3af0aadb71069f617c57f01efb85153dc513dc8815b8a62b5232379cb183c5b7140d2fa8674d74f6a94d3e81dec8713ee8986ffc0a2d776a3c2d4c9327114f0e11482cf3b4a83a74141a1ba7edabdcd7bde0c6e89f0675bc6f04b0f4413e3ee38b852d5a532138322c5deb8655d5aa93d43d72ba5094cbedd19bf19e1aea1becce887a9ca218a9909c03e94fb7accee1c1f83b24daeda783d368a0f342c7f85fe6d890c10daf91c0178c332fc191c6bf5e40a4462fe380719aef8e50c412bb09c038391b6aca913098be5ac06f486c09e471415186e5f3993bd900bad43e63260deb443e06ac8be1ca218a461eb487657113072db4e82b648dc8b5abd041a4d60af7bf5b54f9e88862ce1674d23de24e1c7d58bfbdcab380c61ebc4f41d0acb5a98d83c8b2f36731b261d8a7c71845672cf89f84209a13a3ce595b2755a1d77c94ffda7c2c2bef37e9d2f4c950bb3ce4584c767c0d7b39d86895976b8ab0b1d6bb6af8909f6d7e6ed047a9daf986c4e66cfa81b04df7c17c292a50c6ecbec7f078cbc8f2a8232c3344aff8522efca187a307a9516bc1e09a57c85d4b02bd57e8d7d88472375a687ba77dff272c51af1900823ea6c8ae98e6472035f167ec514d57a4ebe6e6d2e9c8b49119deb0b18db8f7b48f373c490b5162c6cba4b4d503c87a626de9fe43ee891afb24b9d4e4aa9a7387031bf3836c261b1c954f31d83bbb0217f6c607b450603e58699f75e08877edf814185299c4600d7b9317c911e862710fc46e95dc2d4b894a946a7bdaa3dd796453d211fb970644ea0b0a918c7df81d6980ae75793a3df10666e38e0202907f04e4e818ca5b78903cb9c5ae5ae9536a413823ae0e9e94e3deb29b1c67cbbdfd91537cb0ab39f7311fbef5af8d5fea32f739dd053cff7ba26707b963b211260e70d5638015bb397afcb596c4fdcab7c682dbe0cc55184d024f5d489f88f0a32e01244b16ecf438b5248c72d75c678512bfb8d8c1ca74a39bbd795d3c656960044ef6696f8aeebd93b44bf1846e2015f75a2cf5abaef7fbf05c57b124eb643215353dd6bf1efb5ad63ed9ac1a9854ddd982d1f2e0f1beb666f60430e6e3f0e069f7d5738e422deaf8d440152e52b3ffd9a300058640123d81b17b837a2d37128a3d718092e4d4b91193ef83b2f92f8cc528273570e4f076fb451fd4bbcc7ac659349317059c22ee6d3b4cb0b1212f1fc2115d945f885bc7f3778603b7411d6e561bde882601297ccd5713dd8c13093f1ff9e9afe33bf5889a0e05182193540683e193a907dabfc32ccfb8a9a7f60eebf1e132594faefbb6a415df24748b56b862bf1edc979cb6c10ce9af1d02a55ac89adc11d560aa204f0ad5a57c1915178004ec2624bf2f7a95483189a33402340e057a9fe87d49c66b8b87b0b7d4ce0c956f59ef1b151178e940e64f427725ff466754cf30b392eb08596c162f47fb5bc3c2d9d57d1928f2e33628d38273e2bc697bd3a3756c075869e8f66031a78bd60412af41f8845e68d0935e37d112cefd245ee94aa89c1993e1582dd0f1295acdadecea86f3a9adf1a9df79a7bb544bb0daa27052149349521f3dc9d2e1bab46891197ca5c68cd62c2f52cb19b8cfad8086f8defe99aa0c99b0e10ab9b0ade0d5a47f3eb5a3acee4c0359f8692dd7d9ac454903b1706f67662e21b8b2dfcb6273b95516b473eb5180ee41bc077cb1d79b00c33621c4d17cb5eb8c34904d5a6480fe0b608eab969f7ea3a6d65fd6d7408ff287a6fbd3c1f936a8ff6d25ab5f21df5690aeee3042a98a1dec1595f0023fc89e29c55c4884521ecafe6be2282a3e7b7d86db0a88e1cf7086910dffe9f8db9aa33d12a4102ee1c673e6adf0f5da6d31e91c51ee45732042fc7475cd4a7dce264a8b0d85bf1b03c5715ccab2bd98f781e2fa811249fd91825b6feec47e9f33123c1743622e67654a0b14fd1edecbed902576cc97676d5ff3e0f1e8ffe34dcc941c7f225c65a3daa737663682310e655c4341b3095eea7169407b83cfc57a095542af23ce5f07562569d2b6d948a13032bd099a1c067def3fc8037bdf0a2710be630a4d9c5101f3d0c4dfe052d705318b7428504b9ebb140f8a20e086687d8ea92f949a2fd6e99f43e7b2c16a65be14c97b66575969d70e8a8a3ccb174c193b10c1ceed755a68aaeccce7151635490e729e6e6ae30e758d2cb8779121755283031e5b676bb4076682a132d849cbbb2926cd19d416cccd2411d04019d785227edad03c225c24c9caf5e9abbbff1c00a20ec7a3367c12446857fbce046d577a34827cbb5a022b6b497d28c2822002c53979859fdb0866d394fc4354e8cdf14414043bb22aa398920a4d8784df65c7d5eb4e24eaaa0203dc3f31d284face82666de35f85b1f389621a8e55f0701431599dd6c14292158c7c230cc1d7d68a46b26ce21660bd7ecbebdca925c647f9b659a130882abeb808ce9644f73791a1a302d4a3b82e0a2dc5c8fd5a278933c9fb1ca4c895296e2636125bc16059f62f4a3520e1f1a870ae6ad7f9dcc8d20373bb3ae89d88e7193ab82db754325e892b3629c47dbcc12ae386000dd78a226a3538c90cbf7c111854ae0a895c13e9a8930dde4e1f0f28ec9bcff0acb99ceca4b07ea74fffb1cd071eb504e2fdcbdbcb6be391df024602f1fecf738fbf9e70867b07781e24b2691d9b2d84ee664201247c2650dacff7571be5c1b40c0561a559996e0ddc3ced35b52d853cb828a71791fa5b7cf17a4be1030773ffc12443211f29ab2212873c4830a506eff0e435e817d9d4768fd6a2ccd4644bd6273a0b1fb0b1fd9b293e559d6d4a5c065702f7534a1c0a335824b005626530657d827e1f746a3bc23f347adf9047823c032dc65ad25a731f838f7d1fca31b4796119c1cb5c51d6fd785574c73f7347ce7a3fa86a9dbe7aed1ca76da1fe15621552b87521b1af9046a677dbae98e438a6556da3175e085a500cb4009c56acb6f4521e68e6a272ee241693703548f67556ef16d3d32ffe5e7ccf74109bbd7cb790d4e3c2e64e89954732cb9845e70869151f5636a3adb527d8b5e0d57489e3f789c60b6de2b75d377786e7548a8191d1132434ba3fe28940cb58ab60e368fa3ed7b9e660d75ce5b03700283c341df8551e2e257c4a2a7dccdd7fb9151be3b150b89d447662db779c9091e7722f6c7dd4176d8cc249498a32cf5462c11063540d8b3f386f56305140dbc83e0458659eb5c14b5b500923d258b4ab70a3fce9374fdf232686f49efd99394c3e46f3ade8a55cb3d7c2441e5f5cd5a73ebedd052b5b54fed1f585efc029ef7896b793a92b1e0d303cfa5c8f1e7df87b1a159ae429c799f21362a85259d56f60279e4dd46adc14d1e0d11198d191578f0f251c200f7f5c24a46cc193423975b20f7a5ca513256af98dfe783f5e90c02d3d26f52ac77c2351f86cc08482e30f13625f58a96dd66c734ad09981dd9f85cdfeaa7757cd7d10b1d177a9b1ee34f9d85cba7bb52199f3cfa46916d64e45c3a3f3f10aea873fa420873c8975c1c0bf3d2aab0f978416418a81108dc29bee750d907b5bfe3d8e27829186b462858cce6968c60bf365ab2521c7b3d4ccee6d3980ef1ab49734283358c396844b09e72b5737aa86efe7fd59ee2ad04334bf1c900f3aef72572fdd777c302a7d594984846f3ef69be4bcf32ddfdacff97f058c0419402d9a0b5d93822744648fa906d822f3cc2e823a0e9a608a1ba5da9bbab5156614a292bfc51ecc956c1613be08c8cd2d11cc8986769c0ae0fdb50e99680a9f410c73ded84aee5e7eed2ca43d91e8a74d5010dff92006c4222aadca721eb106ec84abca5aacefab83784d59d5e844f89c1df30d33c4c4e1c31a74b9d86261dce4480b58f79ed48e08cedbba65f577bb497b4a364a43ed7139bec259a9af25dd661bb101867ef232144ef1e329af2f441a741f501e6a50b61a0850b2b152bc96b31f470619e8db18c648f3ffec281bf330df6454c31b4dea87ebf7c31c24a5e583a811ec321e2ee1e8ab0d7b42119fc822f3c4a30427d47ab75aececbc19432a4495ed38727bb67d802a01666712b2eea33c0548be27c21b7bde61e706a585593ba5b0093f9f6d7623f0fae41b824c12de646d5c14bfc1d8ebe1015055d656bc7694d330cb815fb03c6d6448f3c1326b3cd9b4cda6bdaa21a3133cb40df0abc40d6829eb8ba20e5d67c07e91b7cac9436412b5f1030379b96f9f5600316a7c4ef47223fb88be2d9ea27ffd77469536ceb147b5281b263a2206823691f826a9b807fda305e0e6c92d9052dc892fbd9bae921c8f7907514bf8ccca1f9d72f5013f86dcfb041d7abf9931e073eaa4c94c4fbd8d6f4a00b0f49e0e0a6fdc15a75bb7cb2d81a65c5656c0523ef9f82c4184fe4fd8605fe214b82f8351e0136e58a2634cd4cd2c5e40a415ec5518c386b121fabcee3075e807a184098893893a1ae8a53215115f403eba697d32e53d235ec00aa59205a6f730232d500e610de4da6bd87fc6628fb34202d2a074c08d62ac683f866f4622e4cded745cd597d5e101f33212e64c0936037680eeebec3e567a26a80a79efae563394d3ea74721c03d164d04464bd0c77187afb1ae9c6e2305b861e5fa82ba2f5b56400a72ae20e76a32dee2dc08f1345b6db86d3ce6656f5c1b1a40d605a5c3502493a5709721ec7995e8ba16956112f243ef135b99dc748454a1cc00046811ccb912dbb54bf6ca9de57f7e5008a97d58c46a6ca59468a1fc5a15d1738bd27c5da1898af56d4dfd2e6468bb0e60d7fc07206eea0e881daebf7ca6424e836c4496c94bd1e408f071f77aea833f9fcbc911e125f43ba1df78dd21de581043f9b7d058f4dbe5037b1c90f63b2b1a74e127c3e92815d8d77a62eb90c35b77f16cc433218f3f3f88bcadbc5590d3747163da655b678b38ea8209efc32a6071031787089bd9846539cdb290d347261a865dc113d636ba8d74b706d7f9c47b761108d8447e9c882ebdae31ffb55d3418109f8b80c63781b6861f2293b1732d19784597f61cb39adda7f1370ed14373101486f29b7f7f04047aec95bba80bdc5d6247124cc9b9aa8d515e21c7d6a8f74b2e4686d5331d484c79f18435dc113d33413ce28a49ddcb04be646ce142e6fd0f5d18f5f64ca1f301a3fd39c7ac13a92997aee0878cb2855900583dac5c8b6c904fc2c14678fcb13890dcfda0f2cd81d7219c8e11ca4a7a311a239ccd630d763b18d0d931c5d3ce4173b97025b5b095d840ffc3b33cab5705aa6bb4f87b91010a5582e67d6d6e243b3b43da886e22451f05f3d5362feb3330433a35c4f0687a535e1f71528e3f60c1487c66d4c0553fd02bbca998b6cfba6b6d9e633d92ad00912ec2a81175572fe1bedb810d00574132939db4be0174127b8521be35a9d8bd98bf9581baf52ee05edcf785744d2669ce2ae49c6364d8dbc5d591e16b9ec0bac66b8c3d7c9fc4f2453e27683bf1e76e39290dccab0b613698e284abd61c4764457082ef9f7a3c80dad02f46fc631675343927a48772451e1f895c60c22b531df84955579e11ddf860696e7289c364189e2957baa8e484dc5150d4f89ab9ea2a90f1473f73df4b42bee9f9ca92955abf55b658e9db6d62e8cf5f39238f8d188d2591124f38280d89328381afd94d56dc74209c7e8a497732ea82d39ef3969144c699ef78a8cd90b6bbeeb64c6e12b29508cfca888b8c06a7c1c184624f209944fd31b7e96597aaae2d7dcc238ac0c9ff805976638ecf2fbd1c90dbc5b185bdd9593bca5ddef87ce455ef89ed5698fabaf1fd12fe4732cd4d46ee9b33d822a9ee7179719d173afb5a6bfa523c4e360c58c32e95bc580f80da3efa85fe5bdc116f0bbb3abd9bf795a3c6eabbfee3e8452c06cdf8bce67b28580186f9ab5d6df4efe3dac966e9d075d43bcd2d6c0da54bb9fd0bb6b994096504bd4b7df090aa64701502a6457554ac9ecdbd5e1a040bdf11f9435fb2e413d8e71feb9c9c02b965e05bc0028630234ed0e3aa9a2fdd8c1a1d19b5271b92e98af346c05b357bdc5402b663dc0ee9bb454571d60bef1bc2cead0be5a0a2cebd809120ed484bb16763221b3e99416b0e815cdbc05774d4df86d62056e2edacf5bceb292ec340bcbac4264bb51a433dc6fe674c7177c11f9aecdd06794af06795f5e833114664b8fb86cfb99f886b4e83937bd44a1371c3cf4d4c0581d2ef2d50923ef1bb2398dfad754c8c5011c7c4906590ce95eda2e56490851d7dbd95966a7be15c022eb76143347551d58889cb3e38694a435063909adb03830c2fe762ddbe108713ed41b47eb4b4760aa7c8ce69ecc4852f2acfbe040a15eae904ceba828d61a56e98c003eb8e3f647d740e467182b5736564fd7eb8eb47420dba68769efc208f33f47d6f8a112cd9db164a661031cc93b434a0a789e0772bf93503c631a13ad650fc32e9c80d6362efe5d03a58f6cfc26bb54c642fcbd6e2a8eaf1ce1ae292382f19d6ff1e143ee42a5d18d5962e66b5276176fd4a596e083d627e12b641ce118b64762ed8573fed8778ea78a6d7a9ce5dd42bfb3182ae77f28f241e37541a8f3141379bada04de36e49ac14d1292804ccf3dfddbfd60db2900f735809ba9473acf12d5fd778204c6fc76a1867189ed8ae7cd215c466804fd3499570bca21c6d735e611468f4c2b74cede0fbec35a391f39762731b38b7b575e161bf41f03a70b721243981a9896bcb217057c433d3cf1ffc292a89d0198b04c50e17ff5e21862398b15f4b3e1525a76307ca180831fb54d0e709a5f8c6bf5614bafc47cc4f645a5d5cf4b7c1bdba01fdad2bde7ec626546eb090a87c6f44f875881c3499f7165b9c9d9582352960714282526bf936360c9a5985c513bb9dfd6517b607d22d606d7156bca4e9e11469c8a37ce44a675f28fccb7de6ced90ba7db38d69f4183ce17781816940859d75baa7aabb42575f2da6a8b21b0c9c40768d66baadb4b3a0c748ff4ec0a8dc1f6d1f313354ba428e3d4c287f3b1f145ecc92dfda1e5c97b643c6505329776737c3c2f48757ce95a339a08cf4315e430bf5cbbe54e7e71988e53c650efa1518a52b40a18fa20e40ca37ee166e90dd60998af22b377ec7db742716df919c34d9b75f99292212b2b8fda37acf90bc81b57ba707ac938a58a62225b7b10a978d54db6dcef440abb2dcf89b3b786bc841eda1538c166a852b612b56f623c2ee8cef48a8feb36553cf626c7bb58e7360f2dd1e68a7615fab841cf239ebd4c1a2c5c2dd63be9999c8a4ff9d80e21d840b7c2cdb5c502a5c3151bece050559177a62a5f71f3e5822e9253913de79d014c96eca174acd978257c9a115231fc74a546740d7679e6721e1dabe49b3ac6198f0be13f9a2b960571d7661c02ba19f6d4c6c90d3e2803d885c120002181a3baca519d7e077035db640da0d28241a063cdbc0052d02d3025a9d8abf4a5bb2527665c3d31abbb951d7c62ce906036d3165f70e5d0fc28bf2b4ac2045d3638e62424761a31acc26949e0d036a8693a3939138f478351058fa52f278948a802fe9a2361438797de6a62f9ed6cb46df6849268ab43bb0bfdc4ba90a4702b9df0ee30bd0fc9440ce41e7db5f15f1abbbe1ee9ffd0f426c17442ee8d32d75a90a0b5924ce6ad70caca849d5875977a14581f3f8cd0ebc245e25e9273a5c8d1bcfca93c1f812f61f285b5a2e831372e487f3bc9d2c816f17d3df98c1de2aa7a440d889d5b7ce4ada4a8d4b78b5650a260d3a3d7e0263cfa3350e804910424c44c1a7375e1efbefa216cdc7a0e4c848a95116852c6eed3d2ea94c00e1aa794051adef5247d85549e588b418e80f33b8e87d7bf98eabee48349fc15e5452a353b2af0e39dc53abfc761dda1c12168a851d1e121f6dad3838ede7b831fb637a1b98db0d430d9a5174552fb674ef092bd5c1aee5f09154a123f213b09060f53c92f32ab08c18ea069f699dd1c6494066d339018644bda3a9b8940c1631af3636cf4b684917853be70f230cf5f656c5edc21e787014dba6199a1fa17f8cea11d0e146bf532f3efc9de5d744f8c430c6d215b304929c92d588715802b66d48bf89851ef02bf8b7461cb3c3227985c816ca8a9aa4090395cab1edadcc97f5644c31e5f4a9198a59d8f8789d25cb357520923eec7453b591f19d08eb594cf55e585090b1d7533b9035219de12efd50b01e7313e2243d0fc2676a50481f5d34f4c6d28181bf1a3c5086015e1e1ecf81d1c2b8d576cd59d78d793b9b5dc2742a1b1c8fae4ce2cbfc66f784fbc76470a0653145dab2246876ee8f1b865e7369bc5de7fe869fb7803884e66bef52797f019346dc5ef2f57570895e86dc3da402d79c905d2b0bdaf7d811fc8341090d4409e1ea10653f8e89644fa937e62082ffbd12e32df0ea773d86dc4bbeafc800fa6045c59d5ad99455c10c0bb20387c5dd5b6f19676af10e8d3f0dc46763737e38c722e5b24a8d521c85a6d86326c2e736f0386811fd0058e7ca3f271dd515c93f454b751a10ea41f5dbebdbf44fb611f360a16b8816ec1d036b8317a3cb7317f0569592b66749e796393fb77c83bf5e79880203e90cbe06281d04f9440a5552b286f1b1cb13e1bd37d890d9828cd92af923055535fe495398431151b86f37ff243d4403f84bf5ba475137e15e96607cf5a9a6c5d2d5dae3a95c877d9e7e7c964870bfbbc503f7d43e919b9797919b7bafcbe73c64e763dc63a441d18c63638c4b9e33559b47fdfe42a62f129fea7d567c3d49618a78ba81fc722be344096a46940fa0be6009f690787c53dd4982ff72d858c824ad969e681601d553c6e0617c5891b7e507537d9647c271ddd70c9c8e420e6e5f63f84453171536b75657007406f5d6a8b22b3e541df28d969770725592919a1021f1f0f0e7578dc74f410dad3af6963faadfe1de5b6bb3581230cde86432f2e570603acb813f882e2904db12119cd6b56e27572af3e65eae54bc72a4941e1259cea1dee0779c32b2161d46a41d258e9487e98fd3614230e6f9a5d8265ab7bc559fdd4ff46c45057c29071431ccc8d9ee28a15da38c709eb21f947252da6a4e8b743d73bf84bf654e52eb7bd1d72b92ab1cecb335cdd7c2eec70b237c0d6866e1dfd650baddb500065cfea5e91045ac2d36d98dff97d41dc25e5b4400a259efe4415dcd6a618ff263dca0c4979ec663af0a78da9ae8ab8ad55574df6c2373c101def3d4050df2fad1381cc057e457bf46ea2f304a11e80443c2298db46810d5728359727ef3c3867df51be674e9c1ccd4badc9851ae79fd4b33b17a4f2ea6dfd597e39f6e10bc515f3fc6858dc08f7df2977ed672c5053edc2e4f58e9006381a0e454fd76fcdac1efe35d7cd6d5e774cc973ce36213768635ec568716ce1e4bd1720fbb9144c06872feb74eb0eef62a3dc684d776f28a7ae37037dba44d21559502dbd0e2c748892af24b5ba6d34c954975e1a99cc6b84465bae07d5fd81aff916974501edbbbc6c7a7315e11944cd16d3f2d5628838931eb375f8398b7e75422e2aad18279d22824fa394bc448b49e062b2cec923f90f9743b09f709220d9abbcbcb7173c7965ba1f08fafd26ced72483288b35a8cf837cbae7f5de2a41a5083e71e2c335bcd0bb66d50bee2a564828b07aeedad8b9cbabece031cd8b25345cb03efdb7dd5849535aa72f0f489a3c5f7a21930ece6c74722bc96cf566624e5e63e47a87b9ce706272bb0477c159640eb16d5b16929cf12b582e33e5b851307b027c466319041c32d8f786bf1b78d6f8d9d0adda930e89ad2a6d7af62a31307aa9ae442f514ca7f4e68d8c18d9e1af8fdd091eae2a3849b5ecb86c9cebeadd582c757f2fb7b1f74c231220e64c6fb553473c00ab6a6ac47ca0d513e023438b4cb8a82b703475b8113aa68084afc3342e9d4f73bd6f16730dd78bd6dde6e6004213392c2408c76ece6b01dc1aeb61b61d1c39507df714114c7f238ed196b51cd193d94bd8a60c5c04967b5cd487fab10b706442534a7134e7ef1181f09586dbe8b69863c7eaec3160a058f724ff2dfeffda3e045e838bf4d3c23a321c36fa474e232b1949bd20b714b3e2f969dc4f9c2efadfd78903ff4cab65d767e02109e6b8c6e5ff1ef7a0c8d23ba153c5475b21c47ac9729fa43534da388d7b7b879b67a8398fd7daba50d6f3d80560604248b1f81b5b4bbb82a6a5ba89d1b10fc7704d62c6314f75f1846b33874115e75185753ccd2cf6ce7681c8c3107c393747b4784a340b8a74f243adee66a5c5de40c99433993fe95bb3dac890481f481f2ba19500a627c2d5d4c88d8919a6dd72e0e1687d392bd76ee03d684d5ee9545576073d47bb9863bb284355e8f0c3aa0c2458ecfe033f570b185faea51d7c31939426c7bcc21644438dcf3a177cd542c66c6af1af1cc5d3a4b48a4158d6d1c4895f41a968a0845e55bd5e28f9bd5ccd1f32e63647b8ed7a0a72a3297763e3fc2de63c3cef3ac5ccd0f151856e4987ea71a2a563c9252e0d735ad37f23e9fa33ba9c1216e8cbb69c8cc46d74ee82924740a11811cf92ed3b46f5db3c53b0956c6df619c5cdcb6d278f6c13dcff679c66d06fe7fae11aafa51ebc30ebf47661300ea6137e5e35863552d87a9a641c482a7f0c1f6c3c96c17a11140b6b230a67d0d1484ec3f75bcbf416ad423afbb1cd24be6c7da351f2e2c1443670c71a7a65c256c6286345a110cca6ca4345eedce8e583b7c5f52b918abd877f165d35974031cf1dd81346d84caf00d5e9a2c8bb1a215d9ab40c8621ac17cbeabe4819775c91d44606748af53c56bb5c05defbdcfc63cad1eca95fb22f37255aa20ef111e5079f2b6b23f5d5d5b2e17b049ba30ca6b09ac36a612ce9efc17aa51700965e6ab370ad19856d238124494ab69c46faac688f9cf06568fadea107cdcb292f88472452a521c273fcc1dbc7ddd9518cf323f81a9cb03c9d3600629030ecc76b77935d7cd76a8daac6c29db934d608be4d7c7a75bf2e196e13cd2c95625e944b3ec60f78f8be861c747fe335e1fbc4da3b4f38de06130a493aa857d8c7a206ae08908a58601785522af631268713e2266bf495944791e728bdff02b92117bc1d31a55242564e0f3783cd7c3bcf490c57726003bffae15701ddf0e6011f36b560ab7e514c4155bf306acfdbdb97d42c561a002f71f0d7a25d0351e104c80f7c3c3265f6b0a58e99fc1da30fd4f762ba31ae26c8c9ede4f65a96d136b22c32a7eef5cae1b09051fb386410c5dfb042a8c1ec4abc83e06d6a8ec726140e6a4f9cbdf07bfd0e6e01551533b552c044589fdcbbfa17cd01e1b33a4ef4228ffd3ca16e4a3557c56a2814f1369cb44ff91cb1b4da1b9ea57afd393f00e0767b427912999b366f28999a353ea4e76059d29b42f63376a182565b0bc5572a7180745013e444548d5c0717b1e1f4345c69ed2dc3f28a739070f2ac8b6bd24d1522b891d81e4f507d5a5f27e3fa7d3fbbd9b357c96fe138d35d83d273bc7a6e4795a92a19857cc873f8f0c81ad0158753f4f58c8098119a2fa0fe476894d05d39a5d014cdad23c3e51c1209a2bd281d39236f1e412fcf1dc70697c4b8a1a164067edcbdd22c9fe9dc1f6fbfd808e77b18c18528bda52c8bb806ec1727fdb1eeb155e05eb57bd9270edf5d9cd5fce18855496a70db35624d3ea6fcf6c4a06371141702d1e8642907c3a00d4d72aeacc324fdcd3c0e93fa01595fd6409267fb3846e7e7b3dfc93f99ab0d821e44a58bf68b01654de3135d882595cda35e5c67f72b0a8ef315f479deca0d74ea57bffaea6a7997760f17a04b0150f1090ad66a68609264ae4ed6e70e8b503bb9cec93a3318a10a38064ec4a25a7d107d399d4599721db1ac57fbf85114c39de5518ff7ca3f7ec184484f55367ea3c94463667fff8a323a9f21dece502b1e995c0075241cfa881e63d5f8c2ae5db33e13bb36610ec6209a3689639d8eecd5eae8994bfd5a0b85c30e4f4698aa5b0ec1bbb8851d60a308c26a87f87a2153999e67a7ad52582f08665fb55ba755c91fc30ab91156b296a9ccfa0fd943d090865b91f869850abd1b47f4502f54caf4bf14ee449687879f2e10c0a1f2cae93489bdf2907e0a97df080e434d3376b24ba8af3eff177e959f02c9a50bdd9b20abf89ebd440e02ac18bf9e8620b7965e2ad75ba3eccf88c108c51e4754fa8dd15fa79413e8af91cd0d9b1f2954182786dbce8d40162913f01deff921ccb97e1d11e5017cb3f662666f6a0a5694f9b5bea9b1d11c54a1564e6c1e98b8470519e96f245471070fbbd6383ba8bdbb8fc4b297d75278f4f036eeadeba6b9525cdaf4e4fd660e5472d9cf28ff9177e355c70568980da396d14b17c16492c9ed86c2ab0e0d91e578d0e83a3cbaf77269c6ea9687ce874f243cb3c39230fc6afd667447d7e1a7f81ffa160a4f9386455ef86d95450b77e2bc4c0d6588ec969cb89202e21eac897d0271b8601912a9deb2c970053f205b1188c19237a916fa7ad55ad30ec4590982fa46dd154a4746f645bda018ef01dbf01a944adcbbd2119badea49e2395e44580955500b96f7a3b4962e02ddfd9d8851aafb8e8f0f0d9b574a8e84607f76413e3d06100fa51d1e197f6bcee176d7d787ca3f0441e41bb97379ae31dd904fd26fcc4eb1f195160b3746903c25851271c30e86634e4c99c15c403b25865927403df6d72f1504f0daa0f0c3ff49d2ad93e0c6c25b919d72d310b116ee672a518a8d750b80225eb5076e2954fe6247f3e6ce9d01f4880cdd3b868223c2a92657037e0f0df785c5b0d70aec30205826156d4a940060c305c6fc62c701512eda579be793330052935fb698880c3e1c12bba8e217ff30d4d1346af5f066d4d3242d3ed4ff9e702b8e996aa14aa37c52e2fa78a3751e2501b41c536dbb601e58dee644a4293373dd846b1ed454caa615e831a432c7785d3fde82892c1acc3150526f0ffb91b7ed62f3b2c808e98c7e30d89bd2a120bedca9bad9c58224faea5750b3eeb6d38d40a18c34dbd13b6dec55865d3bbe895471253b020f7acc8479d131f38f09f5192ab3f21ba7d3af4e3fe1db2c78f358b9d42eda89194f621b6146f6dcd1d009f28f3de0e4c205037dd6316e09134276fb28f03b559da2477583e713d3991638dcae4a196dd7fb69fc7cf1a6cc9fd37c6aed35c171e505c056f258b3e9e813e4bf439edabde6b0d1dfb7686286661176b7c583bcd2512d582773a1d220323c0e522d4a9c413295922cf105b676758faa8b92237d4dcbc0bbf2dff105511e0aa472c18322bef568eabaac97840abfe32f94e5afd44dd9be48e865b843dc0a808ce1fb56c9fcff1cc3bab1b51c3088c10cd79f2bcb426c9b83ae7c005b2da4b1b3e576d1df50c450c96322c7fda1441fd23f5019ea292076d2fcb9f1a24f10a5c44a6c62be0841535c7f6645d8518c07d7cc7648e51633f26ebc50d18ea7f918ee47f1c25628f3da84d5f60d85b5cb9f115957642fd5f7a363006dd64b8df874a45fd2d0e796096b6fbc02a280950d01ddcf76b66c50c43ce2117042d5aaf306745ce38ee810ad406ef10aa14020cb25dac26cde934191bcd06b147bac2da520f5184ebd0b7165e17e311bd646d8f04bcc153573e511bdb84c87de7b491e617374bf3cf8833e1860722a697ee7988065edc26796ef66baaffb863e38add6913b5a29b5114cd804c0d1adf19257403f96ea4d84aae7dfa54711e221aabde46651f7d9881eeba7addbd91847d2356b238ae38aba750ad8500a2a8e9636a4b3e91dc6fecd58d6a2f7d9f23f915876f263e409f06b118af0759b61fb7a739d227b657e007ce753264630525425e91db7136df7f6c22d37ebff370cdbd6973e94933f93592ccad4ae626f293002cef5a40b68796f5f2e35d974255a0149c59a8471d07982198fa6681974dacba6ebfeaa4cd8beb39ee130833672263a04eaef19ed5c1df0e18fcc824e833fc872f370a84f7517721df6893a475cab5636c530fdb958008bc8ebe57a3a376e46de07b092b7299dffb642e983d8027b7210235110aaaa1d37bd832268c5e728c7091c6dce2c6fc9e78df1aeb812ca0deeebb0825198e76e2cc316f9574fc0340e893f8c53c0938ce91246387825f5d077a29ff699766402313ee5a2e9a790f2dee0d70d73e681fa2923dedf91410548482d0af7d5ea62a276e5fe79ef83adb50fcf70e7b48d74f5c0378bfb2baae8c34133e1703dcc361fb7c849d03718934f85ec251a0170ef28d1fed2cebbb76590e718330b91bcad775aae7e6b55d458792d6c9820e22113826a32abab720fda4e9fb87caf9c77ed0f6b9801524d7d6717076a650fd4ebf07be1608933da3e6b4c496887ebea398b32154f7a8e9eeebf0adf50438396a936384813e4faec5466d57ae0f72fd5ec92e6bc4e798b0e19b8cf0d453c13d2fe3d3e4c4541ccc973854fda2e27063fcd246aaf41a40e1b271c72ffd65b9e15f71399895286082e9c2b7e7224b43fab35268478f32274d4db6f59ebbfb1d624ae8a99f96efc4b54575ef91273cbb26b52615a5cff7207c6a4f65e0e1976e7e32add0b237c02703f30c865974718f02b88786fd6757271c882b45e9588e9a1941d2ad20b7b75afa6bbee8fc1c99fef8d0684542f241c514452e0b7a788cd5603af3ce5a6cdbc2be1718cb958b74019b9f980046f40ed66ee7b368ef06ba68611cb9643d6d9d3fbbf178512dd25d52aa779f93724f001d8931b7dba81c46147099086eaec83bb10a769f78caf16398bdc5b00ba0fae3911219307c8c39eafec45522df952d11e472903c61709be777190a5178d697c60cc671a00c96b8bc383c44565e3a337704d352a72418db1d1fcac11eb28918cee0cad7cfd09850eafe0a49074e3206864519c51f4f38cacad1ce250bedf8c7533c55b4dcf7e712cbaec138313f46fd289ac6b278c2fc93af02d20be6ad23ca85076dbf7c64b2f499bf7427b923a7f2b8e6c90bb8d5a293c12525cf7aeaed54a0fb167b45e224cd8ef85b070951b2453e429fb9464772033d90d92ce9d542e7abe429cdc5f6962184df4a041f00be5dda48c8a8e379b900b3acefab2b0caf6ba6dd856f918cbe39e100c94ed9f025ea9340873f5ec9fa5742927fc929f1fa58e8844128a0e8e9faaf5853cc3249a97597b968e0117a96b4e7a9a0bcc205126bace868e3e019f720f87f32bb2d96746f7c6d3ef13182bdac3e7171c06fff898fc46a4546f128beb3668053c7c08ba1826c6a093b1f4a9ebeff79c449734031d99c5f44899ee28ee7b44fd3bf86b336798a1eca0ed744effa945677878a4330d833a4788cd1b3e91817d7699327869c4bd776fa98ae3d07a2f1bbbb4670ecb3e684bf8cce24f14ec263828ba579c3dfc89b6df4213eaf5b7e5bf6a5d02b706ec69a418200478e8eebd2cef5e14da7661b6ed7f9527857ac7971c14cfec5c0cc661d2895c5a6b386f73db37467335a3c7cc283862964d869b094c906ff1fcec0cc91c917951dbc745d845614cf3c36f5ff9c3bf343e81075845a39c705d631f473e49c940e586d1c9f0350433b5220b697f303835d5d909f187e57204294e578620b1ffe4eecc5df3984fce4d1e8e9032d2bb47a157b33bb67761a6dbe9a7d9220cef17aeb85522226166b7e9d58703fb3850ab1a73df51599bd91214d1bad4c20d6e9ca56c3987939551afebcee4f3bf199f923c5c6727424ee702eb59a8ba3408da89b6ae0d6eca4c8dd8d782036e94b442d304fba5202245e4ed758c286e5e2f24d135ade374bc171915357dc9a72f434002b2d4b14372f2110d9673a14b5cea07f18976b59d35ddb68d22bf36988fefbadb67e6635bcf669f15cbb7cf81b37f189fc7b8adcbc708c7f2b6a6e62ef3fcae5b24411cdff196d0179f6f11ecafe3a3629589ccb18eb02f1c34866a09233c9afacb8ae5236949863d99153860af689c4ae03805a360af0f5a47098559094592e267daa9990b75c0b2dbedba23625dbc5d378b4aed33a3cd8b5e60deb63d21c67644104f8770c4b2a0a3affa797a06a6670361384507001cce1092e4e6f431fcc7768b362d8687d3572221448e534f2757703b9b0214aaeb2f84bf142806d59b35fe5abd6ddf8a808657f3df7ef7eea629f369b2350ad4977fd8210f226a6c5ba79652cd74c8c5caf92df99bcc6287a4170cc3db2df47a61cbc01531cf4db4fb23fab058b1abf16391dde4b0c572c11fd7aef517b25c266a7230ba53212bccd56016f0f80c1d655bb29ce573c06fdd84d084eae3099b42ecbf1752695dd23ee8a9871c8b824416c204bdcae06b295b1d925428a4ba137ece58a36e2bf4855698d01ee994e8b3380c2d873d4e664c022292bac48e6e3ccc87ad889810c0c611c8cb4977cb0c723085961579cdf6084c9fb91d82466f375f75b512d1800e33e3d4984dd763d599401db7f728e75d78657f1d89756001318cb740fc60e4fbe7ce082f93ca55287eebc5c84520cf8b7511dcb706b3acaaace63aa2e716902c070d4a2f153175132026a13e75352b195f241868849b31b7ca0592624f7508380fb5823b45a7323fb48713cd70ff199c32303e2a12f2892a79aafc7ac9d718795456636d38618ef2e2f3b761ce596682d00c773706564b850236544641ea775630af3c2879ba59b94254a5728fc2912f1755f3df46e235e7112771745c7343c6d705a1bb3cf37278f4591d2b6691d2072179388354df7a5de54c660d67a265987bc26955b4f8269930839cfed982ceb401edb0e9ae74ad40471486c51cf71689f79460881b3b804810c830727dca0bf27eb3d71f2a6624d4775f165e0735bd6d1c1c7abe2b1e092b4ae4882c671531621490c0e1772de3117e3130fffcf5bc4956d53f3cf5547583634f4a59f0d9db819d3f7ed379dd4bf20afcbd4e6dc94082591e293013f1af934ce206b0696ffc24e7dad159a2f8415bcf4bd6967e514a7714ff8041a4b5abf2ecb6bccd667f631879d0bc8f8f47a44c77ad05b008f701e39dde886b270ebb37c97c6c7c3359969001e4a21e5b5778f4da176806be14f6d8711f86129ff8983613128df4d3823d30369328c5c99786f630d5992227627094023b98899340d16f3b09a85d0cfa65183d8b000608f00bc21f0346aa88e74e8bed399b66ca99a830ed1aa66e3212adac75954fe672c9d9be55564d9cd92ee01408867bd36a8f9c40ee99f64bc9cd5cc1bb07d136452e8e0b28bdf17977f35b0e1ae9f3cd0d8222a6c410cf0cacf9521019181de48f0d6c25b455c1dbaac51fed9b2a7be7787287079e930beab9c335fb591fa661e3926d7bf2049311deee6d30a4441bff0976030c40f23627c5d829839d663f2f8f54dfa05c58335d839807178c488c9b34e779edb25a5dbc78f94e39e585243f072c64cfc342a5e4380a191b2bcfc2dff098972a6118033dfec4b00d48c182ccc027d7b8f3ad2e2dacd3d2bdc007cc60b925e2b6ed9c9e8ee2fae3ad83be0ed6d8197e3bcb9d85d29017a8a3f96de4111740e681937ccd77022afeac954e2fa8f890b6ba69fb2aa58a9c50224ee2b9411efae656ccaf49d5730271e2062d6bd43ac02eb4d35c3081542233c75d02008540ae3e93b06300e8ec3f32856bd7cd3d7de4a245a16e24f0be69f28eef4c9cbe653b3ea8f2a40e1982c7dc54ffea98aa293e4733223a6392496a1986155302645495a092681421c11606c2a234888c6c02648614178c5bb714ec8059174c1b7f79f4d859a591ac6be576ef1d07759aa2fa651cd7393ea4a19b9e4d874a58909ad0456310032cfc84835d6bd0bc6324e5987423da9600cbd6f669889a5200737ae1f4dce693408522f4b8a5b2a1b97b9c6dc757b53260a7da7a111d250a1647ae78329619005081ff577699d4683f67c902fd0d5c9685bbe99ed870c33aebc1901d8def7a30cb414afed1002c1182d8d7ac74dd89f233d434c42e8592455608541c15413c390affad66333fdf785ec152b4cd9d0dba2fa8f4d696351b2d2197f811e6144d50635435ba9636d604cbf9b772f28040ff2251fe83d86ef8961abaf2b0a82f8767a33e257dd18dc205e5ec859c7fc0f2dbd7809ed947edbe16dbc08c38a33a0f96a2e6b7090b1455f0dafb814f331123dc65da9ec431babd1752b7a4120616ebed184d587983bd21b723341514fd00ec89e331bff9c3f722e6d3c3602cf7743d30f6c24c5e87b4ef323084e42aa82fa47e7a015502118220be182e76889145dd06f3043b1419ba02996732fdec08303e5d729d77ab20090825267ac9aca5ffe28c07558b2274f93143a6825846a162212924855f3f1738eb871446f04c85f80b10d47fc111ddf7b4626197dc20ad9e1e0e5c71b6f6dd4a0e9464388d1a9fc7b77627d6d712fb5fb7bb6f2d19e4e6667ee5f581b7b2f41f6b7491c7f6caf95efe6f330be84f207c7da6cc53f86922ad7848a661da258dfd5c29355e6ebd78928182c96fba1f494d21fc377a51bad8fd30805433720f02512854c707d3d74e601c71a95e788076816700600c642f46bb58a1f77870af6829b202f497ea23e8875262b3c1f5ad8c5416fa60ab4b09ba2e3ee952b0941ce9a9c878b9e193da0deb16c6c2030732c97aacf7802f5d6fbcc3701c958caac854e9521950c6ff638c9a28ab05bee0f118592138cb00190c76c6a4cd267df338d38f5f1c2b5ac161c3f454b65ad1085deb3dad01031d0fb619c92d4e98383299ddb5fc8a3356bb15123a51ac3b1d1c073d41da0032c177d1d96f77c6b2de3c5c8790bccef7e1a42fa5e4bbc6d27eab899e2a91d5e4b0cbe5190ef83d88401ae54bb9c0f0883e2bbd12f2ce7681c8c01b9cd30200916923823e99ac93c030880f7381196b9edd5cd726c518086268e630ebea50f8254aa2ed70d8159823f6a722adfdc8052419100191bef41c17e67a06b20127e4217e02b88360ed70540d6879c5ffd0bc91e1e71d80209affae387402047aed9eba994fd53595f00a2d29e690aa6e1ce09da9631ffd34546ae2b6c041137f792f9f3d355d8ee6650fb0fc7df5af7b7add398d66a070204f0b3de118f8ff0c980c98840b174f440ae857e5a51ae8e630e5fc0527561a74659de4c9ecadf97fa01299d42c182e17d43ba45ea68ef12164835bf99185cce8d4c219fcaafaca773d8af0eb8daa3ff53465ea9efd39f7ad32fc1921b0e698a4e529c7612fc82e7a11bf8189d2cafa1d5d6097b0a2fdf592b1e8105baa3ef367c3cf1472ecec62d4f5289d483eb36adbb1aaec89c7ff4b66b2630ee344c8e13347c8d53ff9f23edd5cd97966b8ebf570df30651f51f7dc1cf1c7ace79936731b59b19e00237da051dc4d7223634c56c9165e0fde922c84e1520746f16b84b90cf9ad74d62576cdcd82c7f09d8805e0e5b9b195a793fcb44ee11b998df953f4ae01ee0d2570895286a742ad162bfb58f23b39c96c8476919045b136044ef463b4e6ae1a720a7be945f9485849e5b61db4b754c5c0d47492a92eeffefa779d71da9715195ad4a9481d606ca8267f02d276752655a27510f662f12bd6e1c8e2bc4e51fd9c04bdc9d2b6330d4044c6caead6857961a43c8d674fce03c0b409007fb2433be37f9930559e53d81fde78501d7880ef8ead28d945ced67008b2b217d487976ea5e11dacd46b7505816c017edc7137bcc213af3a44ad325b3c12fa6da240aabd8b9f077e56caf13b7a9ebd0c7f1e18ff1979d4596421073c7a3f61b9b469a60a6769e32aa3acc5eb4796b7976cdd55358f228194dbe63d653304f857dfe277259c0347a7118ad96bdc47772d4ee49f30dfbf827dc87428ff17362286f80cbc3e3797ff1db2e959e4ac98f01102d1348484fb67ed3377d1052bfa3c25b525644fc8eace130006f64fdd4c060121c2f69bc4371aee5c363c7a550eddba3831b9cfe25e326afde622e3791c0a30e33aa376b09c10a3cbf3f33fee0dc30f1a067feecc77e4664491be267dd387f8cfcb47af549ef391557d0378779cc8e1aec39cf5daffbfdf28f08350e891e1e54ffee688f46a2febc95c2a796901139f53e5a14c76e2d9e91557f83196ab36716ef3fe449cccd20c565e2dedce06d7d7f41cdb4c610188d9840159f448075f586fabf24c58dff45bd6e5f5289001db9fa007f929c03fe72a03df0aa37ef63f3dcf67ba437ab1ff6d233553ccda3f24ffffa6d09beddea17d44095e1e2c90dcec8f68e4caa8a302f475d7f03fbd69f0c1dfabd8160f14252e4b981b7b55bed5a48beac20afdbf91a28d509f251f105ffdceb5b580642454b1eeebb8a675f0d6240e3b203392a7327dbdbaa5c924fef4030dbc0676acbcc861705aed1f8224ede6ec253bc30e2d86bc00cb53b573e4dc7131df14c9aced93e87bde3ba25577ca897e8cf215d1051110bc4fd10da4c26de78cadeb6969aaec1607d3a0e63485d0fd765afc76b43231029c28ac205265d10cdf69aa9e6bf450bd619e8e6b267712d0f1461b4b07e7d3fe58246ba4da021ee8b12c943b432fe45b0807b93386a958737ad0c05fcdcbf86ef6474badc7b7be57b54b63ebc742a1988ce00a4c02649938b6835379828141abe8ce7983cbe5fb837394c33630eb57babe920333c3f24f08f81d754b7bb46a3f0df738ea96d5cf1fa56751228dfdafeae250884cb6ca02988e19e3b35563dd2268c4faf7f87707a42cbdc83d34524b0817a579d87e502c86ca7a57e313565176a08e8e86d0b4819d236f601bef8810481b6d7021eea0aa4efaf8329ec9282221b6fdb4e08572dc7226faa51325ff842e414c9120c9c4a1347f0ae1f7793c62fc1af595b7f4850a70688878ee59035ab489afb893b5fab65a8a7e88255b8aadb00fcae3fb9f0636e12d70b1a00b7ec0787c36ae3b2ada1837251cfa39d9ffec76f32856cbc73f718f413780f4ba67d12b1e511a337060185bfcffbee3bc816ea66d23397b3a0c6036cdfde9f05b56f26be240e6c7dcedaf64a3760ab90ceae7cc1bc1c52c2fa587b47d0825de1afc2cfa5d63a216bc71e1c1cd572c273fbfeded23ba9fcc71ea2d7ee2ec6c9816bc3a4cf46ddbf670f118930d6b252f2bfe4335ace917b5b7c40ae5674e97df55f2b2e3a52bbb197e5e0884beb86f99038e71de8f8b60f62c3289cc3f5b73ddde3fd9cda12d8c5415ee72bfcbf5c023722b8e4cb3aaa9b720f7c79f037083a69a9910e5ec23add5d0f3e20d2c2c95f0f91ca58e72918af77975d74b461ec3ff2d1d3284b67d63dd147f340d2c45f0daf66f2af0b3862e7e3ed8177deafba14bbd64b2fe880b67197c0bccb6ab8168805f8a069714432e025f83ea4a215f4f2b29867fb641df0fcc87272457fc89292be5c41139954e4053378b90512b7591fe54a7cd9ad6ba36aeaa11e621a77000d3b0a2959e14d8c5b4e03f9b9b108b91000d3a51d5db02a99b46a5c8d6d257ffce6912a214a78b393bff7514da5849ffea25967175855c7cd3af106a3993ecf5ea76c1f14c5e20654f61466e59c00716260e28d1bbb822052e8eb5cc3067332ac9f7d8a44b72c3041ab484595bd633702f214336f7a86295aedc609b544bab94a82ed41387abe50096e4503ebecd2e5430d3f54c31e7222adedbf232b4629eda34df0681c119bbaeafc5e0000281005dfb19fe5f4dee1a9d30e0fd1102b3b80faa8dcc65b0f8ce608851dceeba9b47b694967ede4dde45a88fc27a708b2f26640fd6be7d162f89454fcbf8b769298f80193205b672bc57aa74e48225129962dfe6818534abecd3500cb227a5b17027b2fb06a4dfb52081a45107d3281bdc6acb715714dba22773fc9378249f6096fbce7a65966440be48566eb8d7526e58b2e5908d8b73c215b3fe58f52abb89f09689b49ea70d4783ca6a8fe0a96fd059c7fd40accdd54bf0b1b0f160701785742453f76c12c4d1ac01081a18af658c39f33a62b8bac5a48b915e0a4446d33adde0b9ce52fc5e213945f88a725f7768e321c3450e72ca2472825563456261e24c6a82bb7275d1be111963b551cc4bcee7d9005b486c0475daf3b4abacefcb6b78c0e275956c1ca77e762278e591cefc2727e83c48ce2ca7e62aeca8474b2b9b81db167caed096d989be536dec164a6014e29076ff7a9a1be03ee684d38e61ed08f023e7646dca69fc0ccacf5cba012af1e3536971f0028a411cf06687ac74bc4f5a2cd413fc359e0e4bdc0243b11e78b214a5bf164ee58848bf4c5ac269b06cf124aa6ade465e30d468710f530f4fb0202e1bf9fb11d1397641ac33fffa1bfe83a85a8e92d2b8eaed6e4b464ce77c6495b45852b1ec695f26f367e820b2cde4d01ff8c7fc17ad4c1f31e3f02f1483f540beb843c66ff32994710b952e7ec9bc3485ed9cf475593553e55450d3a999136ed0ce69f6d871ce02d609da954c02fc0b1f2ed0e65d2362cf56a0286d95c61312ae6f19d246066ab0e3d8e2f69be66ed98c33690b14d34d388e333c7495284cdc90911f08574f45b351de580fbe0e893cc79ae7eca204ea4d5eb79669b54c4c59bd39c8fbd07f5df9d157ceb5c70e56deb5847cb324561c4a434764c992958b170e6a83bcda54dde9c1dbe9aad937e9dade09e9a9ffd5dcc0c3c73e0f17d91422649df1b0057f0d2d338f78e8e4e1bbc5dcc08df9143bb8f35beca73e98173bb40a575cba92b5aa3ad3fec6cfd5291a3e39b73858e1052ac391761f12c246ab578d4af0f2ae1dac52a06ebfd3c466a4c6434aab9593fa2dadd9685fe5d6c5f57ea1dd16a4e4d8c282ef45e4b261dd4a34ff912b7dc90290ecf6790b266de245caeae55a42da51d306289b30623b3e041a445bbd9157e14e1c3dd0b50c3b15a3a4be3173f56180d0ac92ab57743df53f05c66ceb9c0f818c8e73458da4abba7b4dc80a17a3c3604aa72d0c64d309805fa3e675c82cbb06ad2eedfd5e753aec0f8f8bbfadc72a0f0c22fad6be5eb40fd14f74eed6d252beb955797aeace3e81ae20024f7d518b117b0fdbae355663dd87f6101bed9871c9d709dc5958ab1f9ab1f6e3551922ba70b8a7a59869f080b05bba49b8692edccbf28702e3633883f5619c05d29f4ea4a57c39ee5bea79cd73025852556139e9d4287454d77a5d29da539a51acfabe1782d17de374c7a13a22ef7a115c9ccf268e4929d3eb39ae327f2c6c3029a4a77df224b40b6cdcc17986326848f4ed5e511244bb714b61221099b679c57ff63c5acacd31cfbf7f3799a18c59cf0a68a0592b39b14ed78ed0d90083f723b38c6465b0c42ca525a206738aa0c18bf095fd2d67600056fe38f6d67cc586e4ad4f5e39b1098f67e85b20fb2f3258acf591635eea2c555ec4205a0d59959ed62fed0c6c401eaa575e41c4bcbc6ab2cd3ef899c63f4da7937685be9530766f1ed59dac64cbaa02fbe85f9cf70fad9fddeb62aaea48d1c38f24cbe974d1ba8614445cfcf66c28736065fd168ebd1151569f172cd98acf6f9acf0642957852c6d032807f51d44bd1956bb2d444970bf117d738bddcb829c5903c3bc5bdb5022be6546eca011504679718cf4b563ea8a4263e9292fdade3a48b08733cc4233676df09491fed766386c7bdc66d7f264f2f932fbeedfffbc83cdf78884c4564c8faddf6145c8644a463ca2097fce8c0a063a113391fd3df1dfc89508bad8f58673672eec522cb78f04031dc646d62474d1bca70565c2914d509caa7fbfccab65a0675ea82b11ac0adce28054a767722bfb8e4375d749428666fb3838cf317df1d205fab764c5a4064d6dd17c6f05ebb33c2c729605d0d13836decc9ca1845fc9cc4e7ed291b1d587606942398e90b2cf83a22b6bdf02f83f89a33d1f2792c62283c441bfe84bdd9ae89bcfe6e0c83e896bc2a8e302728b005f0044a4a29ef61719c8eeda5fb11427fc419ac0227cd10f7e614d15c3f830a5ed0a8762e17f0df9bee5aa9bb150d5f37b4c12d992ba7ed79b857f321fec22aef003df1b5ca90332aec8a08fd69c21cd3aaa4bd1406e3c11e90779067066c48da8af7cc1a546d91ed86ea5d9a8c590fd4b6eff40d991e9f040fabb235e194e38f612d8c3de5918afe7f19bd190f0f003dbf0d4fb8d1f6f2ab0c49333ffec833ba6279f2cdcebe3b2db09ec82dcf4e141f06f726af2f9e92f7d8b73620f3934581a5dd352a50e0fb457ca97bb54dcf0891fa80dc04cdabcdbc70c43a795f22ab2c4335a56df95cd5863374d6265c06c68a105decb0687aa2fb8188a8fa50eabbefe27bf3cc69b6e93a8ffdd69e49a108453a931fed6abad593e680592600552d14b09bac8f0058901afa4f91d5157bcf5b85da5505c568996053ec4728a6b27139305bbce7ffbecf4dfa839d1c58e2d96e5f9a9f65ad9c6f2f4dffae9d0c3a567feb0a579169c106e9027020b86d958866f11992425f21c57325af9459cc90f41849bc253f9ad869a5f510bd97fad5a9b1734621d8c2ec322f8f89df1bed19680fc05a69f7366f9480e71a848ee997bff759c173d89e9fef8d4e40e84da6fa2635f07dc1309f50f3ff77f4aa70f0877e90a762249e197e563ed63992c9d60624c425f349536f9a570d1ae27c30b4470d869cd6064c46f16cc1fd7b7303bfb3a3a38a6d1e8089e7ed00c7f152c3190e0b6ed17a2439262d44379e7cb9b315ec6bc7976272da70e669b36970ee83330b64d961e76cd2e937d3f7b79a2fdef0001116ad509583cde197b3996352fad42222c30e18255f148aac5cf6364c67062959a15985f7d58aec10c6897f40612311442540d6091c44f8a97fb249fc760b5a9025a3c0e1142a789193e81a562b0dba92774bf66fa1b971917181ced6191d29a0a95871025dfe1b7dac12aad3261d1a8dea4876fbd620f7787b0a46281954483bd801081580e2a5b46b7fdcafdff6dd06f5fc737cc27572ea94684a0f158ba780f09eecb03995dafb9775ce2196599cc1406aa12a0b0629cc03b6ff760793cad48e6544df05275eb10df849e53a2e9f53461493396345029481abfe8a1e8a1df89c6c4eb635ec1a916a2bd2f23e173de34e8ced2d9aec9940f9bb92d0fdd75767803acad7deba0abf965cf84cdebb8d8dd7d82d8405de7df1a9cf4593b4d43890f30e37f50b758a62afb249d11a5fc46507b62edcc20004fc9d479dddc753dfa72f8202bda7f1757cebb4dadfaef0b06f3234e2315876e811abf0df7509bff99d34e4aeae83a23b3e0d8a74655eac0571e46f03d3afedeb719fa059f131379ac8babc9225f3c320de33f4ea9d037ff1ab0a1896208d11305010adf61770211e813baa94d74d8cdb57d23481bf07e55f08e5ea2b4879bd859410edc84e78274d83099c883d47d725f4ae9afdedd5df9c6360cbd1c51b47e3f0c60775c0711eb21617780fe6a268d7c725ded2b845d4036b9967c6091450ed7a10a33340c8da687522ccd9ffb6de4e243df518fe0aa8780b6fb520048e3784608074a5dd38dfaea95d6de72a855136dae03526e559cafa6d86bca8a352a49de3c9000205f4e19dd907647e1b9e57b50fa4554e07d2529bab3fadfcc3218cb322c7b08f0c649830942ccc281b92303998239284496367c83505a89553ad1f74a37a0932adf2e19e4f095282c2779e7229e3313601356820de2ced183f010b2ae23e0163aaf539344664491a14834375b6ee221cd27e2e95cf6862a93dba55c3136d93fd4d12c71a3ccb040d31ab4837bca219533456a69a78a8f0b6baf3078c7ab2009df03b810b436a34ec1d4a4f922823ac219f9c30d2718e34dc81542dc68d208560af15f967a6443b5405cf1c5d81e016898c3854dbc949d6d7ec2c295003c3d0f307b53e224fef48786122915a79632683dd3e80e9715678968c3c85c6d00df8eca75464528c111c79f29dc10e16c759deef6f2b077b30183424acbd3f0759777fb6a148f8748ea64f99b98625d34a4d35bfb5990b6977407df0460fc1ec69cb4ca9cd82422cc8a80aab14d2a8bcea4fbde3729793b561201600024563813cbeecc38e568d1d898f6c6950bc067a2089ab3e0e18db0b3fde5db468224c80b1d91e26c6ddd075879e66f20571af7989e19c90b01e1da936c8c7c59728d5f034b71a0729c9fc308c7f7ca2e36336ef3c88ba2ed7414bcd6de7359d5160b340e9a46870be091fd640df6437354ba0ff93bd21de0a5885d1a71ba50cb89b9ed3c35748d9bac718ecdb0b728441efcfdedce3c5546355fd4c7c861a6a7ba5c19ab70a79925a8eeb3defbc51a1c36e2e0684c38f2e936784d40394acacf3ac0a20cf1f9f52afb506b2c0f245340662c90635bf6b0394920d8742e9eb3a7eecc7305abc8df33dbb941c2c0a33a034e38e5f011c0347753c69bdd5486d09483e6ec97ebc117334216c2d4abf14b8b4213b6f59d395f0c814b1476dc9d877d37424ed1c9366e18a44e7cdd61b0a5add011fc8d1ef09549816ef9503c056607f56f19aa9f3c62328f7fc120f7827b6e231084785c321c224b69807fe4f2ed78768a803ac2ec5e424652090f798a7cac736f4ef53e6f6727504532b981d64361a318592a607de15b14bc94f3f67bfed7acf6b9015f46451cc3369e6f5e1be3bbcfb0406209242327bbf3ebbb37f650d034c9908837c0728d6e712375c15510ca0cf9f270ce3996209ee748fd506167c702543b230a89c4b11478c71d4581e1c162149ccc21e1d19c359fc37a20c888d2fc974a8e43813503fcea0d194f657f01e30a2a8b9584400d9549571087683e0be10d13fb36cddacf4d2e5a1727543e195daceda30a1fb111ac6ef81bb1c532a68d20258c0b9199fa63262240a7bcf24eac65e1dca9fa411c037a035af6306a10ee937004cecc19723277649e95c10a760527cf29317ae0113382af2318c9b094e9c9776e7ca88e40906d708aeb5e13b411c5b5719dc63ba5de8f680540ca5e53c6fa4f685e849b3d9685ca436390c967fa5dbf0192bde87ed0f4b9e4d3f3812fa9f63df6762b4bf74638fe42b38ba96fe28e7444f7bcbc056e4d34c31b8fc90e533230893da80604d2d2a2a9a50f252d9207a1d9f05d6dc0967e12ea946d1c7de82431e2a3447f7ad67b874be560da95014821877524f86ad487cc28f208a934615447f3255cf078d4b698a65eeb47bd570ca5dc07903a2ce3aa06a50a7f27d208c002b59ce22fefda652e38886f9ed7219e27f18049dff88dd7147f0c033633db5a0b2feb46d150ee9192e29df94726104918815ae06d968434ce631588b487bbabf701abbafcca7ebd3748c80a2891f5ff7845d4a40e7a9a688739d7be5411951cef328730eb3775a3ce629136e1d1b84532202ef4ac857daaa73b0e3fcba7fd08550b0fe688b64dce8299cca1fc8fce541923ee500b9035c1489859d2310fe13fbdb9e6c0cbcbc1ccdb826bd368bb3eaa9c8abfdaf345a58e071ec6b6edea9d1ba33f531f47da72f1cd9c9475e17f934c1edf67722e9f58899b361f56c29c8dc489addd410d3ac2fb65a2051b4bfb91436568639c9ea24855f6f418a8bbb60f3c3343970c3acbe4983ebcc28f8a101f71c2191388ed916139e2cadc33df94b9a6fa901ac7633dfe20a2a7e0c14f971d4e01b2b1e3ebfb6eead747b27011fdef3c2a25684f4b3aadb908d8f1ac1e147f6d24c9dbf900876e45b03e68744c2f6bf92c4c7334be538f425138229b71fabc4617014dfe33aecac20a510ebfffe888a960b6686505b61e56f63b20d7618b10d4ad64912ec1814a3afa415c312d03d5d4deaf761372c5bb526ebc417378f834ed336ed8a9b262fdaeac2b4c30d7ca9982a076a1c8cf7c84e1460501c2086d9fd83e4f27f9e0e33c793ee93ae32b2bab016232884bddc340ddba7125e2f0621c0d665717561ffa4f355287e5663fdde5707b8bc190d6272cbebc278663233392eb37372d2d3c3dbde077106da980b72477fa68c91fd7b730004245f6338e821a84511597158cad8f737d3ae1b30555bca9d918845bfc4c9b373d666efc00810604daa8e38586253bf93827b82a9fc7371ce2c8a6192d2f192cf2f28131517002b8c5bf389669f2f8f6110963a75c51413afe2c0755609f8d1cfb5280e77bed0113c8d2fff363f86a82b406fbcd0f9c560eb1d28934a51d7f745ebee8b0e98fa408d3eaf76c2e462fef125eafae9be27fd516bb408452eb6bf4ad9c377d615f8bb4086c4987a3076eee71255f56335b5b0ed28a09b15c4becf63777e7f2454584f563b018aefe63b3a1386861dbfc10fd63487e9399ddbfeb782823a737b34fec7bcb60ad1c2b7f5ba12d6e535597bd17d8f4a9f990574f043c7616c3f01b006405c9b2b81d46ee90111a286a4f45a13237363df2c6ff5ad4c9ee89d522cfd5d9f3f1a5a2d223f6fca4c5304cc107a40dc9b1d338776efa5189d7cabc19b37a7ffad8d8763470ee9e7d111c475ad3e57848d8367dc49d072a59acc840d6b3a4f685ec453dde21385b8aeace6b07026775bae439a0b434d8761f4ca373358b003996432f90067bee3c34b31567bf07c5b181fb9105f9ecbfd6c60c6c46cfccdab0c4de6d04121147fba8c244008d2f26f405f8682831ddc17efc9bfe084e7d9dca1818713875de1c2415482db399e32662c11950790a6b9857912d0ee61ee63827fc674106bc9511f2fdeda8caa4691af2ffcf0bf97103b7208e6b7151180e02730cea0b5ccc486eb55f85c5de35b09c8e60a9cbb36920fe62596ef9d403283692fc021cb5c13c6571be7fc35fb6af45928bf455ad8be5cc3cc0d933ed0e460704e0ad7ce48795b56e9eb57507a74704c7240dde3b491c4b1dcbfe1216f9a98f7c8b586029dc7f73a569d43e17ab57f2a9f04d7957770dfe339f3ca890270dfeaa7f4c4012ff5e0d604eabac8d6c48f8aaeacb00e2839b2dead86637dc09a65f1b4e5a4814acf2e8c877c00a94586ef4a3806fa93e6adb681b0646798856d36f8eb59416f68238f6c8821819025851aa25d92498f8726f5ea3647ddc31623f6daaae70e3d246ff363245418561b50a4e23ff5e3f4d4c352c4afd5aa02e5145d7f8eb8b336423397959d8b255545a31e3d445d9c905077d82f9324f198b6139ddd60ef360bc9ee583325bfec1b6565588ba3b3ddfdf82bae10467c8b1b6657f6544ea5cb9c846d2f25c4bf738013d226b7818e5dd9f1778ff184c1789a5208aed1eb09bba4778545104136ef6d5c60af9d43aa42723a77227b8a0302e6cc8b363445750f185a23d80daaf8810642778d0079e185bdd2c340d92a0bcad83c1e182bee73d26ae75cac626ca9117f348fb0a9e902294ae5e12078969ce1ab3f55a05f0e904d4541edba203d607b74f0767d7d5cc4a836b74ea8149e021726e983fa6f57ce1559a8da2cc4c7a3049886a0502708a8bf0df2e64caeccdc3e9efb34bf742e7d6a0a64fb7fdd38f59f657e431bd4155fd37656a03e4019d3de66653c0eca36b37831efbfd3554a094a10d109784980b17e137a5efc5614ac53d0d99ee915b84d97f50d16f45105854214bcfa3930ca33f65f3a6a7fe7d10556a6f6a523857a58049623c4f47db20f30f52c80baac137cf4194e2b456c17edd4bc7c6bb397f14e0579ad862d15af005d120751010bc4b63dfa9f182726afd0fe590c04f3630efd91cf58ce252836b4dcdef830415fb02c361a358801ce4515bd68a85c73cb1282fa689fcdf28d0ac7bd616cf4532446d6f87d8bff6c43ca96f5037fda4476997c43815132495a120ae2430ef025b6efa8dd5ddab038b35184af0540489999356dfee00ceaee6e7304f4581f6211c85d74679714c77780b4d57d5b14d5f4487cd9baa8269e288cf61832190d01b1695baf474efae23356a46db1a50ef42cf82069c1614276b93bbf5a8681cb4dabdf60e905ee8bddccf346ada5b68dcc8cc2f7f3fe64d9342341e464dcd7ad6963aee40c16114239612c1e81e3338f87ccd68f3c84e3e05f3f311aaa9456478d0ce6d7b0987ed4b71a5333159cbc25bf1c64c7a14bd5308c2b2d5ce19614126c3ed94b3b8e0715766f6b75c10034de15c154429ac110c7d369049a718dc6db0fd34fef6e550fa39c5bd5afa0a12ca9eaded70b3ff33a9351bd48f04cdaec003a4cdad2c8e682568236ac36c1c9cfe78a5951b715d8002d0c42119b8464bae67e0b6c095e9b43a9fee2bb92b8a3cdb70659f28282763f9513bca81b0496bce08d78fa00b026d10c9eef78c34036605c8fcb6cde5bcc1f5ee2a60bae3a700d55d74e6152ea3c2d7bc6299b78499b5a9a221d8cd19e281e2b255c21ddf586aff3b5f85aef96a5c6c7332cc3979af096a3f74c00fc5d7fd6f893d9d86c853187d61b86197a126303fe1471cd416db08d8c0fa70d86ea336b7567f4ffae4f1611290e596bfd6d795c537acf73d026dd8c86467436e70cc388f86f1461fc59307f0d1f9cae22c57588a39a70e84d93771caa4278a3c4d622bf2892b9be81c26af3483efd556f7b99db0f700ea32ef1ea30d06206e31efcd7dc1d391c93c591e4751147c24bab5601232f87997b29824814a299866f6c316ef1a6d1aa4b7959ec9e7330b7a4c50469e02fbddfaec79a992a6d608e9d15dcb0d17d01772cc49fb96a484ba416aa1cc0c06fa79bb6dfb80906e56e3d8021901503d55f604a3a42af757c76835309a945bffd359661e9a9ae71783000eae21135d29529904220b15f37637e159d2caa23ec199216da73631ba8fa312992d5e9a52ed16214cda1b6b7c71afb87f57b985836d5799ec77166abfcdca24bfdfbc716331fac9c32a98425b0433e628d95904d8f26716c7404a90f522040f1715195e6797def4786e5962aedbadc4aea4a9bfafd9d3af4d04ae9c52ffb67f7fa3f914f3a7dea74c4610de5eca4d1a9749c3ec2d368a3efcaf78f058f87cc07bd8aa6858b7cde3829f5ffe4a1b42e323d87d3ae1e7e2f8e9a11474d12e108b61451ebe02797936b11fe7a65e287a63b287317f7cc87b982aa984d43226ade545f96e8b4def2a9346dc8ba9f2036dca520ec289851add7361f284f709893442424e6d4e896bdcaf9f52044b1be6eda00579707b5a3a79878f11a277e9be6c7a9f0bc65f8b4fd335feff00a985f35fa34a6cbbd2dbb3bcba2e231942ef2be11db42a03a5b93bba3b2b12a78d4fc521741a9f6fc91c271377744311f9eadd08fbb8040f4d0926083f945ceee6f4a42604b273355bbdc8704baaecb702f46f499447124b3d26a17775f3563e01ede96e119d01ebda06989bf05de2a594071e7c2dfc92ef972a6da3f86b1f9e824f071d238cadeceb191e93ea8ba60dcdfd7258fe587bc9bfa66b6ab5f7ebf60dd46dc6119670e371832cfee040dfc60a5b4d282efcedbcfff0a5718f5ffcbf1e6a8f9183627f96bed1b7b6fd4589adafa273e938dc1f5807f5b145ffa2ce0449df5830fe9d50d14f8ca8157b7af6b4c540eaf068dd6e0da09501d25b7e85484cd404bf84eca82e6f9dd10432cbc144e49fb990a22cee0ce06dbb85dcd30b29bb5f2c83f45b47aa0127c3ac644db2c603587a9ba064edf930c53e783a45f929e280b3ca25d7d0c8f923c89b95704c8f5c12c069019fa7efefc217539f620a37521fa16011c7a61a8bafdcf393fb6721770fe12b54419deabf0bed5aac316a098311034553f2653b09de7546cf6ccf53c680eca5b5cc8a38e374f997c6fe0295f7a659d3ae2e7675a922f4af04564d77650ea3d7633dbc6a502182e99feefc61cb23bf603283c5777662187e460d847ee17c66e3eddbdd9d5791339ef948b4d9a988574b540764d9952b6776b5916523fb28637f7b612bc70155c56657dedf16930f2ee9914e1821d6c33cf07769b7d4f752ac6bad8a76925dd18d669c400650fdd6dbb29ced9227f7266ed55a875b6cd5aaed57391567b287f893905bf6df87bc39c4c78bf4631e78b487b416fd0e08cfe9dff7947cec178054876a344836258c9370d5c088f87a08898a0e29851d0fa12a2bbd83202cebc944ac26e66cf610f7bccfd89e82883c9da46adf331b3cea70ef3c399e3b557d7764a9e353fcfe035ab1d5d45bab0142a136d6f98e1e39c5c9fc8c53a8f58562491436904e8eb721827d17bc2df6475e6b4b469b54dc2da8ebbd908f66d28a297e3b0b6c89170dad5b7f5545960d9bdce3245ecd25fa7f0f74a165b588cdb5b59326ad4dd3ff0e9dc50f4240cac4597ebce5aedcf66dadcb690e3f15052d8a315a45f72516e7171c63699897f1412872d4365ebc79b49eef50b570fc1652209feeb940ddffdee59fc9cd965efe766b69ccce899caa3c4d6a112413ff02275db50728482f064ca5f7461de86e4cd7bb868973734bbf3d0fd688b117c4a99d86e8b5caba7fc07c72c7825f15a06c9a5b53ab24e599154cfa2a718185be894b0f6cfb957f2d37d6efe5d1b44e656f02d723e7c9c06abac25eaf9a8f4e876821e9b25a717d9874988c353c94209a6ddeaec5bc29401bee9b6e308bb5c38a5bfd648bc1ae5228e76d75f4571e2e4a22117c5de6a94e20c32f7f65d4f232578417f58d6cf95872dd55fac1d47c850dd9a3eb8075f786b1a3fb6319b6f2ffc78eb6fe81d6cb1df05fb63ee3fa77b91f602ac7bd09661fdb5a79655a2842fbde4b7e68ce7986ae35962811127361d2f9e588a5596b888c9b512dbfed17ca8e7a8a6d764126b534b6ab9c2bc193f803c88e6b92c3fe4fa4d758e0bbd79ccf083196b0ec2b8e408f6c138a5868db592cbca3a2852376f9fd81844dce43dd52a8a5a7bdf3e3decb19519b0909810e2b081947a0157c6b5c3f4b7dacf12f8b3a2a6fae98057175834ede77f74a34395fa066d195ff75cb9338308b30473ab41526023da3c2b6a0440f555e0a537aa5fc2ad47917a4a6d9ac7e56f0678d609b2730137401733f36d5ca39085dc23e29a19f74bd43413af14f6a5e33aa64d8d0d3e5c7bc546d7385084effd839ff1fe9434c26e439285367fc05933f10fc7ac55a66625556e0f9b2e9996ccb1385a2c87da780aa54159bcf5f8a412b56e7873e640e096efb4bb541957810fb80579dcd6310256dcff5b7e200fc8ea244a5e1399f11c02e572b38f119aca5b5e5d89033bf401e5edc2ea1a1c419cb01a93cd23bfd459081ae8cd23a8c27f6e6a92c72abc1bac7acdfed8f22e0e03fb45f026823aba678ce0d693551796f7c8c2e756c7dbcf6810717ace527d5e1827cd7a918750da6495b008d7dcdc03a79da47c7e6f45f73251c84d8196bab6d23cbea3e7437497f8b09fb061b85e6b5593f7bc92677d9b14258a5df3c1489c52baa84f6d2368136cfb114e8f13952e70cb81483f56db55b56f054692aa993067383d82ddb642deb5b42dea2add44a4a13a99a975eb29bdd0710f87a4e88cf88bef9bb10d48d9752c82c0c47438c39b828932f64136eca0911cf0007ff3582527a20f0e1431b167012ea5a3d8872c21b47d1e2e3bf443febd15dcc4a4cdd4fc1e26619ac29263f784ae19ba2a5864aef73c17f865095fb289bbab88ef2a4ceecce2dde87935e64befaf8a6ac0c57d5519deac9f9f3984c311e8c7b9c3b2b2027bf8e0e56ff3ec35cfa4b4de44ed0039468171b33a8fc7e2ea44ee32487e8cc4c85746dfbb21689ac4974b8717e853d7c7a27945a7bcbd40e5aff44a2d96650097f11daf53163748ee30f3da2bff6934a104a59ef034833b2862203079dccc9bd0dc505ebc760acb33af0246310439fb70ab5a41e05858cab244cc7fd805681e8e3b65cd70e539841cbb5d5ed8de4b5dc096575fd85368d641b59ec9459e04927de901c63801f7bd34cd337c5095d25241df02faec6c78cda758a1380b0c79c80d435ba19ed24227f274cd70463544c0e80bbaaecc2922e2458f1379202f84f347c614d39d2207ecafb6cb1cafdf37916a74f24b7fb0440f7ca6312656ee82320caf2167e8db8a8db01825390f2beba88053429759e86163196c90f7e02bc2fb1275d48af2802a741b6cf0f65d179139009e3ae0879fad9aabf48edd362b386a411a9d6a869611cf9646a4e73993dceed45422471b9303daad2f466abc5a91a7c65b71862a5ce918bc8ca5cffcf346852134f149559c2902c35f1d2db4d932c09e914b7528081d7c8a2edde9bbb0a0ed6d3905f7352ad7a5bbc7b828a9e3245d8706bad814bbfd57c9d524f04c7cf1144f391310ed73ba0032daf416bd73808b2a44bf4af93f0dc143f4b511d1acf94cd544ab9afb862c214592c4285be1aec01f278394078bef3d687c3c82918dbbb951300cf262949c9eaad084a714d0281e771b6b8d43d5534afd77c6a99ae030a593f8c48b9e0ea59ca53b8b9c98992e9bc14eb0e3a0883f352addab468f98993db581d9586a1d59654760cb3e23215f68b4a1223a08c2d6101be256b490618dc8eb91520906ff9ab25e9b3b9548405b88946030689c5ba1352be98104856c6ca5ea1f758808683065edd115f7fd225136acd5291408b9aeed32b09559b2a7e180b9a44ccbf82cc8b0b5d550169f3b4478f6a551e0761a97b4bd2fcecde8a6f118f7c37a14359e6950dbdeaf5afa4f62579a34ce1ed3d4e60cf6a37095902beb63c595d0ac53d3c46fbd73f1926e346f099b352201c7adb7fedcee1aa3987802557bbc538156b48dc2a63e756c19f617cd7c7725f8cb62f27d2b1ee2b6b2721d5e6786d86352ad061ea3c1e31bbefec306087d99b8a6792b2191074fac81e4c056139db12bd1b9e288e5b68b3f50885bee7fc844b9a7350c5568f1c353ac8d735cfec8eae326dc1edee4bbf2d65401b6327cf1cb688238a98dcd6408fced9b1732e2ccaa1667edf32b557f52568fed9342d846e46ea161b67a193afc19b29773b7c7652c997fbdd97b22b58319b54738fd50e31834657940c65803a7b8fda3f7dcada3c40ba6dd083f3108edb0a1ced41df0a25040cc46de3bb6f23a2a8e99375c29fc223284ddebe2777ff04fa13727f192671ed100fc4bf896818d17d5557b2ec543a66f36c13eecbe449667b5394dd737dfa1ec9a827102f1e66a70e745fc46f5e98ddd780ac8eae6bd4c6dbe671125d25dfc82f22e9b82a42c6368cb9214fd80deeabdb00995bda485c84ad4239bdcdea05438f69c0eecd63ec9b08f27bd2ba46885707a542717f89938cf8a97a230f9240fd5ce062ca39d194c23c92a39431a02824e380930cbbbe28ae66fa56a09cbadf34113b1d9ab9ee8df39d077005cca148115600dbec50322ac782a1d25b4db60aea4f967d2a914ccf04634d868a5fb66a119c2b604d432ffb93715bdd12d90009fa72c19ac14fda820dab67d7e7f2ca48892b7b620214b9cffe17cf72ab14e821717f2518566a78e5be504abbc96df3751d4a6637838d5e83640a9b42d0227810f194603eefe94c68c64ba1f3e8950b9cb1fe492802b004a9d7b23f7ccfd9c9317e7d5795b0bc636dc43f4a8cb22dcdbd5eff06a2e005dbb9aaa31b9cda0f38cb48f7fbc856e3881dbc0601f25945cd6e8966b447da38a2b5ac12d65a496be82b3035ea5cb3e14ca0c6b20758d9e45b80f010af39b3d1a72a9a15f37f269906e4ab8358d7b6e2a77de84a83c0410aea0be43ecdb7ee147d67752e44227fc47f15b1cb592145189b63154da9cb38c13e92c13a3d3900964b14c372701fb325d5bb7fcbc30048ba30883cf7daa2ce068a232fffc7ef8ff3fa7390305aef4098771852624ac58380c01de418be0b06788d2fd2f127508340be98310abd36079e78fcbc904c9dd8114a3e04b442a619bba69f380f8a43ad70c8b773c9216abf953db113845eb487f57f893010bb8319d9b140ec1d988f34ebfebe49568a1f9d5e3e79c36264961c2a6433c0c9c60683e6c69afe3163a2d0b407ddd67a1c02ee71cad4378a43643f3da755e748b8bc3e76b619b67e74fbfdc901d81c30ba690fcf3e2fec5c27d6510a6d04d39df940f67b0cc74d4bab3c4410451bff8465f72512fdb0680410027b6a1b6c43dacafaf943113bfaa35d646eed352af3e3bff366204fa75872b0c854cc6a15603f0ee45a87bafcd3b8636eab027239b8dd0fcc3c0ce52d802d8811beee248925076d7168b62f92c3e6f60a25f29095f197ce671c23b4f077faf9fa6efcee09badb1892b903d3f9ec690df0d02fda7fda6180213c010cc1a29d18d715f05067e38d62fa9c382be87e6c0befc8c3844e601d951c632d35316f90fea70023b6841dd4f8f122737fd1ab44f683f87726e83d87c55bc50109fa79e685191a28c8972e5c5cc834eb77401af5c8e7425df69f0959b3369e7165f5df43744188d860e754c5470316968a3be2d70bb0c3adf0699d5600c597e0b089f04bd47a65b865c99e579e7980055f1ab8cc52ea4d669ffd5b893f5e318ffe5e837ca10d32fb3dc184b70065417ca26a3e8ce48ef923ad8f413f9dc8280f2c0b4fce671b3668e103683e941084e98368adbe5612016a3f9d8ccb30272e33427e4ac270f97eae8799f9106f18baed61648ede1e4e26b494bf49ff5bfeadb27efc95b68b8ff6f0c5de2fc1a263d157d19d1c2e47ee5236e5d81bd109f644f36b33ba0ede637188609c7668954670efd8d8f827a685455c6af849b41f3edca5061b52bce71172b2ebf11a99a538dc25532855bd93576681fc35e858d4205cf629943f594b2fa9b45f4ba4cc6dda95abbc6734801160ea595f12daa935bf72c0a07fd82a0d68361b52d278b5f0fc2c1614dee04c9235762e868fe0e5e772530c21271111cf5eb97b7a96df870d53e230459cdf14c73f61941e3586e68fac247f313d7e6299446220e385aba171126416a8944328f855a40937828e15a00523cdfa8b9f6b29b9a19a755fc2e96be43b50a0d7c7d2819d08cc426dfa3b58af609443e9974655f0aad83af66b8d799010ff13e510e6119c303e86e52ad7b6ecd84fd004d7d99b37f68cba415f2f463baad2b8884d4b44084b7dbca28f85924ee537dd29572f726a7e36b98fa7c0b3a2795b59627329befbe233e79dd7f27b95a2523a2794738ba972e239104602d1aa8fd17f2eee88de38d39bd914ae902d39da32808eb0e0af64fe6990302475871a7f8b0c7515d5e29d27c54a304e0108da3bd40cf7cb93b5f4c10a36599d207ae86a52bcf3554151402ab375b8ef3a49f0bfabc8413b61aec69466415aff0770d2c283f634e1f50aeb2c6ed5890a27d85970520db532a1fe5099c5ece44201aadc5882311e9dff452f8258d0100b191c1c0e8d968c9ceef0fa2c7aed6b2475fd71b87c97614b12f621d02f977c9b2a2c12d8ffa2e73277806b483800c07a82b6e07e8b364447a2711d10bdc70bdff3fd1fd22545f2e19eb5a74bfb2536fde3054a0f0d7748adf98e45d486e7aac68563460e872c642034781ff332974fa92a177fda112dd238a8cadac485aac2d6fd011b98ffccb3c7ff26145fc721e898b8c981cc8e7a59b1b6b7fe5d652d6f6bf93620c788c123f86338e56a2998f552168eb5b7c1e60a808344e37df40400bddf25d90ef004c25057a2c4279c6b7d1f14e4d54744cdd4c1b6c326a7beed51e22c57917ff77a69490934654cdc6c94c98ede4d27d204887fe5a281fd5ecfbff7c052dd739fd05cb035a1261e2cd3915430eb89e2ee83d7ed8a66b2b2321bee1528e006583ff2439c3a2ea306609b30fa3b4b40336457783b9412cc0dff4dce4e083908dae47dc13cd38e0ba8ae15b14b1c3c0861bc9c41cc038f482ae761ffb95bcb6acb04be2426f8f3a1819df20744e3c70a2cc2efc34e472dec34e55ecc7aa6e6e2fef84e67b7c8846968109cada848f40bce6c23874a22ee440b7886ada1687cd0280aeb273998a51bf0204f4b838cf8497610ba4fc86e2a4f6c506eff5a688dbf8f65026d54cc06d23037d3cd4d1fc8f660561c6d09057bf5949538e66b2ff7e4d556040028bf1d115516a9cd1fa1129293dc125fe5fd7b6dfe46455dfdb2176e92194aa8a6eacb23eb5af5b5b29c1f64f84c8f3ccb9200d3fb4968a28d6a1a308b6f3a26979ada915d7d82f5a775fb4dff3f91b685260844194628097a4e9700b8cab8198bed7133504314486ad24f4152e20aab9fa7b60c85d2b55320476a830787c8d6c5f69e97bf91f8c1fccbfeef13f5653044eb7d9f441467cdc947835864c0f75901ad413f93ea0d38c0b572b59a50d7f043459d17c743ede1b1c3fa5a20f82b7b8594573013b846daac80f1969bb77ff346bc41d0d159e28bfafffeddf31e4fe9d3ba0fb94cb90d70152b1c062f93213e9b21df99d851c63688ea047ef55cbb6f31d976b1f85ca9cef8c04e786542f9d38b3bfcaf57aac5a61fb1f7c433e3d82476fefb006e7ef55c13e2594010ac94d0732456b8993bc6a8cb10377cad2f732efbc569a18acc854d988b3f9c20f2c196e0c3bcf109a84b374b474e3084dbb33de35d7600485ca555accf6ffdafa6a9a42ffd75269665c121d9a15ac19275623a23670eb9fa4d6a1e3fdc2f7d9404980f130f411873cf210377182d476af3d9032d62ebd54de15055553d81fea6284491857ebab989524ebfbb4c2baab063bafaf6b58b1b15e6477b577b6a9f54c582ac0784559ace65cd0e603b007bf2b02dc8f60b971030d0fcba30fe588487709926a935a42b8b5882fd77117abdb7a093b31b09b0f8ceaa6836350cb4654de1aac0d4b2619b8ae3a8078b466809ded83f82f008f7da96272d792da2b2af9d10c4a0c6f7df3b5dd3ebb66b13517f8bf2a1f702091e1288a2b8152b205b1cc453002501f76e9a8a92125e85bfa8da2112de1f95725f172a81fa4660a86ff6e3dbd08866b3288f2913056436ca4ebd4175250625f064b0050c9f2047f8eb1783e2b71b75d1f683aa27880beafd997a5d6726c4c24df87958248ad81359bd95e8d7272bd0ef165f2c34ba66f1c485bdadd7db7ee16240d75a09558573aca94ed7a353c11b0df384bcf87ad2d85e0acc2addffce4d8c2e9c6435b66af1b084b522b4aab8fcc073be0e7716f6e8577dc16193469b78fd6cdb12db431e754721c32f3034b471a86b30c80a398f3fd73ceb57a86924f8c3c16283f4a2f38ba331d623112481c80ae84af9bb66c7badb18dfc48b7935e8bb3cfcd6b027da0ddaa66b72a2a87f3bb77ff2c7d9e9ecbd5f203aa96e99d23decd0232e8246e796423071b748e3f6fa0c9a336f0fc77b44254f82fe2e4de2980024b1e8bfacbf496fdbbb4dc9d193b968068c45ff99a83390fc35a0fd54d19681ec2ad97a3e52f8ae5b048e77ffdba55c00e8005fbc6ae09b92888ab7171abf82927b6869c89ee6c11c2d38b535ed8dfe5b5ca7336a1eeb4cb1ed06b851054a3c883268c8df078b7b792c0c6b112dfe7b8f56f23664cb414426fe918a787b07698bed5f3d9e6a00c09e5274aa32c991ce3788e980bd44d6bc333c2219193a20b4066b27ce9fb18b232473ee0dbd5877441dba202861424e984881f37ff95eef40a48d5144aa6dbd1766b151a30ca3c1032c430a37e0b7ee7fdf5fd2faca825e4b77eec394c2eb90a141a04093860486278c000aa83b2cdf6ad4fc12f9ff0737bc9edfa01942040bf2863f52b766b1ad1ebc9ba24b15e2c5f37441b9d163c3e057eaa672e60dd10226ce40007f9e4a46b4de5337f79e0737a66f8413726374cbc7358baaec50af1ed491d07a71f4f670cff765f2076fb7b2a3f5a2fdd5b75546efac44f83ba4f3a68458d1aa3457cc492ffd5e94310dfc4555fe6ae41bcd2a6d5ec86a4633e34c9451c77343d8f5fc0a73200826dcd66c2a071f94bb3ded4ba443e386212ee7b98fa3fdd0d3b7bb6822ca413973c5f6728f9e42169bc7a722851d3b618cacb8649a009c1d95d771b913c065c858ee11709a060393ae0d9c1ad14d31665e5b4bc9f07f674b74501a8fddee23fc0d5387acf83586b94bfefb92b91b2816acc04b919a1ff71e68550228dd80f89581f10df7761385b7c482b5b00962244aa64c2cbf6c585a2c73e0be1f77f81a3e67d9ef01f2260987f557b47a78cb624cf7c14e20744b0b4627d901d03bcdea10e2a4929d20508885a2cf2d829b861b9037842a420164218fb9534fde38977c6ae72eb6bbf25dbc8217f91221b6245f320ad06928e16ff67c455d03409ad72a798e93b020dc9e6dea4b2841fc00c35bd4163766b247abef232a72346d3cfd15458adda0f26d7e612d754d04e46728b397f261278ec9cf09d9c45fc560ad4f605421266d3a7cb76c77eb730a97c424c2741ba8f8360f75ca189c80cab5c6f454cd1da6578495a3ba840856794d43fe74b20a3d961b03b94e6ff2264cea6d9e68ec6c62c59c4dc2e261225d37e65d2f5509069a56239c96dc7f976d47c8b09794467fd6f2a2adbee2625e8991961d5f4ce4c22f9a6c766c26991ba367fc35ec0c87cf23c33eb14f0d7a47230e5fc110659582958e44f5afca345ad7defbc696ae35ff80e306fdf0f3fad5defb1255deec48ef0142e1f82b7c131fc06df8f42e66aa42e06a2ad0280eea9b8f83d901be5b738a709d85603b2d68f15a1b5bed7dcd956cd2d4cedae8bead7f8462d74c8a418f9baa409461b34a34850c76991dbd5ca0f632dd1630a5e1e823f5c2587f1f26fbe5c59be460ea5c93ef2e808485471d34b7bef9f7ad62d849fa4c5855d07a3108f6c00569fe65b602aeb44f1cb8f10bd095d032e9a9b770a695fb0548acd6fba2c8f7a7e5dca2037d817a01b496e169889ad220d92a86795e8b95c1fd3334d90a9cb523ccd87b10df937dfcde273268efbf9e9e392e550d306a1f9aba99377fe675aed024c5fbbdd02a3387d63a00b683253e9d72c1e1285ee2ac605e0455fc0de644d9c1bcde8b592b81f58d6f21ed92c226fca75eee5462ce1035a03f86da0b81772ade2baa4960dcc1b0da777ecc0dd9aaef70a075db7cefac0b11e8a54cfb7cd73082c1c66757ac060397ebe890050ae91f83f051b7f964e935b01ba9ae542fe57ef4700ae22dc3ce7c020141c4cb11ef1cb3347f5b824f0a21936fafdf0e7be9843182f469a3934260f8ddb901abf41c08a3b2f20abd84e14d7d0814e29abda90f10d762f062908c939c575fb486b8b9e32236c7fcbb09d448ca5f85c693bcd9d8197a7f1ab02c64e18af201c4e6d9d23e5c1614f0e7bc9a872506075e13d0d2265855652ced281449c8ac16baad171e5038457bbd2f2c0cc3d70227b106753076b55390b048c9a01a2257784606e0408380d2fac64ede587411dcbd99084d300431d7a2fc57e4b8c564fa79b47a3e83e4289a363f503b3d1e79d324d0267987c86f11345bf42d7c49a75d0a9a09ed14e8f7a6b4aa31691403694eb758b5ebfe7a3c439d8cac60407f51ac19634c431db642ba2c56377da26b351fcccc7f40cc5973bd18bfe29be6acee860d4af8c35f4514b10298d6466fd5707c2c40d4b15db8242719806f713eb590e9e6b1641340bdba124bcc4254bffc8b3b4f7484085c7880df4fd9b7128e580cce84dc3d4f4a2ac58701b4a73470ca3c164b2c4e761814501eff08f33c6bbb1357f2a01504a35420f562168108e2ef08e4665916d253c283e1c32b9e25d870647d08c5e53dcc406ff72d665a4a7c1c358621b6ef0577bfeb2c29db7d499e2a9961427d2b6fc6199d7808cd720bbb4bbedc5f85ef1fc25566528fa2822bb436030e6954a12fe849f16fc076d93a4e516e0f7f14b95f92da33a1932efc6c577367bb75eb8d4182ab787cdad747a441b41bc7873aa0004818dc2a15c6e9ec3d7bafb82caac26313d3317a333321ae8bd4cccee406120c6024e70b75def8414b819269b48952b96793a3d994d24496e6517a404f5aca334db7d87743a120c78d62a614f6968f48faeadd74eac4f93ed2cc5b9bf73e34252958c3eba1b0d3064e4d2b8072bcb44956d136c463de772f0e96789e935b893201e178f5517d0b3be0b120616e385188f010abf5381925277018dc8305131ac1538e5dd4afe7db514851855ffef81bdafed22ad383815f9b588a71f8ae90a2968d8e02d32564855237b01eefcac987415eda69a0cd3a6c2cdb49b095dc731df60f24f7199f0ffe1163eeba848e20c4b41e5648416f80f6b561e77ff0a28b854468bd61abb4da010950ae79deec1ffc409bf7e66eb9023c966b91c0808e1adc5316568edaa23bc5d4b961a17cf3596cfcb5a8c266ce6d9228558aa3a5a24bb282f462fecb7d476f9b03b88116a898769539125e586af098db55af5e7bb299df7ef9dd1af8bf61cd755e6de2eff3c9f8b374fb60769fd5239c9f1047a42d9be2dbb40b809400e29b32ea91705256ba3e405dc1914b0c359bc3d7f0ab92f6adb31f37911f57440e7ae0fc685db25ec105c04a3b12388919a2bbc28b2e33afde6bd1988d34c2286f6d2c1c5b95df08916e21dcb990eb2760e7b555146adf04745412be6b1a731592955f59a90bf6cd667bd03552baba2df7b7d83cca389dfb45ba26dac83abf413c80601af700e8ce73924481cc4db7e23b2ae42126702774d5f76e66acde9535d668cf22da0346456d47cdfe262e8870ef96d7e6f27aca25883f50cf34c0494c2e66753bb08a074f939a47cfce0d70cc454ecbcede7c0d08f4804a85a475e4304350653fef280347c208f95bc545ffe217bf97e09ee79e223dae9b33295eee50d8eecc966844198a329778fe398939e32bb77de845680d62283484b66a005a493563f81f0d2937b66ad05a23e58530aee0fdc413d89092452f6f527cce3378cf695169d800b9b06e28fb91600a394159b3687b422e756655115e8615230d1203f7529c7d99dc066239394c458f7fa9bf9c5df2727004499a7df650f3e76ba4be8587687e5f35325447afc4ef09220ae993b7cae5058572e50314d5589d8ebdda299983088ae90d00b17721ac01b83cc54d30766bf8ad207eebb32b437a6e36258af19b3911fb677beb5fd60837e33448460644006d8528e2bec49eafde52a5bb6ddd6794681964515bb688c0a6294e6806819445c41d38f5a2e5612f8f88bcc2772f84b203fc7d6a391381d4537e1beaad591659a9db98c77b6c2e8ef0e2a71fc4ce5bcb964fab5d265846e66e68cce75b77785b5541a2c24fc7d1e44c758b98b226c69d3d836b3a3b75cede3f4530f84b3d69790a0330add9e46ad3f9b5758dec540b5a4b26926aca65683eeaee2a74f5645ab3d59227a500452f291b2c80fb4619014297bfe10075da6e2ad35d2da42eb0012af978c1724640346a911f82760c817043daffa1e05c3f9af851c720e84ee4be4666de8af73ed491aeb6aa9564108496a5d633f3c175bcef7e62d0d4d0c8ae2a27a1b4cb87129b7629b93fa91433a69cded130c068fbb6a8cc3d56c223947756fb5a554867de53a126329500cc93db41688319983604841c04b3c5f46fff5e0d2cb9090d83f622e7574cdcb4ba0142809f276ad5bec6bcdc6bbf1ff814a0c8342956f401d5177dec19afc4bba5dd46ec209e803aad65699404ea170fb31a5c08b4b7f88a60d729cd5b55d3ca6d8d59ceca2e3dafd14e4c43005e1aa13d971d6916394dc3a1de24b548b4781ce84f2708b6953737414c11729e33cf634c70137924d87074d462a0c054288be7fd35e5d5af7cd176bae5588b696ba6e3c576a98b81168749262075fb2f5565cc6f49c67f935fb83559a27f517a275881f22fc4901e515482ac9938c511f9565c61f7443e01fd39bbe136fcf4dc9171c3efd506e7844eed2ca2a35b32064206f2b5c9e943d803c1a3271a70d749207acf12f130f202d26c921e1a18a58bfe15a27fcdcc4ea1de2198001c2510013482eab00ad31f150006971c6e1d3fe9b63bfcb9f9f2c62a85786d51597ab4013b78b6bde3caf80063497814745cb1d6f0230a8722c1d0097c600ae40002a8099c5389202c135800af67d6a404614b8008b8f64d66200a76b71e9a2d3bd5c791911a893e5f7c3b7c1d262d0c4203517264bc5ffb36aae06052ed9d66a7bb262506ced536dafa36b38bd8cb285542b6d106c8f1de0d4d43010a51208023637d7bef772c6c8f12c89809c9bfa700591656ca5061612165b57c6a46ab7c7d2c9ead87fa68a38ab5cc037a4d841793ae552db79124c637482431f692214859dc325fe3fb190431b5c36ffec71b7ad7e03a61762df080cb0ebe76186cdbc1f008af3fdc2ef85c4e2293ba7de40540a8e9430148c36ec0fae02f7d3d3cc9f3bf7891f9a8b7ded859a0d3a95974097173dea7ee2b28273388c4d5b99c9682a5d009a17f3ae7b0bc955e153a5084c828b105e921085e4ff639f7a3a4e8ae69b0b6eb6e302e84c7efdc1213bb964f58be40252153e982e6fe66f7230c9d2b22c3e280b1a5b9e89729fbc61a3bc3314c26b9aeba7d2868b3a82a80ff7e58e902e9ff569be46eca8f2dfe92c314ede771f36c7415b736ce9efac9a5af329b01055dfe6dbe4189c36c51a781e3bae018d7340ce33e3c0b8d860fe8433cfa3e1e619619f7bdd2027c2237f5f050c0b19a638d74fc12c912b6fd595e0e16a6137f4d0873c2ffe2dfa4505838144401b3e51b4535c50f53dc98b6953f79fbac8a7c641ed2ae99554128bef3c6c9aba4233bc76bfa8d50278a59e758f4d343acdc70ffcbaa1d52ec09178254241506a5174f01347cfe9f86581b13207284cb538da67f478726c3d80ad22e52688144e03754c56401dda2226f106150774b29e06d04a429b1a812d604331005ba7a6d03d88b177dd39efbc8ea69b9a6e08288b73dedd2bc60a1b0d638707264393c22454869dedbebc019b01bad1336a4bb894288abe5e25858697c5514c142725945bb4792d7d01797ab1b705a54ee75ba556576b59f64a2197e4db020a44adb2edfce0df4d06cc38a0ea3fa9a17135bdf3e65e6dc817350aba09c47b54fe4cbb40f231e14a07f6febe788e547dd514974edd6fc6b0f39f826ed8e5205d87eefd149ce8af86c5826e525f9f0c76dc8da796a539709aa0c3b41ae412b27f693d26f8eb13e67ee24c530f169b88be1a082a0062cb1259d96a54c9f3384f6bb131be20bb8cd1704905d3be4c02ce083ce2b6179b71f9ccf17ca18274f6d7cdca0f6b37e69ce3468ce614983e00ac8c337c4909a4880602cc23d8a915ef9354e90e303f7da83ee56c54ac748263b7ed0b32baaccb125791da97356a844e9d8370c173dd9038a3aa263d440739d0a536974ea4fabfa3563c0b8e31da6faf70044870c3765ec96604d02245e315804e4303476f3dd0a2fd1abd17fb51ca1176fd585b12048f3a91ed5780ec0c72e76b0ed1dab1a6bf73d59dc137076e26a6d3db7d68ec71f5f33af254e26b11cb45df54333f786dbc70e0211cc58a07c1cef6c175f7e1a11e54deee3f122a2f5ab245ddfd5a4172f971527fe9320644e8de92d570809487601b79cdcc8e50dafab653c0fedb3fdec040adc8753e8bb91a049c6758f1c9d35160ec2ab914bb3543f9a0a1e9945a1ca794bbf7a35df7f84b45cf577b51d1053172bbb65a15a904dd46daee579a5cbf286890b862382e4178b728b032c8edab668f05498a50f81001af11610430529a07b89c432668263df83480246cf7671b14acbabbf4bb7d99141a32558943c4426f56024a5ba928aac97453d166be8a08248a8092629bdfd8d922cd476c0eb540ddcdc0aa474e7355f5b9989a69f1f9dc3924547a1a3dda8e3f09228f72416013ccc8a686fdd01e0fe0fe8fbd2b64a7915ed2b5b3530926c2a50d4882010e5d0d77860fc718f352817f0eaa2ed6c066dde74ffac385d608c019d83ad40183ff64e46974b3e6df73826dd8f64e3423869e473a2eecf96701f468a7bc285fc730bf3605cc64108e444c832f1045d508f6ba4237ebd441a4edc853fb34dd8cefb75b57e74421ecda5fc53818273385f0a84f4e9c51c3f416e5ffbdade69e936e9c9d5ac6265cba9350bd22bf6d718db5565d3f4b2609b3cebf2efa00019c3884a8151a9e7002417fd738e84b49d62ef0c165b5f66f0d88d6563b0fdee71e8578c851dcd948893b210a113a193197bf2f15a61472d8a4f7acb178215327d7c2d0f54228a3df498c56954e8b2dcc74d03579fe2e21718e376717b241e70cbbb2e9431649da405840ce45dff66b51f6fdb5ac87838cd837ad17e42d67d0573ee1ffb3c6746350bf0c5ae93b73f1e09b495f6f7f489c40830fd145b513122f240d3575adc9b1b702cdaa97b87da0c00a2dc9bc199adfc5d8a5a78b15a59f73c7e47b84ae9160c64f4269161630da1f9a7079ab2e2f6d17f83dddad7227094d606b8cd8d841c43a0725da2b02d511f79d518b9462bb352232ef768e38fed4eb4cba8def9009709b1ba07a1563dfc13e785952f57b5689f3138a043acabd250d724d197a06483e1a9d36f60138ecf8f052b39adf447eb8407f98b3e740118cb5cf6d9af75634ae3766f25aa1540fbbcba38c1cf62cbbc72ef4c28620a96d8d24f0f8ba9d420e215abcdbb1ac3c5657b652309690204646b1f93a5e0fd959ebaecdc01658ccca5c783c07858b3bac66ee2040c95089912041b916fc5460ac21f239ff49dd4a0f8b638ef345ca6cf95067775fa5f472f91c4083ecaea47256eb1f45090fb3989bc33a5073d9553f483e590bd8292adb54849df1944c4e30fd27bd6e62278f15d07e893cb79887f0788fe01e410eb827211e01b11aab50a2cf9ae3a39aeaa0fb924ae4cb50df8f1640bdfc48fedeb09268af0446e287213158dd8b922947fc0d22b6e2cfec0d94d805918b44c4112dc82c23c705c3c8d11f8a7b6d0c581b8bd5daf48b1195b3e248b31232a82f13061ed8e55dae04efa6f222b25d7e64f4377d084f7928c808f4457740db4d75cffe2b4435abf276f2f96485ef4795b43cb992bf6383b69be9b47697f1f2aac481f1864f28cbcf6335134cd754821db3f628e91cae1e2afe08f94addea13f24294fe6144d4e8663b1db8a3e44380725292c237c43deba425cdd285ff5fd7d37ded102c2fe3cbf91542881979efedd4aec0ac1cc13ea7f64e9f566a96c56ef5d9e7960f76ad256fd55ba441d8419a64ba58d0af0b24d8774264f8829b88fee99d6aa9917fd61a33ea9d81a2468b632db8904bf216792962d293da22fe89bbcd40b51020676e6d038e6dc5f0ae0e2ff205b0f8143584f2616b6ddb3221c18d62a69ac4e7d1f9ee8919206c6d508f82ee4012b3cf493a64ab6c198ab196a7d63c8a6b1638177e9862e7d9cd1f8d4726dc27ad537bf855ef46fa664a22ef842363c9854224fa0dcf7c0baad7786be61afed3f4a2b0ad7952325078134d9add6adcbc945645bec939235c9ac6ddb1407b94b97d4b20d24efedbb81137564593415d7bef744470b859c6c030203a49a482791e08c3675f4694e97fd6b06514435d6a9c3c428855ab697ae7d6eae790415eea4cb9757ed2dee26d5a148cc28e7d987146099d92d2fa5e4fe84d14bf3fcd6bb60d9f285bfcea21d07f9b988cd2d4d30460a4cc35e787f73d9c7938f9113bac17a8dadde876d7868d0a3a8342d0be896e73fabc904910cb9d439b4c1657babd6b164c4bef20ad86e0f7b6786b017e03a64e7df1d64b029dbc10d2a26707ca6f78570224c9de239a8c2bc8aef2733306bf4eaee3dd42a64adb6a89cb4e8cd902777992e41fd46ec5db637d6ab82e1e26503d3fe815bc67955310ab2b1056737755d719b63a2b5800a16bf636f372aac2079730cc4e0b77870fb54f09ca1174db7655494d5ba9bf34de2afd43aed2a9b57499e390a838f4b0db112085088d69d1d0f14c34140d531f7b66b77617c4320f906b24164e2adb486fdc2bc409ad8eefcd3192a4edb8fcbe673f6149398ef0c603e2b4935f25f63f74d2ef01843feda8cdafd68292e1e4342f437166ae6155f3d080a1bb76d51682567e1723071712d8920c4d0634df6ccc483e30f8330eff4a4862adb560c115b2dd3909f58be29d443a52fbde19d9c2030e5e15ad218f91a414eb211dbf988343dc41b8086acd212fa39b526a7bcf7bcf79896fc54f5caf63803f2468437c00e4eef323b7214486f3199148359a22f1584354f6f1a0fc387b58edc41c6b52365ed3423714e3ddc74094a886a6ae8fbebe59c029ab1f73bddcec05515d532c06b0db4effa6febafb94ff2d5408a1b09283f5d2aefa8756e6a01b6203c349843b9c9061f096df2e282886c87bbea2c7703741c7bfcec4c8c978c87ecfc188a9b436adffa36d64602439a0bf5eb207be0bafccc811ec758e9969971dd70608034e8c66080a1995a1eefc2fb4818e899e6604bc85e5e0c98c7be7cb77a80f5d0cf21cb69b2133afa1172d19a68ab44e6f637301628d18d7404d814d071165530098d9dff32237e1a20eda0ce224c51d46e381a046c2311547ce7e937cc94087332b11658aa69975175da1241340375d86cf3ec82345edbd473cb5e6658d4b28ae7b5630f3895fa51581ed942bfe00235cd5700016c570220b590c5d48a3863f228d731b43d5de7922214c4babe7eb7ad7c91a9775643dfaf73e4c3694c17379f90ad7e92a7d5b9a50187f3bc58843e80d03ccf5e3b3a2eca1de994be7bc7286ae774d66af4c19bf7167b1d11a11da2ba459d7626c8d97704424958ac9e0a4a5f71f57f8f90130f26d03e67e00ae71fb2e16413f97908382c0f31288020f35a9f8f3ce8c05f40d966f1887ac7e397ac28fbc9aedeb332f125902e3c4ceb4c41b26bcd0382fd59ddb8307dad963d183a9f74c2ada5e497c8f40727fcb57a0675aeffd9df668002a445b3d4f17de7dab7bfba1f265e7bf4916b29c103712fb712b80bdbf7faee58bf85ec88a2ed2ad0f532fdebe14eaf1aac74c9105ce3d5f09bf97d4930083d04a694aded20e32cf2b8f1c9ea24c85ba68a2fc15c4e71eac623ed47eb1ba7cdffbc41e825f304de7e38756d09359517ee87c6e40bf80129a631403423e606819f2d5688101b5d5b88a213008837bb708f045d7a671e9f015eb095bf4b5f8117e80638c93692eef60c41c78171e2f9bc175b6a0aaedb9edd3b71a3263fc0f335b0afba3a1ea92f4f849133a5d71c8e253aff5904267932d282b13fe22bdbf4b9feb2ed95503ba798c9de8fdded0171a144cf36b1c642acbd28e4830e0905612f891cf3c5d0411e9e893fb0beca4c74594426d45bb362a71ff02b4ced2d8bd65b82f477f7ac2e406f5095d4f8eddc3883b878a5c560830e90962ee5e33cbe5dccc8168d38751712d813d5c7f65ea2738e79823a04ae13336c61367cd4b4e48ed6bdbfcc9550f558e682424dca73545e599dc0b9e04fcbf1dd14d83bd05b20be1fc891af39962ad6ac4b878c686846e731c13afcf0f9d515392e487bf1a5fd4a302985af1a7485ca5551f16fc4c8b7b9b66466647f2550cdb09277b4b1bf7e6741d428c4be49efd336a932222f015226be4b2fcd33db1cdfbc05d5270728d7e518a0566acbd6d94768cac4d0c69efe7ae3f321b56de93b248c76a0a9a2a9a5e8c77101d4824e75edbcef64e33e40413048e0985ff37034df74b468720a3eb46a02018d357add08230ecca201d3cb5de2321a5b9dc19353105943dec436b8fe450bffe9a6ac3767b0dbe816699af0603d628c75f4155d18f59a93957c43b5c4c1c0806b78aadf0b606fcf2fd5a4d0c3793d2f66e0172352bb54cc04bceee7149a23180f9255bcc4ad9c46006b795e3b02fb34414a8ce26c99fa0b768e4b98e8a70188c641f6abfa5b9fd1e601cd9c4c4aabdd622eb6f3391e11e5325ec85dd53500590691922729a0f9a936202fc643276d0591c0f11f0ec6c99e3e6984a54f27c895f88cc1554299d9fefa94fd96f3c62b19e648596c948d43d0e066da49e5f0e98d847a00411e593779c40d106d4282f42fca479465bf22c14015f80bfd4441f4421d9de392e34b259d2f92ca6c3e4767e120abad091da002b69aeb30245464e1fb4441a74bf5adc3e9b0552fc279574250c040882897e9fbe5d731dc94bcadd4fc4c7a2db17cd108d027964a0318096a5d517aab840416bb1fc8d98d247bc955aef0577e95d3e93b044e831667924bc8d94b5aa05fdfaace5619c0f0279efd5311dfdf51183c2697a61d0bbbcadd96396e5dbc99cf6a97309aafb1ffb10c85b828449967b0793509a5b0f8db01037c38c0e7ff8dabca10161133fb6af20f2327ad55cc0a967d11c20481dfa4aaee7e895f6f1ef30c2bf1201e665fbf63987c550a82753aac5c8cf2c93521482eb8356369ef2905d5178e69f005ab40633f5203b4844ec7873aadcd4c9868d157b52eccc18c918c379a232a37351b9f2ad9ed278d7345e03d95c5961271487b65b28fde7c655c415251c8184f792d34289accc5268498e39a44adb99c480dcd8792a50f49e1dd13b44a61537cc1b329df2f7ab327a07e37d4a04319b1852a32cedddda0c063f0f7c19076ba3a0ef5f6bbf5cc6fca05344fb6507aad61c3880b89299882e314014d6b8f6a3262b050099bb1df1255f7f64a97f9048d89fc868234b7955e5a720ceba62aec85b6f6ec0e172c878c0091d29e0ebb6c5f242c0a6c032ce13c7f2ecdf3063d4930b7c3ddb994505ba1e94cbdba7536aeabed60a89824ae022c49f2f1ccc30eff8155b14468f1ad64a9a564ff20fd7332c4fe771d66576c834aaf5dc8a56541212044605602fbe8c77aee3169f4f3fe53bdd0d0da923fe25990e150665959bc3b7636b104c34ed6a860de6f1652eaffde480831f6fe2ea2f04765b1d0cf0fa9f63b9dcf6b4d570ecb59f760e0b356c8fbbeb916fa755454a91decbd5d1e051fa591cdda789ae74a681688385d184b884b937cdf9d09212b9d07342ee8ad3a36df1a2634c24143c2207a8ecb4b66a808e893b70362bf699cbfa74021563ddb2ae519b2e16e1fdcabdbc14e59565f2a1c3563f0434cc949279e3227beb47aeb167fc11e2ed572a273310bde3c3db9b20e6ff84785f9cbbd54cb27a90dcf0f64b1236d5da423751cf6e1ccd95f8964b55f09074431cd424a3be4599f59a22fa5dae0058cf1db0cf9b8921c8136a1745280443257291f10797d44d765f650248bcb7f64bdb02a7ba52edf3c2ecef48fb1d79518bd4d5f32fb8362eea96346fde902e6812f000'
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_test_1768408494')
  AND section_order = 29;


UPDATE sections
SET section_image_data = E'\\x524946469a2e0000574542505650384c8e2e00002f63c38710ff0539922449911756a3ff1b35af1a63ae845d2520b98de448620ee63640cdff9fb9a65cbb70dc48922245eff1ccf3fcf77299ca20db48f5a7fb27f9193cd9a4cd9ea4bd03923c420883b01884f2e4020921c575dd5278e24a08494410798a90441e52c14d91ab5cf7ed0a44ea12b806dbb510525c7710c1f41521210437bce68e204a398f831028b6f31210db5809c1858060307d41b86e44e1bd0fc4b90e02a10828db7d2382ed7f410894f3052598be08ea3c1102a540bccf0b718e0d217c10ac7d11a5ef8b5020523cd6c1de0905c5e36724141e3fa34078fe8e84c7cfe8fef9ebd629ba758a6e0d45d1ade9d62828dd1aca3f57e8d6501481b07c1b4ab0b486a22258beddff976e1d45c5f6ee6630936006db3c1c7909d64950f7eaddf1fe9ac10c6610ac936006339849b00e821958346effe7486e1bdd5ecef9c04bc4e503886d0570a585204a388382e29db80ab601514e586a6073a853b85b10124d2bdf39dba41c95b3e474393aff6f5ddfdfaf6a6640eca0dbf66ccf0c67bb6bd05ddb535ddb3bddcd4244ff65d1b61526ce79c6a9369afba80f02410d74befe14637ff92ffcb93ffba737e229a3fca53f0f7f176bb13c32c6c45dccff8c89bff88b71d762f0cff117cbcec4601c99188cb989c3c8e23096260ea38ec5c8623166b1182e16c34cfc67e23f13ff99f8cfc47f26fe33f19f89ff4cfc67e23f13ff99f8cfc47ffe442b2ebd25b4d372ce86622ec647541f13f61aca993c2f05dbceb9bdf88837032bba080d3114cf00ae8cb5d876c8f7c65af4426e89381e883ccf59ca3c8f656ebfe2c7c8caf947ad0bcdda15c7cb7bcf3aa1618ef75cb5a8623ce1026be747a77bb4ce9e617360a16386c8d5dc06695b8e616bafcc0f86ecc29f89350c6f72d4ae8ac6cf8651568d21e48eb774351f8dee66d4ce7e60ce37a1ad141bd67e78b4807b17c62cde1f323717438a528dca11c312b6e154acc619b8fcef76a5b70a6d1067ef3aa8c8b3939b65f6a2b89d656fa7081db7b6f39515252c88b1e78d995b67f3710857cc6e4b480e3b80b34d75b7c13ce48631e67b9c732bb5556e869444600b8fdb05c1ebdc8c45b8e6f40b11b7b8dba009793d7d8594033c517ea90724425e9e423bc2f8c2721bacb2a0e2de6d8c92b349c554264cbe0c2dbd2be095ce391b2ac0723253e4f4d595782050164c957e8c21a72a0ac1076f63949d9505ef5d013d3842202c15a1ac44f9432e348a490aee61630f662a09d5f575bdb7ba3ec77d56a9988a87ed20be2c797929d3491cfef145f13890b395d07d51e260564929d1213e52cb25498a619042ca804b5aa2b35cf656229dc687fe5b12bb2f87467fb73325af8933cd4dfab0f1876dc71573f36769967895e352c38891f3ddd8e7472a0fa265ced6325548089228aef6e8611f09ef60126366e4525caf1a1c488e5947d384e12ae3ce7c4ce8862c63570e3660ae888c96be68f1afca718a7b8e3dd65212be5b2246c2012e0af2ae8e88aa6194fe28a29018731529c57c38a45cc140eebdc5a7d3b870506e7193181c9a033ec2b1435f620df272f2aff5b4783d8d3df4041fa1e12939a0a922e63acf05f9c205d0e0f4c0330925bf970428393453caebcba1c02602b2908879fb1870508e7d5590437340f1fa3c67d1e2d5f60cd0a5ae57d11cd98c2ff0b17b2364060ad2e972876de33c8b627697198ab9cf51a5b870f256c976f2345195dc5c1782f57add93c1d4da7719b804487bd90d4be0e2b84a5673cb64380d889e9dd986049a9b21912e52f28373d2ee2ed1c9a21c13fa6f51a6a0a27468848bf082eadd724e50c2bfe2426bb1816a6c41f7c052c7041decd12f1e14d27e005ef0868ab13953e6b50c671b129f8cbccc309a13e6614ace6aeaac848671bb7c3f4723788cf8467a3e90204785991912bbda981d9a65f16996c365beeff3349ff618c6a5b929c1f424fb365346c4b8d4bf0402a4624bb8b280385210b3da36140c8f1b86fce4f2df5216978339cb9348dca6bc92756ec1b601b882b4b15c3243e206973bb4d45bcbb8b3da1e0b0eca15a8833d34977f480209679ba08cbc726487eb413316510939097f7cee451247735ecc3c0c010608999addc571dd120d6a5bc32033125e64a3d84c293be03febd0470cdd77fa4003fdf987c51ad8a1747c99391d07fa483c7826cf73a90e11b1f96ab50af550557ab55cce381966b5cc962b6dcc38849d1b41461b1db8402711776f00ddc5699a15c86d706e5d322cb46c4ba8db6c10aa3495ac39f5d7cf0e8b5ce6e4d382f3665cb47106e848c09759155fa66c0bf6a46294c2f43ad13c08aace3e668c1a17a8db8c1a3587f28ff2edfd23806a391d8191d386f3a21c29ee35432637a6b4d8f979a4989cf7f37ad4c945ac5019a51bc080376e31414ae425396b4c3f496567af5314ab6609058278cd3b44dc9857cc91b5fb11e68d1cdaf7497028bcbba507ab48c55c9df3bb9b3913a4445e46e49d1eb82f72472252699596bacdac325883feb62fe0c0f528a878bdd7d7111765c1958125c8396bb8be1e6b9998aa71cdbfab689b7d4e738619d3c45922dfdfec541c8338cb428bd5827a2851738b46fc628ebaf219dfee99d12ed1c364ce7a9e424f49aa3d8ac2cce90e2373ecbb62ca2fcb88692ae688f411d3878b56e9168cbc5e29b8001218eeab38bba3f64465c1b85d923e0c8c432be025ea50ce947d2750bcd2e3dbc3a42c98c4a91a89f6480a7393ec303215b466b5bcda80823927c6f5b2d5b3182eb42f3227ea1eaf79670f3533b8d5ea56aee86c25817658d0592f7504cea18c752807253b17ceacafa233a3c0ec9074224eda33d11679c1ed054ea507c495c4ec1a1ee371c752415e2d6be59433c3a097515ac5bec85ee6b78abeb519010a0da5731365c10465a610c7f58346e5521916665f6f2597b7d2c04535d880bd270bb7dc32c0cd966854f05b72a9cd88281792ae2e5117c6b28d1c734b48f1e0b482182926c12055d6bcf351654ac6d9391bc5794d788c796fa8d4214e092765541833a5e217db2682a25c4abe412e0719cc51e7ddee66b72bedfcb6ca8498a566755f32e40222a4f218d34916da72206773749af5bab7a319350324c6ace9dd64a524cb1b52c02f88e8847158ee4eb20bdaf9145c9a58c37ae2fdad31979d112d9b558c055387b3790cc65eecb598eb3bdb2616b389ff4cfc67e23f13ff99f84f14ca777ea3ebe22ffeef1f66bf3bf19fc9a8a4ffed7f9dfc9774547cbbeb7e3d0ea1fbed0c2c494783cfb22406e17f668c9dc456f82ccb7eff7f7bff7f8a2ccbfeeb28f8addf73ff3ff6202db2ec77be0d0a0eb3ec0f92786a95459615a4fe97b459769278ef132c18bdff35514b3c592c4e4059ea7d6792d5c9af797fb441a525a0c61081ab94a8419920d77b1ff9536419137a27e10ff3db59e6a9a2d498fb5c0db1cbb22494961db55986c12e74fa2c5b18c30bccb36c853bbff7516d13f5f36b19895312ab59ba226d275d961d82e8ccb55996ad0468dd7d6c95817529ff8f13f85b18cd16fd3dc9321ff5d3892290b136cb8ebedde2532eb2cc8bc02d3a637e2b149420bf7dff24ed48f82759d6218c40215a28c7f2374b415c1af5e325a25c9679b8496ee35a5808ae8013d4077252a1199108c498ffb50c0ad36f8b623876e0c840e9088f83e83d11b6c8b28694b524824fb0a28748042ecc4ac85a6585cb166287f5c4c401777f9b2113059f1137f1769771f6db86ee9ae2e371ef13910a4cc57a49b6b89f4d85fe5f8ff0e18e13746ca530c396496f8a6c6a04ed6f13bb4fa1cf09118c48059ac32cfb7696f92ecbbac3ac30113e5c9426ec31ba861c1be8a076f76b7cff2c16d80bf559e629bf263b30709265f7b32cfd762b9e691103d06559b6a21d2649597a984dad9080bbabc0fd544218b58568a82448041267b243917188e239f2871c503b49c370bd9fd1b2ee240bad200a0e13f2301e9308698d2180b08411684c1b721f738ba9d9dff9fa221a20293271d8da413c272845709f8a2a9affe3b2ac48257482238a4c20fa9a75d892d3ecdf7ce3733ffda98f87f6899fd25fbbebc7248b8c984dd8d231a55d95c1da5fdb90605ae10d452630e4b748b9d96699dfb7fff4dc273eced9bd83bb7dc2a05d1c66adbbcf55d87c92dca791ef7fbb6ddd8988fa5f0bd530ac92e404f8ad245931020f4f48094c549d2449ba4ff3e5a38f4bec48df0d3376dbf39d823d173b51759dd22566e24b9da2fd52acc4c1912a9f3c180aefd5fa8db1083fdd29db8f0f850f7bffae170e5aebd745b51c740afce72ffeea27bbd0be7aa7c17b5f47b57c4e65f916697e79eeee95dffc1fcbff3e5e53aa2de6b370746ed8fc8b6093e1541ab412113cbca08dc1d5d9c0b41c0a3eaafbd30e8c7a62a96992c9b181e595a604aaf0cec83ff8a7fe9f8cd77c5261e1da5fbe3934deedfd8f9c7b6fa821b10068f049030420424314eb5080d57d6f8350cad63521a838c5aa7b22948a6eb445df87522f3f493dd01ecd8674ef03c51679a0effd5b81c4fb42c5056e0375a8a72d43876868d67de1558d31cb24160a041dc9a6016d8525a9d681d2804dab7e6149c6d3f5311d45a21ac1432275a300be8e11fde95fb8275b80f53079aaef851ddb90d77a6275c81546049224de0b184b4ef152df4648203e4a2ae7328fa38ac9a50cfda5a114b05e2b92784fb10951f844e8fa569f88280828eaf800d56880b13c648b4f3946a8d75c66530aafa300be8c2c8cf91585a5fbc21061ac34c6fa9043dd87c2a31125cc35888a8014821c871ac29948d5c7898862e286e0d5503c1d8b103bc500b98506351ac0f28a8412754178dda9e139849b4fea045cb77dc6f35aa06001a1af13480790ddbf064a9b0d2351580a61a43c8f12a84c78e196e18365d0ab3d44d07b30126c22223d81620e4247138aa669057d22ceb7426aff1caa386e11dd34b684b209f207cbdc6dc906022e4843a70a1a4a9a77410e750868b832b6bf51a0170f1c423ad4f8a837085c0bb9498994ad011935f8bd85295a2375db96224bc124c1f23c3511c28d9f36e2225dba2f0f15a82809a6420b56930cbcca1fd9204f6d81cbb4c87b1b15d050a9182f400d3b9d8109c3f4948c86eef83d093e10a78e5b08252b71c128511a6a9a689a3ed19d327d566e076c92bd524b320f462811600363c4ca0c5af8808973083a4bef0f4d24c0373e4e2eb2ee2643be5b1241a4f02076198a2352ea354c74b0e2449d89aac0f8a55905c87df4f1706509ce73569095e99ea1260ed12853c22a1c8390b58a846e1600950b622833a04459a79a42d41229357586663689f75544f0b0cfd08bcaf2493312e0692c0183448266b04c2cc95440d38d11b4d0e22945ab00fe60282d252e2861781a0ae42e43a100b04087e64b353063791594e711013ffb717a51e83479cf8cee6a5372c514503252c9552ab94a8022947158beae935fe98658c0b9f71466103217d450bcb2e26a6890630fd08a547441aa042470298adb88802f73a12cef97fc851131a52ff3a0b05cb9d48898937199c67c0752991c00e15b5524744ce9ca144ed04a7f0c4930e51dda62d04a3c4913a10cb0999ffada0dc2b161bc38c4630d4691652851dc8e0a303fcec4f27fbaf7097ef9b4190d1802a4e5a57ea08f11d02642120fb673b6a2226519a9d7840a8680146a6f652899661a704533f5cd128f0590b8635d40355b1f56e20a39be76146a623c2f845c7598dc45c8483119ac5700331b703532e0cb1f57b65f1d11246e8b52446d0dcdee495d26defb4a8a4f1e2f4408cc88d4b2d610be92ab83ada6101a3721c0bcd62f4288697485f963404249e60286a19f69afc6149c06859a241688283606c2eb427b263f6ab6eabe0a4c66534407989f55e5e7cd88e0bb941cf0cd8fa591d2a7bd4424525b0ec3ade903eac1ebcc34e1da3818eb632849bd6634f679d80c8173fd88133110acc7157bc05f06e3d3668480f97140a1bfe408315502f174059eff08455cde9083eab4dd904965991628991c654e10630b0cc2870d81d98f95bb40c5964e0d63dfe7d1752a170f6e0f843ec244e412548b63705288d4c444097c43e9b25c0cabbbbcb5a29667ad35866c0063b7695edd6e1846846937a830060382368ce1a5cae41bbb0c2513ef8c391798698b724031cb211e6756f5ba05578843129b860e5855cfd90d80e32467b24bc6a736146a411b55c66e40645e9102c63c2fe767be751b3bca725b1809c5b7defea1c494fe43cbf2a0a92762c07cfed3920d7dd1983b2b0e7659cd9d0452f18d1a30e68b3f41dec196fdf8978cb91393d83b0eda44101863d65ffc9cd6eb6fbd305cb445516cde46bce1bdd7c296951700978ba21e5a2ea08b2d73c7231ab68993d8c0b431176dddc7cfed8bb3b0f04961e28eb7c557d8047b72db22bcc4561c329d75ae781fc4542cd96edd897f2716a95b7e93f6fbb6c6a4e40d1c297dd705bccb2168b8e699d6378125425b144a455335d13eef61bb750746febd0901fd0682d76e6c2562035bd885b4ce45bdd130df59c07c8742e335caa8e12def0ded735a44fbf4f9f7b5c3d2f7a6109f295123097e78fbdb3c6ce0290b1c900f443fc162b70f9f05a1810484c2ee6e49ba685bef6d840f7ca2d896bce9c5b5a45208f403fce8f30436403fbce280d3d66045b282006e88c0c46b50dd0a4aaf4da4cf43f2f695c627a7c87ea5062ad20c536194264062396d47fa88bcb528004052e73db4e3d458c056d13e96435a656bfc535c09b8f49e463eaf6d496485a40d2d4cb14a095cf11a341cb7913f5b129ea4ed23967c003486aa949ad3265495077def099a650a5a0ab176bcb08a1f120da33280ef47e8ebb251001496e27610f5f312db0e126cb2570f0d78c568db34854fe0309c02f828d86d8dfa09d89b097c5b63c9dd3d0005d5e6c97ea832a6ef83977c15fdf7e1d21f3ee6fb7075feb8a581ae082ff5d0cf98836e56055cd97b1b0bf4453eeeac31b6f462fd69e20fac316da8c20e824f88b6d44cfb7004dc260ad02ff229e285f7d438e85f12cad0b35046be3108d7bcd7baef6173197ee547dfa880f940100bbc37f4810ebf43a022b15e808a606320ea73097e0301f315047a9afa4689da27b1c1671c4c83297b78ba1dec130fe8c3a6ec99ff583b80ce435f8f55fcedbf3f76db1decb37af430e33518b7d6fec7ff6aecb67d80079ae647c6adb5ffd6df19bb6d1fc0c23722c4359febf8ba3a18d65559746d3cf6d9a913ff99f8cfc47f26fef32796f38d177ff9b9e2f8c5afc558e4c73fce0ca9e773073115fa13b269fb88a3c87f46618e080e62270ee69d827deae0ee9db7be97b7d9f07954d7e309e1a274f9e65d3afcc8b74634b213a7f2954b65118c2de32efbf1a1f12f5e379b6dd92162ad6d65b4d65a5546e54ceb9bc6aa22d1d68eccc17d8fa011a6c3931816b6755b90fa66ff1f7948a76c2f0e878064b7da0ceba56fbd97ff4b3bef9391e3bdaf2970fe86cda05c16da8291907a5fec93773b7a42706322a5d2d4b364439bee0893b343ea2331f682c77a3f0496de8f57b4b2fcba5553d3b60a5816551fdafd7c189ccf99c5678635bc76db0f79dfbb60b204fce53b0462046645bd3920ef016d765ca23ba4733a611e4f1fb51a2788624b3327849aa61bcda150d3b204ba1f4a795bbb61741aea4ed357c1a9b4a7de2785051aedbdd7cd7e3dc533cfd11933f9a92150d2110a3fd2f707ed1051b9fb76e2bdde1f0e6d7057e311ad169149bed856fba2ef85bd8d8c1ab4c3ef6e0f55a43ed4d63274e4c4420e6088b0746c9507a118ea83d00ae711b23f8eaf5d61b29d9888cf06861da9b33977d09a6513728d346204e5bbcac60a888aa2b12cb6098d54ee498dbe9d1545e95b031a1a2afb81a66137c078445996456d39ce414e1e2a247ed401ca114eb64d6dc14fa2ad95695b364d409301958287644f1635007c4292146c854f44cdccee2f9478f2a6c7e42c76848ae9a1a71b78aac521b4952d64ef8f532c4a7983a808589bfaefc2314ea20f875e93b37304659bfbe13c11282cec981d17c3c12ab4365b3c251acf459c262a08643cd2afe56fd021e19b5ac4489f8c51dfd2cc806c80f128d96267dea366a83d935b977478b644ce34f4a5217e92bb5ba26d6649a12a1b8afb152c2bd8935f3e21589a906454e3cb44f86413eac6fe0173ca550ff47d004036eb7d6251540314b4761d109624cb3ff43577f7d22798190a1f3a927764b9d907f90a1920f1b7169f5658ba2f0fe746f2aee0941ccb4fa100af82720d169ec6537b9bb18c860319bc0f013bb9254a94f23110275e81034e9b1a5c3ed1b20e16bcbf9791be0fe1d424fb08a59fd15758299861c892684e0986eec0d7b287b59aa7a08ab4ef4ce39fb2fbf1bc7d2c3e2d5fbacf0dce391a82b02bd7d421efadebd624a2f4593e92600826222250850548fd51c261a87ed3068588b3225412d869e1fd5406f890347699406daf102e774dc111d442585da78d90d41821493391dac77c9c68b3429b5ea236457491a0a62311b0c4c102fced1fd9e09a173b690df5490808ecb4ecfb6e1f41fb8302ec00ff696a129cb50446eb8c2378b448bde739f41a7d487c01032fd775d0ee8fac6849292efc32ac072eb932c3b2b32400a14b67c464c93dad467072496450299de5da4b1ec98d1432851fc642ae41ebf725b30a13a29a951400fd875be92ae2e90cd1d62a51e3d8c19f4285963696d2f110c3ebb343ba961d167c67f615a80d85da6b801eae4daf253ca96c1fe4106b21fbe2c3176cb7c8c52fe2f889878ab18f1c32b389c350424010019c8aa5c5a014bb866f3352fa1e3354daa6af4bd169454ee149bf0711560189313355608ab90b1550a342190f8118ea9212cc147db4bc17054433e984e11f073a66871d526b7fe1bb2cb5215012408b166d595ac69625d6e24bb6108d5efbe29d9f94f63d7ebee3185657c936a8219bad294c9860712769a1b74c4e20e50d349bb6c60474d7b791a33d6765c34d4c860c325e5cd91c61b452a4d38fa14c1d22f7a2f47ca942bce7aaa849b39fe0d8911f0f82a5b24a82860749d14afbeeb6efbbfdb17b09bd282cf361aa0f420e8789f8218119123e46d12354433d10057835448c1c903d1a1c0f2bdfd25429f61196f4dc4f9b2218849a39916f42ea1b95875df11aa90bcbecc8bfe4ebfd90cf7e9cbf3c3fecd95838c5348fbf8fc7799f705363c2a8b094fa90ef42c5e80aba6b89271176ee91b71e863cd5521e025ee20367c9a8f772402d0dfb529536648bd98f652a9f2fa9d0725e083abec592c518bb2ce1af36f70fa6e4ccc56ce2ab4138dedc80c3408961781b4633708832a77d5f9306bac0120ded3e3988836f7c92b9ac7359d7ffc51096039f5843f7cf660c9769d08966475645f23ae0040aa403196d07220aa8346e3139831508490d70c5930cbd6e2c372b428d140c424de37f4b95699f951d88983e86b45261ca7b5170c5e95669793a6b8c0155cd3e72ecfb5c5f34fd96c65fdb1884c4cf8434ff3002158ea27954fb3ecdea1f2f3a632a2f7c38f6bec4c91279b499253ed98f675672c8533c836de841db1ad17cf20870b0695b110b89c543cb95011529aad8c2820d9f8aa73df085450ecd913fb0b4f49d862481357d2054019a5e0be1a5454cb726e8ab7084520288543548b275441b69144dadf32aa0831614fa82346fa2e09ae3c82701c1ec1b707d0dca76b0bb415bffe10d8ab98262b11a09b20aa6f5bb7f24f4550953eddf177f7c5a95e3c5309e25e16b444cb370830d27691fc30455f43da800485bbc652940ba16c2ab253c833ec05784e68f42cb3c0aa8db2a4c13e12ba443a58eed33da1ee69c50e31c3f3f4244629a0a859640c424fa60bf38f6fd503065eaf897ebe6141163251b08cc29f2b0a0966ab34b21c45281d8ff8ee8e3fce9cc7e3f012dbf3aa453b463b8d68a28a62178853d5ac7abc00a1a8904cd625ff2c41c3fbd2556ec2501df0782798f3811891449be531b45b8b28116e50e8f616b254c451cec87b0cef7a71bfc1593d8fbe9e788e0138d43f62b239d87537b59f7bd4fe9bbd82b9da6a9d0f0d0b1a83bd1d91bb0055561b5d6a0f10804100570b8b43814911580ceb782860e45872ea4478ce080f7e8212d349dd25a57dcc7609498ef54f06610d05a69ad05726d56f89a969679f7485f9f13c9804aa962eabc29dbc7b5ee5070120a06e7975aeb16bd3812ff068747ed4614817969ec9cead66802b3903ee0f89e895078486b332ed9afb27ff8e4f3df8ade3e3b75ffdcd8cffd78d675d9670eeeb5f1d8f7c54cfc67e23f13ff99f8cfc47ffe081efff09f8dddf602e101e67fc9e2d4dd01ff7cecb6170896fd1ec576a00ca08d756e58f1b5d1a1e9444c34e120e26cdc43b061e8f910c45f18ed750c46ed13381b48ad750da1bcacb74c5016ffb216533756d7a1c8ba065da545da471f471128a9ad8b2d464c5c41e90fb92fd4dfc433921032028f86677fca7ec1bd4d40c45330936378ae9235f3b5fb753c814df0cccfcae9f491c46be049df2f8a7573d9fbae69c87931c0b9136a147a10d850c5f1263929175d3cbca143311bd32ba1d27881c60a6b12fc3fba29b8af7477de5f6bb9bb8163d22c13ea297c02d20baf91a938bc40245607365680b34e9c4c0b0633c51a2929d191c29c2e02817faa1554541239c5f51882fe934c03cad6a38fa7046de4a010ef0321a201ebbcb7028ce6c427c5561b433c4c65081c946220969eb38093740e563978a38d31b8e2bd3e0a5a3b141a9f34d4e08a6a5f16709eec36b6c092b6fee1f0903f1ee0c4774e55899fc5162c49bc3e34141ea0ab9872938568697c1267704a500c033875c856d0f984e3c8d7f474bd630ba67d3f4b2d3c41cb32f57ed634a99469e293260d4aef2b0a9e0c6a606dddf7557cb14ae5c14aef2d0b9e94782385efaec549bae263883e5cd35ad6ba6f4b7dad0c36eaba85bec84ccc9745698dad6b848aad8ef531d317992a0731413cf6593d13fff9e3a2fccdbfe7feeeb87eaed0bffc539f3a3a9afff873f74c6c65f74a7eda3ee229be56ca6714238ebaf7132abf911bb1135feaba2ef6ba1c4c3b35bb172f71d475239c80967711ab9b7f313cc4040bbc70d92a8a229ae3f90e6c54c3c2e2c7d567ef845306517befa3c29f9ffc399cee886f0e199fb4f1055a71009c70796e483c5187760ddec31e5ff0938a634cfdecd0662bc8d340b5fdf0477c41a6b08ce2774b848ed4540c30530cfa9a6ce051ad1f37b54e378db125ceee0b21d07d9fd4c0a95a8b42b8b0282254d5d70d517400b30b43db49e87833cf69ad37c92cc21c80c407b4d6afe236a0b56e6cf1a4663e074338336b086dd927dea07622e2655a6bbba5d347d17b4edae322d72a6ca4c33768d5ef275496eeab43e53d2174a0b46403cefb44046e20e6e808eca92dfc8fc247153311c04fb083a0b5899a881c09e8b86b0b28a91d275136ce7d4c0cae383f477cf6bac5f9fb2095567e04b65b382c5be14b2d73b8f351d08739ad98f9757a5e61e9be30d41b89f7890ade0b2c7cfd881117cb4f2d450081eafba9e17eb13cb416a1f508cef6c7a146ad867306045dc6b004bd4fa8e13d4064f6d1998799192f41370346fb31999b1381c461cbfc6a8c246d94d37d8b9bd988e7b965b8e826b4524448a146bf7ce3a6c6d1753f128a2b011d4caf617c25de1fe3af74c8213311186f10f33cd3b0bfa12292df8b8a808e6cff098b2560a388ae6ba6d8dd82b2b23378b53c9761e41758fa96c211a45fd40f77bcc31d6832b6e8473a3717fcece94897eedeb09fc82a718d841c04da95e4720b370c334b03755d6f920950c03924b062b7128bbd1363602b4f0134f40bef3504a92573c0a015c0e8340c272d71a6268a346cb3a9eb4742114b86c4b20e77c2e19a4efa40d473377bf996fc774b64b8686b94b0247852fe61337eb3a79a52f73d333f26fe8959633190fba930efbde466e27dc53808136fa2c4cc50a61e9c291a4b30ec06daa09ca59ea1327287034cd2722b223af4fddce87eb744fa5a6bfcf4592512da522f7b220a33d71d48c5356c049eb54dae286c8d284f0533a0f1de5b156ac3d81b98d61205ea3ed5249dee01460ed7a493463afc6c472f9265f8c7e58c1900089b56159b4063c6658d126d41668ca6b3216fad895963982930096f170857391c10638b8434ed482921672a4b0912875b63aae33e36c5b61b91ce8aece5e048321b0ba3e1508580d6cb5ed6c8698824c7343fb68168ef7f7ccacc7e071b53a5f73a01a14ed40e990308948754609c112924c392a9b2082428397c6e29543791ce0feeadd73ffdcb92e5d36604bc842dfcd6f370534b72e8932d098cb443e0329e7a9713323569a6b77ed6f0ed262874490e9b5970dc12f70b35ae1486783693b124d12cbb120e1f700e3bf4c0ef4327b571d7f5bb25c2c611fe2689f43938398fc2e4cd55324ad81f0dae7941ee7dd26cdaad44280abc50616a49df30a834d6745a3eca60966044c2118b5a7b258ed09999f0590294b627a9adbd0489c330752a5bd6e2cc3d453af633ea732b397cb8d91393323de4e65b4c0233e924c05bbde22f7b48df325c8638647b8d4018331ad598b1cec83064664f64481c7e8093566c8cafece713d072bc1805b445521fca30d302b9764a8aa9faec8494542494b46563ece09ce10f0048e71ea67f19f41ce3e4c128dee09c916213c089165332e540fc459f33c69204f3656b221e5b7c7a748b69e4bfe321f672510664cef982a6f1ac9ea20389cba6e13760abba6e5a4b66cf2fa8e9fcf581243a5f7dfc5f5454c4b22ecaa6e5e6cdaf6bc99cfa354d734ea2b6a63e4f43f7f80d2cebb20b402d4e7b9f92c3762954b726fab1c58f2bfdfa96dc91acbd06fd15235b7b3ebcf3ce37711f96f4bb8f706df1d963c9d498dcb9383011afadbff8dc4fdffbb9cfadcd1dcbec93a998fca058cc26fe33f19f89ff4cfc67e23ffb307ffd6f8dddb67f106dfe6e89ec1f449cbf2329b1984dfc67e23f13ff99f8cfc47ffeb8113b6f8ec1e87dcc9d8fc3968f9e8ec3963371f0525e589f67c9d7ebb30c97be379bcbc8b32c3b1d09f34cf38a912e8eb5f55cac6772f13855d67b425f73b544ae3e0b32e6449473ee92b9e9dc8a112a54dc5205040e2b619dfbe1a88f573ad754dc9f6f73be9b2a6cc4a55c5019570555e3dc0d2325ff31e7ae8f0ce75c1615627e405ce8dfdee66c3be79eddcd6e3ae73e8099894b17b0ea6b0c715c2164bf47a88a6e91ed0796747979c6d8bc1c161fcc893d986faf567a10a86fde395742a42fb4313b0e62af72e2a70265e1dc6ad4848991477f9436fc23fd73e3387bfbb068f9869475c992bf255b9e9744630672424a11e905b8fa3404692fe40ce5f432bb44da607e50f623178a1888b73b0de425125fcb75484fa4c3f9f57a8602532a10b48077d1d9e58c75ccdfde64990f9f6dc98d6a0fd4af2acafb9ddb85aa27306bd6532648e1e7ca107e086b87c0c5905d8073e50315cb3bb0c1e6edc0cba9af4c02e6f4c6e9ab44a0c4bb66169d5d0a97cea806c61e3423a6a24571432f53cc2faa5bce594ef99b40cdeb9d731997b9b097c2b90216de9592e1bbf9d2be4b898862a6c0827147e25d51466697594fad18191aab25d825298d73cf4e9737987a1c09afd43ac7e424b3d5ca3a88f4cc39b76658edbe1f9a60a8905cc0bbd2a3ccc1f19da79d736731f63f90dd105a5e147aed7a5d029807acb24cb839272cd6b8271e7d9a63ac9100413723fb98257f716cc56e857b940f62b09d074841fa6f68c95c31d5ca3989f244b842689cab8847bb20ecb150c44e48297918ec037f88ec8f2f90c73051da2897ceb9bdb530ae425935dcee278ffb4089a524407760d764dff4452a5ce60af24a214148e99c6bb8e6976edb181909cd3b768483828f104d7b111997968a960e8d672dd84ac6d38eb38c59ecce8366d6898e24c0e9d52a11e5e307241c191a84252111485cb98724ac94c2145cb38c9c2cc484406e9030b9c03a3263ee94edde6857697818ffd6f29e59f4305dc7d2727ba4fc0d992b802ccd209a07a11040aacc23381275e6c346e1aa92b58c76ce15dcb1b67fbdd35bcc19bfd7504a4aae32bc8292b544785738ce532da619e00a4b63266d2238ccb6aacdcc6879d1b967b01c5c13551513a49d50e06858ed0892905d5afd2b49485ae2996584af1857909c36dc9c9d576ceeb1b85e49b98802f1187b2921e25b65c42c488bcafa59d7cc9818fe40458ec47dc4dc041920cc59ecab4570bd0adbf86f105f2a8073c585ae90b05ce371bfb273ee3a94c42b1abf829cc11428f0e5a9901b158341dae83daef82be188dcaa6771fff74ce184a6945414c5cd1900ea849c3427718add1c65ae101670d0a1977287db1ad07c83561be7841d1078cb09372263d8b7cc581a9ab995b4be247071a47c9c093548cad443691765b970cb85e79471452e6ccac20b9c9b488ef317546d38586b77195e69ad0db1d682e61d283077b9be60a7e710ef696f1b43b5b250a86dd32d16678db961edd1dc3272be1b7e32360557a6daa040507f93155fb2c24a9fe2f1019234f305114844d30d447c4f34bf1d3a602abc9b45cf66b94c9836dc2eec070c3150477e660aaea8f8a25585699946bd0a052a58d4c70baeb366a1e2ea33ced5261ab664a96a2fc0b71d28f469390cbdd72616b389ff4cfc67e23f13ff99f8cf1f1fe7effea3b1dbfec8eadc98fcd5bf36769b89c56ce23f13ff99f8cfc47f26fe139f50edadaad88b373debdc8fdd8bb7287fc881f5aa188bae71ceada7ceb9e635b115ef70ced96d32acaaab71d5d69c73b586a7f6ceb966b86b953bbd3c6fcedf3e49b05c2e4f0f536184ca85d4b9f43166004b627216e6438cc5f73bb4513785ca064837c481369db9edb9b85c5e8a90b6768b8d927c2136560e6b691cb562be1f71c3b9261a5a6d21b6a6255aa6b0d6f096677b5967610614620b0ec46a2b8581c60d6d633d98e1125a7ddc8b2b38eb9cfbd1fbb9825dfc0fceb9f3c3516d49d17b1386fe7cba97e7f72fe4f6d607e81eeb3a5fd8bd39ced54e9e5faaae879ad67c4b8db6762f9f49586bbbc889b8eaea9e5da0f08ba1f072aeedea7ac5f252a8e6df1ace4be133e353289917a1e78c33c4334c29ba01366d66c2cf679c2b4221510faf7403d97a707698a13c92c98380d1dc76a87ac594b0cee1e0a485a667717cfc0af5c8ab2c7bac940347845718cdff9ea860b844f217de4b77ab647d6a2a684f62451c1011794947b5cf6c4088a669336706e11ff5d86210ac199c9bfc8c6134ce358073dc85745ac1c1da3a952929691829f72573204173808a11b12719b2678ff2f2940ecb989f291397f1cd404dc9ea5f1873c03923459636d111f93ccb0a5764d9fb9dbb91652f3ab7224276f410789aaf26896213596dbf625e40d8cfa11d07aa956b64b1dcb1dc8f15ea6a644adc7a359b620ed08343f2673ac60b572d2b218900b32891b3d9cb228751ab1e6159ba3e030e64a60999e6332f86510c5a577a269c99abb1876933cfb76be78aa868ae839e710d84ca0578856720645882f9f6951b140bbbac74e62f2ad22e521843f62617a44822353b634051c651d136d5c4ece4f963b4ce0764c4c31c58481643aa74154ccd0e75a04aa75a7803071ed7a10832f31238707e253e4a922d635689f850b9624a4228c49c73ffb1175a27a251b04b2465dc8a17767a5646027aa8ca336fb9fe8194e1bc24d26178dfb2918c2f57b7523aa71f25e87e909b3d0933d390401634bee85c2187a6408448c7dffd341729747cf8b9a4e5869b82088eb3ab9456b6a44f44069f7f091b5e1872092e64c1368e5ea55eacb8e93031868d516ee4fa547f4489eaf489c13ee191128b35b1f34a542944674f1d6c3d49f76e0e84cb640d47b65b087622632eb2c5578f69b9c868681e19c998d995b809ad1ef2bbe734afd815ebddc88d992b93ce2c369532b13ad5e4ee3933a71f95e1e6c6e46285014b6f384379656489b9497b544241670dd0082173c964ca9c5df5ceab51a0824ac61e7524a195b91d359809025971a5e447203504a7e9c47de4ee03b305e7727e7687447df90c5d6557f819ad311f2a792162f9face0a6a6bdb887b66bd860a590e91a7cfe7eb5bced9d3aaec9d35b3850cd70b85435e21b867cc3a5526c779d8b9c7509cc5bed57bd8ead93b7fe61e6d587557cb0b709840b4633673480c3707dfddf54b579d322e5b5e8c80287b58eccce7b09f270ec73d33c4fefeb3c231f69841f8fa598f9dda0525a650cd734e022bb52c88ae41280be650fa827a01095932f30462cfb0e9738b3f86be4b9ec639a7c88e732e129adb0f7124389d4bbbf90eedfda192f928d936843d1a37c23c923e665460e22f6d9c5b73d40a3368b2180428633f40b30aaab26193649163ef6a66a6bacc0e11b1667dbfa14669814868b133b5882dcaa1f5d05fdf5caf7757c650e679a8a4b7222e0811dd549b902ccb2e0a76b26cc164239d5035cfb24b241db22ccbf31b8c27e0435a0a35668673068a1b4015c48dac64d2a0db5d0945e8542544331e72a97166cea655391782846b339a36b80110d8cbf379e443220a983d057b660413f7c1626207cbdd0096c74798f9c2aada636684c429364a62319bf8cfc47f26fe33f19f89ff8c99fc95bf316edb3d'
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_test_1768408494')
  AND section_order = 34;


UPDATE sections
SET section_image_data = E'\\x3c7376672077696474683d2233363322206865696768743d22323534222076696577426f783d223020302033363320323534222066696c6c3d226e6f6e652220786d6c6e733d22687474703a2f2f7777772e77332e6f72672f323030302f737667223e0a3c6720636c69702d706174683d2275726c2823636c6970305f3132365f3832373829223e0a3c656c6c697073652063783d2239352e38313435222063793d223230332e353035222072783d223530222072793d2235302e35303531222066696c6c3d2223303037374335222f3e0a3c706174682066696c6c2d72756c653d226576656e6f64642220636c69702d72756c653d226576656e6f64642220643d224d3131362e303638203230392e313436433131352e393338203230392e313435203131352e383133203230392e303931203131352e373231203230382e393936433131352e363238203230382e39203131352e353736203230382e3737203131352e353736203230382e363335433131352e353831203230382e353033203131352e363336203230382e333739203131352e373237203230382e323838433131352e383139203230382e313937203131352e393431203230382e313436203131362e303638203230382e313436433131362e313935203230382e313436203131362e333137203230382e313937203131362e343039203230382e323838433131362e353031203230382e333739203131362e353535203230382e353033203131362e353631203230382e363335433131362e353631203230382e393135203131362e333431203230392e313436203131362e303638203230392e313436563230392e3134365a4d3131362e303638203230382e3033433131352e373435203230382e3033203131352e343833203230382e323939203131352e343833203230382e363335433131352e343833203230382e393731203131352e373435203230392e323334203131362e303638203230392e323334433131362e333932203230392e323334203131362e363534203230382e3937203131362e363534203230382e363335433131362e363534203230382e323939203131362e333932203230382e3033203131362e303638203230382e30335a4d3131352e393538203230382e353839563230382e333935483131362e303636433131362e313238203230382e333935203131362e313937203230382e343135203131362e313937203230382e343839433131362e313937203230382e353731203131362e3132203230382e353839203131362e303533203230382e353839483131352e3935385a4d3131362e333135203230382e343931433131362e333135203230382e333435203131362e313934203230382e323931203131362e303731203230382e323931483131352e383431563230382e393732483131352e393538563230382e363838483131362e3034334c3131362e313937203230382e393733483131362e3334314c3131362e313633203230382e363735433131362e323536203230382e363534203131362e333134203230382e3539203131362e333134203230382e3439314c3131362e333135203230382e3439315a4d3131322e363331203139392e383532433131322e3739203139392e383536203131322e393438203139392e383236203131332e303936203139392e373635433131332e323434203139392e373034203131332e333739203139392e363133203131332e343933203139392e343938433131332e363036203139392e333832203131332e363937203139392e323434203131332e373538203139392e303932433131332e3832203139382e3934203131332e383532203139382e373736203131332e383532203139382e363131433131332e383532203139382e343436203131332e3832203139382e323833203131332e373538203139382e3133433131332e363937203139372e393738203131332e363037203139372e3834203131332e343933203139372e373235433131332e333739203139372e363039203131332e323435203139372e353138203131332e303937203139372e343537433131322e393439203139372e333936203131322e373931203139372e333637203131322e363332203139372e3337433131322e333139203139372e333736203131322e303231203139372e3531203131312e383031203139372e373432433131312e353832203139372e393734203131312e343539203139382e323836203131312e343539203139382e363131433131312e343539203139382e393336203131312e353832203139392e323438203131312e383031203139392e3438433131322e303231203139392e373132203131322e333139203139392e383436203131322e363332203139392e383532483131322e3633315a4d3130392e343232203230302e393234563230322e373435483131312e363431563230392e313437483131332e363231563230322e373435483131352e3834563230302e393234483130392e3432325a4d39322e31343935203139392e3835324339322e33303636203139392e3835322039322e34363232203139392e38322039322e36303733203139392e3735384339322e37353234203139392e3639352039322e38383433203139392e3630342039322e39393534203139392e3438394339332e31303635203139392e3337342039332e31393436203139392e3233372039332e32353437203139392e3038364339332e33313439203139382e3933352039332e33343538203139382e3737342039332e33343538203139382e3631314339332e33343538203139382e3434382039332e33313439203139382e3238372039332e32353437203139382e3133364339332e31393436203139372e3938352039332e31303635203139372e3834392039322e39393534203139372e3733334339322e38383433203139372e3631382039322e37353234203139372e3532372039322e36303733203139372e3436344339322e34363232203139372e3430322039322e33303636203139372e33372039322e31343935203139372e33374339312e38333635203139372e3337362039312e35333833203139372e35312039312e33313932203139372e3734324339312e31203139372e3937342039302e39373732203139382e3238362039302e39373732203139382e3631314339302e39373732203139382e3933362039312e31203139392e3234382039312e33313932203139392e34384339312e35333833203139392e3731322039312e38333635203139392e3834362039322e31343935203139392e3835325a4d38382e39343031203230322e3734344839312e31353934563230392e3134374839332e31333837563230322e3734354839352e33353835563230302e3932344838382e39343036563230322e3734354c38382e39343031203230322e3734345a4d3130362e303535203230392e313437483130382e303335563230302e393239483130362e303535563230392e313437483130362e3035355a4d3130322e303439203230352e343439433130322e303439203230362e353435203130312e343534203230372e363734203130302e323031203230372e3637344339382e393331203230372e3637342039382e37313636203230362e3435392039382e37313636203230352e343833563230302e3932394839362e37333637563230362e3036354339362e37333637203230372e3734332039372e35393434203230392e3338362039392e36353731203230392e333836433130302e383238203230392e333836203130312e373638203230382e3635203130322e313135203230372e383238483130322e313438563230392e313437483130342e303238563230302e393239483130322e3034394c3130322e303439203230352e3434395a4d38352e30313139203230302e3638394338332e38343036203230302e3638392038322e39303035203230312e3432362038322e35353431203230322e3234374838322e35323037563230302e3932394838302e36343035563230392e3134374838322e36313939563230342e3632374338322e36313939203230332e3533312038332e32313431203230322e3430312038342e34363737203230322e3430314338352e37333735203230322e3430312038352e39353234203230332e3631372038352e39353234203230342e353933563230392e3134374838372e39333138563230342e30314338372e39333138203230322e3333332038372e30373436203230302e3638392038352e30313138203230302e3638394c38352e30313139203230302e3638395a4d37362e36333238203230392e3134374837382e36313231563230302e3932394837362e36333238563230392e3134375a222066696c6c3d227768697465222f3e0a3c636972636c652063783d223137342e323835222063793d2238312220723d223530222066696c6c3d22626c61636b222f3e0a3c706174682066696c6c2d72756c653d226576656e6f64642220636c69702d72756c653d226576656e6f64642220643d224d3134332e38382037382e36353132433134342e3632342037382e36353132203134352e3332332037382e39353235203134352e3834372037392e34393937433134362e3933322038302e36333133203134362e3933322038322e34373237203134352e3834372038332e363034324c3134312e3731322038372e393137354c3134302e3936352038372e313338364c3134352e312038322e38323531433134352e3432362038322e34383536203134352e3630352038322e30333335203134352e3630352038312e35353138433134352e3630352038312e30373033203134352e3432362038302e36313833203134352e312038302e32373839433134342e3432372037392e35373732203134332e3333322037392e353737203134322e3635392038302e3237394c3133372e3836372038352e323738324c3133372e31322038342e3439394c3134312e3931322037392e35303031433134322e3433372037382e39353237203134332e3133362037382e36353134203134332e38382037382e363531325a4d3134332e3530322038312e313535364c3134342e3234352038312e393335394c3133392e3437352038362e39343232433133382e3935332038372e34393034203133382e3235382038372e37393231203133372e3531382038372e37393233433133362e3737372038372e37393233203133362e3038322038372e34393035203133352e35362038362e393432364c3133352e3138382038362e353532354c3133352e3933312038352e373732324c3133362e3330332038362e31363233433133362e3937332038362e38363533203133382e3036322038362e383635203133382e3733322038362e313632314c3134332e3530322038312e313535365a4d3135382e39372037382e32373535433135392e3432332037382e32373535203135392e3833372037382e33353635203136302e3231322037382e35313834433136302e3538362037382e36383034203136302e3930352037382e39303639203136312e3136382037392e31393834433136312e34332037392e3439203136312e3633342037392e38333838203136312e37382038302e323435433136312e3932352038302e36353133203136312e3939382038312e30393538203136312e3939382038312e35373835433136312e3939382038322e30373932203136312e3932312038322e353331203136312e3736372038322e39333433433136312e3631332038332e33333737203136312e3339342038332e36383634203136312e3130392038332e393830374c3136312e3931342038342e393738385638352e32383739483136302e3839314c3136302e3332392038342e35363339433136302e3133332038342e363538203135392e3932332038342e37333135203135392e372038342e37383435433135392e3437362038342e38333735203135392e3233362038342e383634203135382e3937392038342e383634433135382e3531352038342e383634203135382e3039372038342e37383239203135372e3732352038342e36323132433135372e3335332038342e34353932203135372e3033372038342e32333235203135362e3737372038332e39343131433135362e3531372038332e36343936203135362e3331362038332e33303234203135362e3137342038322e38393838433135362e3033312038322e34393536203135352e39362038322e30353536203135352e39362038312e35373835433135352e39362038312e30393538203135362e3033312038302e36353239203135362e3137342038302e32343933433135362e3331362037392e38343632203135362e3531392037392e34393837203135362e3738322037392e32303732433135372e3034342037382e39313538203135372e3336312037382e36383737203135372e3733332037382e35323237433135382e3130352037382e33353831203135382e3531382037382e32373535203135382e39372037382e323735355a4d3136342e3734322037382e323735355638322e31363131433136342e3734322038322e37343038203136342e3836312038332e313731203136352e3130312038332e343532433136352e3334312038332e373333203136352e3637352038332e38373333203136362e3130342038332e38373333433136362e3533332038332e38373333203136362e3836372038332e373333203136372e3130372038332e343532433136372e3334362038332e313731203136372e3436362038322e37343038203136372e3436362038322e313631315637382e32373535483136382e3531395638322e31383737433136382e3531392038322e36343931203136382e3436342038332e30343337203136382e3335322038332e33373231433136382e32342038332e37303033203136382e3038322038332e39363934203136372e3837362038342e31373935433136372e36372038342e33383935203136372e3431362038342e35343332203136372e3131352038342e36343038433136362e3831342038342e37333834203136362e3437372038342e373837203136362e3130342038342e373837433136352e3732352038342e373837203136352e3338362038342e37333834203136352e3038392038342e36343038433136342e37392038342e35343332203136342e3533382038342e33383935203136342e3333322038342e31373935433136342e3132362038332e39363934203136332e3936372038332e37303033203136332e3835362038332e33373231433136332e3734342038332e30343337203136332e3638392038322e36343931203136332e3638392038322e313837375637382e32373535483136342e3734325a4d3135322e3336362037382e31353033433135322e3938372037382e31353033203135332e3437392037382e33303535203135332e3834332037382e363136433135342e3230362037382e39323637203135342e3431392037392e33343232203135342e34382037392e383632374c3135332e3437332037392e39353134433135332e3431322037392e36383532203135332e3238392037392e34373832203135332e3130342037392e33333034433135322e39322037392e31383235203135322e3636322037392e31303835203135322e3333332037392e31303835433135322e3032352037392e31303835203135312e3738342037392e31383339203135312e3631312037392e33333438433135312e3433372037392e34383537203135312e3335312037392e36373935203135312e3335312037392e393136433135312e3335312038302e303532203135312e3337362038302e31363537203135312e3432362038302e32353734433135312e3437372038302e33343933203135312e3534392038302e34323931203135312e3634352038302e343937433135312e37342038302e35363531203135312e3835362038302e36323537203135312e3939332038302e36373838433135322e31332038302e37333231203135322e3238352038302e37383836203135322e3435382038302e383437354c3135322e3838362038302e39383935433135332e3135352038312e30373832203135332e3339372038312e31373133203135332e3631322038312e32363839433135332e3832372038312e33363635203135342e30312038312e34383334203135342e3136312038312e36313935433135342e3331322038312e37353535203135342e3432392038312e39313832203135342e3530392038322e31303735433135342e3539312038322e32393638203135342e3633312038322e35333035203135342e3633312038322e38303834433135342e3633312038332e31303433203135342e3537352038332e33373439203135342e3436342038332e36323032433135342e3335312038332e38363538203135342e3139352038342e30373433203135332e3939342038342e32343537433135332e3739322038342e34313733203135332e3535332038342e35353035203135332e3237362038342e36343439433135322e3939392038342e37333935203135322e3639332038342e373837203135322e3335382038342e373837433135312e3733372038342e373837203135312e3231392038342e36333333203135302e3830362038342e33323536433135302e3339322038342e303138203135302e3133372038332e35353337203135302e3034322038322e393332354c3135312e3036362038322e38333439433135312e3132372038332e31353433203135312e3237312038332e34303434203135312e3439382038332e35383436433135312e3732342038332e37363532203135322e3032322038332e38353533203135322e3339312038332e38353533433135322e3735352038332e38353533203135332e3033362038332e37363636203135332e3233342038332e35383931433135332e3433332038332e34313138203135332e3533322038332e31373831203135332e3533322038322e38383832433135332e3533322038322e37343632203135332e3530362038322e36323635203135332e3435332038322e35323838433135332e3339392038322e34333132203135332e3332352038322e33343835203135332e32332038322e32383034433135332e3133352038322e32313236203135332e3031382038322e31353437203135322e3837382038322e31303735433135322e3733382038322e30363031203135322e3538312038322e30303939203135322e3430382038312e393536364c3135312e3935352038312e38323336433135312e3638362038312e37343637203135312e3434362038312e36353336203135312e3233332038312e353434433135312e3032312038312e34333436203135302e3833392038312e33303539203135302e3638382038312e31353831433135302e3533372038312e30313032203135302e3432322038302e38343032203135302e3334342038302e36343739433135302e3236362038302e34353537203135302e3232372038302e32333232203135302e3232372037392e393738433135302e3232372037392e37313138203135302e3237372037392e34363634203135302e3337382037392e32343135433135302e3437382037392e303137203135302e3632312037382e38323434203135302e3830362037382e36363438433135302e39392037382e35303532203135312e3231342037382e33373935203135312e3437372037382e32383736433135312e37342037382e31393633203135322e3033362037382e31353033203135322e3336362037382e313530335a4d3230382e36312037382e32373535433230392e3237362037382e32373535203230392e3833342037382e34333538203231302e3238332037382e37353536433231302e3733322037392e30373535203231312e30352037392e35303034203231312e3233372038302e303239394c3231302e3136312038302e323438433231302e3031342037392e39323831203230392e3830392037392e36373633203230392e3534362037392e343933433230392e3238342037392e33303938203230382e3936362037392e32313832203230382e3539332037392e32313832433230382e3239342037392e32313832203230382e3032372037392e32373736203230372e3739332037392e33393635433230372e3535382037392e35313534203230372e3336312037392e36373931203230372e322037392e38383738433230372e3033392038302e30393634203230362e3931362038302e33343238203230362e3833312038302e363237433230362e3734372038302e393131203230362e3730342038312e32313533203230362e3730342038312e35333939433230362e3730342038312e38373033203230362e3734382038322e31373632203230362e3833352038322e34353734433230362e3932332038322e37333838203230372e30352038322e393832203230372e3231372038332e31383739433230372e3338332038332e33393337203230372e3538352038332e35353434203230372e3832322038332e36373033433230382e3035392038332e37383634203230382e3333312038332e38343434203230382e3633362038332e38343434433230392e3033312038332e38343434203230392e3335372038332e37343534203230392e3631342038332e35343735433230392e3837312038332e33343937203231302e30372038332e31303832203231302e3231312038322e3832334c3231312e32372038332e30303634433231312e3137342038332e32353039203231312e3034392038332e34383039203231302e3839332038332e36393637433231302e3733382038332e39313235203231302e35352038342e31303135203231302e33332038342e323633433231302e31312038342e34323434203230392e3835342038342e35353231203230392e3536332038342e363436433230392e3237322038342e37333939203230382e3934392038342e373837203230382e3539332038342e373837433230382e3134312038342e373837203230372e3733312038342e37303534203230372e3336312038342e35343234433230362e3939312038342e33373937203230362e3637352038342e31353431203230362e3431332038332e38363632433230362e3135322038332e353738203230352e39352038332e32333439203230352e3830382038322e38333632433230352e3636352038322e34333737203230352e3539342038322e30303536203230352e3539342038312e35333939433230352e3539342038312e30373436203230352e3636352038302e36343235203230352e3830382038302e32343338433230352e39352037392e38343533203230362e3135332037392e35303034203230362e3431382037392e32303934433230362e3638322037382e39313837203230362e3939392037382e3639203230372e3336392037382e35323434433230372e3733392037382e33353834203230382e3135332037382e32373535203230382e36312037382e323735355a4d3139302e3430372037382e31353033433139312e3032382037382e31353033203139312e35322037382e33303535203139312e3838342037382e363136433139322e3234372037382e39323637203139322e34362037392e33343232203139322e3532312037392e383632374c3139312e3531352037392e39353134433139312e3435332037392e36383532203139312e33332037392e34373832203139312e3134362037392e33333034433139302e3936312037392e31383235203139302e3730342037392e31303835203139302e3337342037392e31303835433139302e3036362037392e31303835203138392e3832352037392e31383339203138392e3635322037392e33333438433138392e3437392037392e34383537203138392e3339322037392e36373935203138392e3339322037392e393136433138392e3339322038302e303532203138392e3431372038302e31363537203138392e3436382038302e32353734433138392e3531382038302e33343933203138392e3539312038302e34323931203138392e3638362038302e343937433138392e3738312038302e35363531203138392e3839372038302e36323537203139302e3033342038302e36373838433139302e3137312038302e37333231203139302e3332362038302e37383836203139302e3439392038302e383437354c3139302e3932372038302e39383935433139312e3139362038312e30373832203139312e3433382038312e31373133203139312e3635332038312e32363839433139312e3836382038312e33363635203139322e3035322038312e34383334203139322e3230322038312e36313935433139322e3335332038312e37353535203139322e34372038312e39313832203139322e3535312038322e31303735433139322e3633322038322e32393638203139322e3637322038322e35333035203139322e3637322038322e38303834433139322e3637322038332e31303433203139322e3631362038332e33373439203139322e3530352038332e36323032433139322e3339322038332e38363538203139322e3233362038342e30373433203139322e3033352038342e32343537433139312e3833332038342e34313733203139312e3539342038342e35353035203139312e3331372038342e36343439433139312e30342038342e37333935203139302e3733342038342e373837203139302e3339392038342e373837433138392e3737382038342e373837203138392e3236312038342e36333333203138382e3834372038342e33323536433138382e3433332038342e303138203138382e3137382038332e35353337203138382e3038332038322e393332354c3138392e3130372038322e38333439433138392e3136382038332e31353433203138392e3331322038332e34303434203138392e3533392038332e35383436433138392e3736352038332e37363532203139302e3036332038332e38353533203139302e3433322038332e38353533433139302e3739362038332e38353533203139312e3037372038332e37363636203139312e3237362038332e35383931433139312e3437342038332e34313138203139312e3537332038332e31373831203139312e3537332038322e38383832433139312e3537332038322e37343632203139312e3534372038322e36323635203139312e3439342038322e35323838433139312e3434312038322e34333132203139312e3336362038322e33343835203139312e3237312038322e32383034433139312e3137362038322e32313236203139312e3035392038322e31353437203139302e3931392038322e31303735433139302e3737392038322e30363031203139302e3632322038322e30303939203139302e3434392038312e393536364c3138392e3939362038312e38323336433138392e3732382038312e37343637203138392e3438372038312e36353336203138392e3237352038312e353434433138392e3036322038312e34333436203138382e38382038312e33303539203138382e37332038312e31353831433138382e3537382038312e30313032203138382e3436342038302e38343032203138382e3338352038302e36343739433138382e3330372038302e34353537203138382e3236382038302e32333232203138382e3236382037392e393738433138382e3236382037392e37313138203138382e3331382037392e34363634203138382e3431392037392e32343135433138382e35322037392e303137203138382e3636322037382e38323434203138382e3834372037382e36363438433138392e3033312037382e35303532203138392e3235352037382e33373935203138392e3531382037382e32383736433138392e3738312037382e31393633203139302e3037372037382e31353033203139302e3430372037382e313530335a4d3137332e3338312037382e343030384c3137352e3532342038342e333536365638342e36363138483137342e3436394c3137332e3835372038322e38373431483137312e3231334c3137302e3630312038342e36363138483136392e3630365638342e333536364c3137312e3737342037382e34303038483137332e3338315a4d3137382e3831342037382e34303038433137392e3132332037382e34303038203137392e3431362037382e34323235203137392e3639342037382e34363631433137392e3937322037382e35303937203138302e3232332037382e3631203138302e3434382037382e37363639433138302e3932352037392e30393233203138312e3136332037392e35383336203138312e3136332038302e32343032433138312e3136332038302e35323531203138312e3132332038302e37373336203138312e3034312038302e39383538433138302e39362038312e31393739203138302e3835322038312e333738203138302e3731372038312e35323633433138302e3538322038312e36373436203138302e3432362038312e37393531203138302e32352038312e38383739433138302e3037332038312e393831203137392e3838392038322e30353037203137392e3639382038322e303937314c3138312e3434312038342e333536345638342e36363138483138302e3432324c3137382e3537382038322e32303237483137372e3839365638342e36363138483137362e3835325637382e34303038483137382e3831345a4d3138362e3639362037382e343030385637392e33353939483138332e3830385638302e39393933483138362e3439335638312e393431483138332e3830385638332e37303235483138362e3735355638342e36363138483138322e37375637382e34303038483138362e3639365a4d3139362e3438352037382e34303038433139362e3930322037382e34303038203139372e3235312037382e34353031203139372e3533342037382e353439433139372e3831362037382e36343738203139382e3034342037382e37383433203139382e3231392037382e39353839433139382e3339322037392e31333332203139382e3531382037392e33333831203139382e3539352037392e35373337433139382e3637322037392e383039203139382e3731312038302e30363334203139382e3731312038302e33333636433139382e3731312038302e36363233203139382e3635382038302e39343535203139382e3535322038312e31383637433139382e3434372038312e343238203139382e3239342038312e363237203139382e3039342038312e37383431433139372e3839352038312e393431203139372e3635322038322e30353837203139372e3336372038322e31333733433139372e3038312038322e32313538203139362e3735392038322e323535203139362e342038322e323535483139352e3331325638342e36363138483139342e3234325637382e34303038483139362e3438355a4d3230322e3732372037382e343030384c3230342e38372038342e333536365638342e36363138483230332e3831364c3230332e3230332038322e38373431483230302e3535394c3139392e3934372038342e36363138483139382e3935325638342e333536364c3230312e31322037382e34303038483230322e3732375a4d3231362e362037382e333235325637392e32393336483231332e3639365638302e39343839483231362e3339375638312e38393937483231332e3639365638332e36373833483231362e36365638342e36343639483231322e3635325637382e33323532483231362e365a4d3133362e3531342037352e3134354c3133372e3236312037352e3932344c3133332e3132352038302e32333734433133322e3435322038302e39333934203133322e3435322038322e30383137203133332e3132352038322e37383337433133332e3739382038332e34383535203133342e3839332038332e34383534203133352e3536362038322e373833344c3134302e3335382037372e373834334c3134312e3130352037382e353633354c3133362e3331332038332e35363235433133352e3738382038342e31303937203133352e30392038342e34313134203133342e3334352038342e34313134433133332e3630322038342e34313134203133322e3930332038342e31303938203133322e3337392038332e35363237433133312e3239342038322e34333133203133312e3239342038302e3539203133322e3337392037392e343538344c3133362e3531342037352e3134355a4d3135382e3936322037392e32323933433135382e36362037392e32323933203135382e33392037392e32383832203135382e3135332037392e34303537433135372e3931352037392e35323333203135372e3731342037392e36383633203135372e3534392037392e38393438433135372e3338342038302e31303335203135372e3235382038302e33353035203135372e3137312038302e36333532433135372e3038352038302e39323035203135372e3034322038312e32333035203135372e3034322038312e35363533433135372e3034322038312e39303034203135372e3038362038322e32313138203135372e3137362038322e34393939433135372e3236352038322e37383738203135372e3339322038332e30333735203135372e3535372038332e32343932433135372e3732322038332e34363036203135372e3932332038332e36323636203135382e3136312038332e37343733433135382e3339392038332e38363736203135382e3636382038332e39323737203135382e39372038332e39323737433135392e3237322038332e39323737203135392e3534322038332e38373036203135392e37382038332e373536433136302e3031372038332e36343134203136302e3231392038332e34383133203136302e3338342038332e32373534433136302e3534382038332e30363939203136302e3637362038322e38323134203136302e3736352038322e35333037433136302e3835342038322e32333937203136302e3839392038312e39323039203136302e3839392038312e35373432433136302e3839392038312e32333333203136302e3835342038302e39313839203136302e3736352038302e363331433136302e3637362038302e33343332203136302e3534382038302e30393633203136302e3338342037392e38393035433136302e3231392037392e363835203136302e3031362037392e35323333203135392e3737352037392e34303537433135392e3533352037392e32383832203135392e3236342037392e32323933203135382e3936322037392e323239335a4d3137322e3639332037392e33343237483137322e3432394c3137322e3332372037392e36333931433137322e3239332037392e373338203137322e3235352037392e38343835203137322e3231322037392e39373034433137322e31372038302e30393235203137322e3132332038302e323332203137322e3037322038302e33383931433137322e3032312038302e35343538203137312e3935382038302e37323931203137312e3838352038302e393338334c3137312e3533362038312e39333234483137332e3535314c3137332e32322038302e39333833433137332e3038392038302e353439203137322e3938342038302e323332203137322e3930352037392e393838433137322e3832362037392e37343338203137322e3735352037392e35323837203137322e3639332037392e333432375a4d3230322e3033392037392e33343237483230312e3737354c3230312e3637332037392e36333931433230312e3633392037392e373338203230312e3630312037392e38343835203230312e3535382037392e39373034433230312e3531362038302e30393235203230312e3436392038302e323332203230312e3431382038302e33383931433230312e3336372038302e35343538203230312e3330352038302e37323931203230312e3233312038302e393338334c3230302e3838322038312e39333234483230322e3839374c3230322e3536362038302e39333833433230322e3433352038302e353439203230322e33332038302e323332203230322e3235312037392e393838433230322e3137322037392e37343338203230322e3130312037392e35323837203230322e3033392037392e333432375a4d3134302e3730382037352e32373032433134312e3434392037352e32373032203134322e3134342037352e353732203134322e3636362037362e31324c3134332e3033382037362e35314c3134322e3239342037372e323930334c3134312e3932332037362e39303033433134312e3539392037362e35363031203134312e3136382037362e33373333203134302e3730382037362e33373333433134302e3234392037362e33373333203133392e3831382037362e35363033203133392e3439332037362e393030354c3133342e3732342038312e393036394c3133332e39382038312e313236364c3133382e37352037362e31323033433133392e3237322037352e35373232203133392e3936382037352e32373034203134302e3730382037352e323730325a4d3139362e3335372037392e33343235483139352e3331325638312e33313332483139362e3334433139362e3532382038312e33313332203139362e3730312038312e32393734203139362e3835382038312e32363536433139372e3031342038312e323334203139372e3135312038312e31383038203139372e3236382038312e31303538433139372e3338352038312e30333039203139372e3437372038302e39333031203139372e3534322038302e38303332433139372e3630382038302e36373635203139372e3634312038302e35323039203139372e3634312038302e33333634433139372e3634312038302e31343633203139372e3630382037392e39383636203139372e3534322037392e38353639433139372e3437372037392e37323733203139372e3338372037392e363235203139372e3237332037392e3535433139372e3135382037392e343735203139372e3032332037392e34323137203139362e3836362037392e33393031433139362e3730392037392e33353835203139362e3533392037392e33343235203139362e3335372037392e333432355a4d3137382e3831342037392e33343235483137372e3839365638312e323631483137382e383134433137392e3231382038312e323631203137392e3533372038312e31383435203137392e37372038312e303332433138302e3030332038302e38373934203138302e3131392038302e36333032203138302e3131392038302e32383433433138302e3131392037392e39333239203138302e3030312037392e36383831203137392e3736352037392e35343938433137392e35332037392e34313137203137392e3231332037392e33343235203137382e3831342037392e333432355a222066696c6c3d227768697465222f3e0a3c636972636c652063783d22323535222063793d223138392220723d223530222066696c6c3d227768697465222f3e0a3c7061746820643d224d3235332e393534203137342e3636354c3235352e333533203137372e323039433235352e363333203137372e373335203235352e363333203137382e333738203235352e333533203137382e3930344c3234372e303135203139342e30324c3235302e3936203230312e313534433235312e353736203230322e323635203235322e373233203230322e393637203235332e393534203230322e393637433235352e313835203230322e393637203235362e333332203230322e323635203235362e393438203230312e3135344c3236302e383933203139342e30324c3235392e383538203139322e30394c3235352e333831203230302e313839433235352e313031203230302e373135203235342e353432203230312e303337203235332e393832203230312e303337433235332e333934203230312e303337203235322e383633203230302e373135203235322e353833203230302e3138394c3234392e313431203139342e30324c3235362e383932203137392e3938364c3235382e323931203138322e3533433235382e353731203138332e303536203235382e353731203138332e363939203235382e323931203138342e3232364c3235322e383931203139342e30324c3235332e393534203139352e39354c3235392e3833203138352e3330374c3236332e363931203139322e323935433236342e323739203139332e333737203236342e323739203139342e363933203236332e363931203139352e3737344c3235392e373734203230322e383739433235392e313837203230332e393631203235372e333132203230362e333837203235332e393534203230362e333837433235302e353936203230362e333837203234382e3735203230332e393631203234382e313334203230322e3837394c3234342e323137203139352e373734433234332e363239203139342e363933203234332e363239203139332e333737203234342e323137203139322e3239354c3235332e393534203137342e3636355a222066696c6c3d2223454435313533222f3e0a3c636972636c652063783d223331312e393737222063793d2235302220723d223530222066696c6c3d2223464637413539222f3e0a3c7061746820643d224d3331352e3436312034342e323734395633392e39393331433331362e3030372033392e37323838203331362e34372033392e33303932203331362e3739352033382e37383331433331372e31322033382e323537203331372e3239342033372e36343631203331372e3239372033372e303231365633362e39323137433331372e3239352033362e30343839203331362e3935392033352e32313235203331362e3336332033342e35393534433331352e3736372033332e39373832203331342e3935392033332e36333035203331342e3131352033332e36323831483331342e303139433331332e3137362033332e36333035203331322e3336382033332e39373832203331312e3737322033342e35393534433331312e3137352033352e32313235203331302e38342033362e30343839203331302e3833372033362e393231375633372e30323136433331302e38342033372e36343631203331312e3031342033382e323537203331312e3333392033382e37383331433331312e3636342033392e33303932203331322e3132372033392e37323838203331322e3637342033392e393933315634342e32373439433331312e3130322034342e35323337203330392e3632322034352e31393738203330382e3338332034362e323239324c3239372e3032352033372e30383136433239372e3130362033362e37373938203239372e3134392033362e34363836203239372e3135342033362e31353535433239372e3135352033352e34323036203239362e3934352033342e373032203239362e3535312033342e30393035433239362e3135372033332e343739203239352e3539372033332e30303231203239342e3934322033322e37323031433239342e3238362033322e343338203239332e3536352033322e33363336203239322e3836382033322e35303631433239322e3137322033322e36343836203239312e3533322033332e30303137203239312e3032392033332e35323036433239302e3532372033342e30333936203239302e3138342033342e37303133203239302e3034352033352e34323138433238392e3930362033362e31343234203238392e3937362033362e38383935203239302e3234372033372e35363838433239302e3531382033382e323438203239302e3937372033382e38323839203239312e3536372033392e32333739433239322e3135372033392e36343638203239322e38352033392e38363536203239332e35362033392e38363635433239342e3138342033392e38363431203239342e3739362033392e36393138203239352e3333342033392e333636384c3330362e3530312034382e33363537433330352e3439362034392e39333635203330342e3937312035312e37383438203330342e3939362035332e36363931433330352e3032312035352e35353335203330352e3539342035372e33383633203330362e3634312035382e3932384c3330332e3234322036322e34343538433330322e39372036322e33353539203330322e3638362036322e333038203330322e3339392036322e33303337433330312e3831362036322e33303337203330312e3234352036322e34383238203330302e37362036322e38313833433330302e3237352036332e31353339203239392e3839372036332e36333038203239392e3637342036342e31383838433239392e3435312036342e37343638203239392e3339322036352e33363038203239392e3530362036352e39353331433239392e36322036362e35343535203239392e3930312036372e30383936203330302e3331332036372e35313636433330302e3732362036372e39343337203330312e3235322036382e32333435203330312e3832342036382e33353234433330322e3339362036382e34373032203330322e3938392036382e34303937203330332e3532382036382e31373836433330342e3036372036372e39343735203330342e3532382036372e35353631203330342e3835322036372e30353339433330352e3137362036362e35353137203330352e3334392036352e39363133203330352e3334392036352e33353734433330352e3334352036352e303631203330352e3239392036342e37363639203330352e3231322036342e343834364c3330382e3537342036312e30303435433330392e3637312036312e38373232203331302e3934362036322e34363839203331322e332036322e373439433331332e3635342036332e30323931203331352e3035322036322e39383532203331362e3338372036322e36323037433331372e3732332036322e32353632203331382e39362036312e35383037203332302e3030342036302e36343538433332312e3034392035392e37313039203332312e3837342035382e35343132203332322e3431352035372e32323632433332322e3935362035352e39313131203332332e322035342e34383534203332332e3132382035332e30353739433332332e3035362035312e36333033203332322e36372035302e32333837203332312e3939392034382e39383933433332312e3332382034372e37333938203332302e33392034362e36363536203331392e3235372034352e38343835433331382e3132342034352e30333135203331362e3832352034342e34393332203331352e3436312034342e323734395634342e323734395a4d3331342e3036382035382e33353935433331332e3134382035382e33353935203331322e3234392035382e30373731203331312e3438342035372e353438433331302e3731392035372e303139203331302e3132332035362e323637203330392e3737312035352e33383732433330392e3431392035342e35303734203330392e3332372035332e35333933203330392e3530362035322e36303534433330392e3638362035312e36373134203331302e3132392035302e38313335203331302e3737392035302e31343031433331312e34332034392e34363637203331322e3235392034392e30303832203331332e3136312034382e38323234433331342e3036332034382e36333636203331342e3939382034382e373332203331352e3834382034392e30393634433331362e3639382034392e34363038203331372e3432352035302e30373739203331372e3933362035302e38363937433331382e3434372035312e36363135203331382e37322035322e35393234203331382e37322035332e35343437433331382e37322035342e38323136203331382e3232392035362e30343633203331372e3335372035362e39343933433331362e3438352035372e38353232203331352e3330322035382e33353935203331342e3036382035382e33353935222066696c6c3d227768697465222f3e0a3c2f673e0a3c646566733e0a3c636c6970506174682069643d22636c6970305f3132365f38323738223e0a3c726563742077696474683d2233363322206865696768743d22323534222066696c6c3d227768697465222f3e0a3c2f636c6970506174683e0a3c2f646566733e0a3c2f7376673e0a'
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_test_1768408494')
  AND section_order = 44;


UPDATE sections
SET section_image_data = E'\\x3c7376672077696474683d22333222206865696768743d223332222076696577426f783d22302030203332203332222066696c6c3d226e6f6e652220786d6c6e733d22687474703a2f2f7777772e77332e6f72672f323030302f737667223e0a3c636972636c652063783d223136222063793d2231362220723d223136222066696c6c3d2223463546304541222f3e0a3c7061746820643d224d31342e393631362031312e393631394831315631304832315631312e393631394831372e303338355632332e333333334831342e393631365631312e393631395a222066696c6c3d22626c61636b222f3e0a3c2f7376673e0a'
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_test_1768408494')
  AND section_order = 46;
