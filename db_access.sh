#!/bin/bash

# Website Builder Database Access Tool
# Quick access to your templates database

DB="website_builder"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

show_menu() {
    echo ""
    echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║  Website Builder - Database Manager   ║${NC}"
    echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
    echo ""
    echo "1. View All Templates"
    echo "2. View Template Details"
    echo "3. View All Sections"
    echo "4. Database Statistics"
    echo "5. Image Storage Info"
    echo "6. Open PostgreSQL Console"
    echo "7. Backup Database"
    echo "8. Exit"
    echo ""
    echo -n "Choose option [1-8]: "
}

view_templates() {
    echo -e "\n${GREEN}📋 All Templates:${NC}\n"
    psql -d $DB -c "
    SELECT
        id,
        template_name AS \"Template Name\",
        description AS \"Description\",
        created_date AS \"Created\"
    FROM templates
    ORDER BY created_date DESC;
    "
}

view_template_details() {
    echo -n "Enter template ID: "
    read template_id

    echo -e "\n${GREEN}📄 Template Details:${NC}\n"
    psql -d $DB -c "
    SELECT
        t.template_name AS \"Template\",
        t.description AS \"Description\",
        COUNT(s.id) AS \"Sections\",
        t.created_date AS \"Created\"
    FROM templates t
    LEFT JOIN sections s ON t.id = s.template_id
    WHERE t.id = $template_id
    GROUP BY t.id, t.template_name, t.description, t.created_date;
    "

    echo -e "\n${GREEN}📑 Sections:${NC}\n"
    psql -d $DB -c "
    SELECT
        section_order AS \"Order\",
        name AS \"Name\",
        type AS \"Type\",
        title AS \"Title\",
        height AS \"Height\"
    FROM sections
    WHERE template_id = $template_id
    ORDER BY section_order;
    "
}

view_sections() {
    echo -e "\n${GREEN}🔲 All Sections:${NC}\n"
    psql -d $DB -c "
    SELECT
        t.template_name AS \"Template\",
        s.section_order AS \"Order\",
        s.name AS \"Section Name\",
        s.title AS \"Title\"
    FROM sections s
    JOIN templates t ON s.template_id = t.id
    ORDER BY t.id, s.section_order;
    "
}

database_stats() {
    echo -e "\n${GREEN}📊 Database Statistics:${NC}\n"

    echo "Templates:"
    psql -d $DB -t -c "SELECT COUNT(*) AS Total FROM templates;"

    echo -e "\nSections:"
    psql -d $DB -t -c "SELECT COUNT(*) AS Total FROM sections;"

    echo -e "\n${GREEN}💾 Storage Size:${NC}\n"
    psql -d $DB -c "
    SELECT
        schemaname || '.' || tablename AS \"Table\",
        n_live_tup AS \"Rows\",
        ROUND(pg_total_relation_size(schemaname||'.'||tablename)::numeric / 1024 / 1024, 2) AS \"Size (MB)\"
    FROM pg_stat_user_tables
    WHERE schemaname = 'public'
    ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC
    LIMIT 10;
    "
}

image_info() {
    echo -e "\n${GREEN}🖼️  Image Storage Info:${NC}\n"
    psql -d $DB -c "
    SELECT
        COUNT(*) AS \"Total Sections\",
        SUM(CASE WHEN background_image_data IS NOT NULL THEN 1 ELSE 0 END) AS \"BG Images\",
        SUM(CASE WHEN section_image_data IS NOT NULL THEN 1 ELSE 0 END) AS \"Section Images\",
        ROUND(SUM(OCTET_LENGTH(background_image_data))::numeric/1024/1024, 2) || ' MB' AS \"BG Size\",
        ROUND(SUM(OCTET_LENGTH(section_image_data))::numeric/1024/1024, 2) || ' MB' AS \"Sec Size\"
    FROM sections;
    "

    echo -e "\n${GREEN}Sections with Images:${NC}\n"
    psql -d $DB -c "
    SELECT
        t.template_name AS \"Template\",
        s.name AS \"Section\",
        CASE
            WHEN s.background_image_data IS NOT NULL
            THEN ROUND(OCTET_LENGTH(s.background_image_data)::numeric/1024, 2) || ' KB'
            ELSE '-'
        END AS \"BG Image\",
        CASE
            WHEN s.section_image_data IS NOT NULL
            THEN ROUND(OCTET_LENGTH(s.section_image_data)::numeric/1024, 2) || ' KB'
            ELSE '-'
        END AS \"Sec Image\"
    FROM sections s
    JOIN templates t ON s.template_id = t.id
    WHERE s.background_image_data IS NOT NULL
       OR s.section_image_data IS NOT NULL;
    "
}

backup_database() {
    BACKUP_FILE="backup_$(date +%Y%m%d_%H%M%S).sql"
    echo -e "\n${YELLOW}Creating backup...${NC}"
    pg_dump $DB > "$BACKUP_FILE"

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Backup created: $BACKUP_FILE${NC}"
        ls -lh "$BACKUP_FILE"
    else
        echo -e "${RED}❌ Backup failed!${NC}"
    fi
}

open_console() {
    echo -e "\n${GREEN}Opening PostgreSQL console...${NC}"
    echo -e "${YELLOW}Type '\\q' or press Ctrl+D to return${NC}\n"
    psql -d $DB
}

# Main loop
while true; do
    show_menu
    read choice

    case $choice in
        1) view_templates ;;
        2) view_template_details ;;
        3) view_sections ;;
        4) database_stats ;;
        5) image_info ;;
        6) open_console ;;
        7) backup_database ;;
        8)
            echo -e "\n${GREEN}Goodbye!${NC}\n"
            exit 0
            ;;
        *)
            echo -e "\n${RED}Invalid option!${NC}"
            ;;
    esac

    echo ""
    echo -n "Press Enter to continue..."
    read
done
