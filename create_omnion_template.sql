-- Create OMNiON Website Template
-- This creates a complete OMNiON.us style template with all sections

-- First, delete existing omnion template if exists
DELETE FROM sections WHERE template_id = (SELECT id FROM templates WHERE template_name = 'OMNiON_Website');
DELETE FROM templates WHERE template_name = 'OMNiON_Website';

-- Insert template
INSERT INTO templates (template_name, description, project_name)
VALUES ('OMNiON_Website', 'OMNiON.us website template with navbar, cards, and content sections', 'OMNiON');

-- Get template ID
DO $$
DECLARE
    tid INTEGER;
BEGIN
    SELECT id INTO tid FROM templates WHERE template_name = 'OMNiON_Website';

    -- Section 1: Navbar Connector
    INSERT INTO sections (template_id, section_order, type, name, height, y_position, x_position, width, z_index,
        bg_color, navbar_items_json, navbar_bg_color, navbar_hover_color, navbar_text_color, navbar_height, navbar_spacing)
    VALUES (tid, 0, 56, 'Navbar', 50, 0, 0, 1400, 10,
        '1.0,1.0,1.0,1.0',
        '[{"label":"HOME","children":[],"actionType":0,"actionTarget":""},{"label":"PREMEDIA","children":["About","Values","Outsourcing","How We Work"],"actionType":0,"actionTarget":""},{"label":"SERVICES","children":["Creative","Catalog","Technology","Prepress"],"actionType":0,"actionTarget":""},{"label":"PACKAGING","children":[],"actionType":0,"actionTarget":""},{"label":"IMAGING","children":[],"actionType":0,"actionTarget":""},{"label":"MOBILE-APPS","children":[],"actionType":0,"actionTarget":""},{"label":"NEWS","children":[],"actionType":0,"actionTarget":""},{"label":"CONTACT US","children":[],"actionType":0,"actionTarget":""}]',
        '1.0,1.0,1.0,1.0', '0.95,0.95,0.95,1.0', '0.91,0.4,0.1,1.0', 50, 25);

    -- Section 2: Card Connector (Service Categories)
    INSERT INTO sections (template_id, section_order, type, name, height, y_position, x_position, width, z_index,
        bg_color, connector_cards_json, connector_cards_per_row, connector_card_spacing)
    VALUES (tid, 1, 53, 'Service Cards', 120, 50, 0, 1400, 5,
        '0.95,0.95,0.95,1.0',
        '[{"heading":"PACKAGING","description":"","headingColor":"0.91,0.4,0.1,1.0","descriptionColor":"0.3,0.3,0.3,1.0","cardColor":"1.0,1.0,1.0,1.0","cardWidth":130,"cardHeight":100,"headingSize":0.8},{"heading":"IMAGING","description":"","headingColor":"0.91,0.4,0.1,1.0","descriptionColor":"0.3,0.3,0.3,1.0","cardColor":"1.0,1.0,1.0,1.0","cardWidth":130,"cardHeight":100,"headingSize":0.8},{"heading":"PREPRESS","description":"","headingColor":"0.91,0.4,0.1,1.0","descriptionColor":"0.3,0.3,0.3,1.0","cardColor":"1.0,1.0,1.0,1.0","cardWidth":130,"cardHeight":100,"headingSize":0.8},{"heading":"PUBLISHING","description":"","headingColor":"0.91,0.4,0.1,1.0","descriptionColor":"0.3,0.3,0.3,1.0","cardColor":"1.0,1.0,1.0,1.0","cardWidth":130,"cardHeight":100,"headingSize":0.8},{"heading":"NEW MEDIA","description":"","headingColor":"0.91,0.4,0.1,1.0","descriptionColor":"0.3,0.3,0.3,1.0","cardColor":"1.0,1.0,1.0,1.0","cardWidth":130,"cardHeight":100,"headingSize":0.8},{"heading":"CREATIVE","description":"","headingColor":"0.91,0.4,0.1,1.0","descriptionColor":"0.3,0.3,0.3,1.0","cardColor":"1.0,1.0,1.0,1.0","cardWidth":130,"cardHeight":100,"headingSize":0.8},{"heading":"CATALOG","description":"","headingColor":"0.91,0.4,0.1,1.0","descriptionColor":"0.3,0.3,0.3,1.0","cardColor":"1.0,1.0,1.0,1.0","cardWidth":130,"cardHeight":100,"headingSize":0.8},{"heading":"TECHNOLOGY","description":"","headingColor":"0.91,0.4,0.1,1.0","descriptionColor":"0.3,0.3,0.3,1.0","cardColor":"1.0,1.0,1.0,1.0","cardWidth":130,"cardHeight":100,"headingSize":0.8},{"heading":"ADVERTISING","description":"","headingColor":"0.91,0.4,0.1,1.0","descriptionColor":"0.3,0.3,0.3,1.0","cardColor":"1.0,1.0,1.0,1.0","cardWidth":130,"cardHeight":100,"headingSize":0.8},{"heading":"ANIMATION","description":"","headingColor":"0.91,0.4,0.1,1.0","descriptionColor":"0.3,0.3,0.3,1.0","cardColor":"1.0,1.0,1.0,1.0","cardWidth":130,"cardHeight":100,"headingSize":0.8}]',
        10, 10);

    -- Section 3: Bar Connector (WHO ARE WE?)
    INSERT INTO sections (template_id, section_order, type, name, height, y_position, x_position, width, z_index,
        bg_color, bar_items_json)
    VALUES (tid, 2, 51, 'Who Are We Bar', 50, 170, 0, 1400, 5,
        '0.91,0.4,0.1,1.0',
        '[{"heading":"WHO ARE WE?","barColor":"0.91,0.4,0.1,1.0","barWidth":1400,"barHeight":50,"headingColor":"1.0,1.0,1.0,1.0","headingSize":1.3,"headingBoldness":1.5,"paddingLeft":20}]');

    -- Section 4: Text Connector (Main Content)
    INSERT INTO sections (template_id, section_order, type, name, height, y_position, x_position, width, z_index,
        bg_color, text_blocks_json, text_content_width, text_padding)
    VALUES (tid, 3, 50, 'Main Text Content', 200, 220, 0, 900, 5,
        '1.0,1.0,1.0,1.0',
        '[{"segments":[{"text":"At OMNiON, we work with clients and partners around the world and across diverse markets to provide ","isBold":false},{"text":"premedia services","isBold":true},{"text":", ","isBold":false},{"text":"mobile publishing services","isBold":true},{"text":" & ","isBold":false},{"text":"creative production solutions","isBold":true},{"text":" ranging from imaging, packaging artwork, prepress, design, animation & programming services to more complex projects that require design support, and fully integrated app publishing workflows and cross-media technology.","isBold":false}],"fontSize":14,"textColor":"0.3,0.3,0.3,1.0","boldColor":"0.1,0.1,0.1,1.0","lineSpacing":1.6},{"segments":[{"text":"OMNiON Founders - ","isBold":false},{"text":"M. C. ABRAHAM","isBold":true},{"text":", based in Bangalore, India is considered Indias pioneer of global media solutions, having started doing this in 1974 and his son - ","isBold":false},{"text":"MAT ABRAHAM","isBold":true},{"text":", based in New Jersey, USA has led premedia technology at Quad/Graphics, Inc., USA for almost 20 years.","isBold":false}],"fontSize":14,"textColor":"0.3,0.3,0.3,1.0","boldColor":"0.1,0.1,0.1,1.0","lineSpacing":1.6}]',
        850, 20);

    -- Section 5: Search Connector (Right Sidebar)
    INSERT INTO sections (template_id, section_order, type, name, height, y_position, x_position, width, z_index,
        bg_color, search_placeholder, search_button_text, search_input_bg, search_input_border, search_input_text,
        search_button_bg, search_button_text_color, search_input_width, search_input_height, search_button_width)
    VALUES (tid, 4, 57, 'Search Bar', 60, 170, 950, 400, 6,
        '1.0,1.0,1.0,1.0',
        'Search...', 'Search',
        '1.0,1.0,1.0,1.0', '0.8,0.8,0.8,1.0', '0.3,0.3,0.3,1.0',
        '0.91,0.4,0.1,1.0', '1.0,1.0,1.0,1.0',
        280, 40, 80);

    -- Section 6: Text Connector (Right Sidebar Content)
    INSERT INTO sections (template_id, section_order, type, name, height, y_position, x_position, width, z_index,
        bg_color, text_blocks_json, text_content_width, text_padding)
    VALUES (tid, 5, 50, 'Sidebar Text', 400, 240, 950, 400, 5,
        '1.0,1.0,1.0,1.0',
        '[{"segments":[{"text":"Our ","isBold":false},{"text":"unique innovations","isBold":true},{"text":" & ","isBold":false},{"text":"turn-key solutions","isBold":true},{"text":" based on our extensive experience & depth of knowledge will help you succeed.","isBold":false}],"fontSize":13,"textColor":"0.3,0.3,0.3,1.0","boldColor":"0.1,0.1,0.1,1.0","lineSpacing":1.5},{"segments":[{"text":"Our founder, ","isBold":false},{"text":"M. C. Abraham","isBold":true},{"text":", is Indias most experienced, successful & widely regarded publishing & media services outsourcing expert having pioneered the industry back in 1974.","isBold":false}],"fontSize":13,"textColor":"0.3,0.3,0.3,1.0","boldColor":"0.1,0.1,0.1,1.0","lineSpacing":1.5},{"segments":[{"text":"Reduce Time to Market / Save Time","isBold":true}],"fontSize":13,"textColor":"0.1,0.1,0.1,1.0","boldColor":"0.1,0.1,0.1,1.0","lineSpacing":1.8},{"segments":[{"text":"We are Staffed for 24/7 Production and Enjoy A 10+ Hour Time Zone Advantage","isBold":false}],"fontSize":12,"textColor":"0.4,0.4,0.4,1.0","boldColor":"0.1,0.1,0.1,1.0","lineSpacing":1.5},{"segments":[{"text":"Expand Range of Services","isBold":true}],"fontSize":13,"textColor":"0.1,0.1,0.1,1.0","boldColor":"0.1,0.1,0.1,1.0","lineSpacing":1.8},{"segments":[{"text":"OMNiON blends a wide range of professional services under one roof.","isBold":false}],"fontSize":12,"textColor":"0.4,0.4,0.4,1.0","boldColor":"0.1,0.1,0.1,1.0","lineSpacing":1.5}]',
        380, 15);

    -- Section 7: Footer Connector
    INSERT INTO sections (template_id, section_order, type, name, height, y_position, x_position, width, z_index,
        bg_color, footer_columns_json, footer_heading_color, footer_subheading_color, footer_column_width, footer_item_spacing)
    VALUES (tid, 6, 52, 'Footer', 200, 700, 0, 1400, 5,
        '0.15,0.15,0.15,1.0',
        '[{"heading":"SERVICES","items":["Premedia","Creative","Packaging","Technology"]},{"heading":"COMPANY","items":["About Us","Our Team","Careers","Contact"]},{"heading":"RESOURCES","items":["Blog","Case Studies","Downloads","FAQ"]},{"heading":"CONTACT","items":["info@omnion.us","+1 (555) 123-4567","Bangalore, India","New Jersey, USA"]}]',
        '1.0,1.0,1.0,1.0', '0.7,0.7,0.7,1.0', 300, 10);

END $$;

SELECT 'OMNiON_Website template created successfully!' AS status;
SELECT template_name, id FROM templates WHERE template_name = 'OMNiON_Website';
