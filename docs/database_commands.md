# Database Access Commands - Quick Reference (PostgreSQL)

## Login to Database
```bash
# Login to website_builder database
psql -d website_builder

# Login with specific user
psql -U username -d website_builder

# Login with password prompt
psql -U username -d website_builder -W
```

---

## Basic Commands

### Show All Databases
```sql
\l
-- or
\list
```

### Connect to Database
```sql
\c website_builder
-- or
\connect website_builder
```

### Show All Tables
```sql
\dt
-- or show with more details
\dt+
```

### Show Table Structure
```sql
\d templates
\d sections
-- or with more details
\d+ templates
```

### List All Schemas
```sql
\dn
```

### Show Current Database
```sql
SELECT current_database();
```

---

## View Data Commands

### View All Templates
```sql
SELECT * FROM templates;
```

### View Specific Template
```sql
SELECT * FROM templates WHERE template_name = 'My Portfolio';
```

### View Templates with Section Count
```sql
SELECT
    t.id,
    t.template_name,
    t.description,
    COUNT(s.id) as total_sections,
    t.created_date
FROM templates t
LEFT JOIN sections s ON t.id = s.template_id
GROUP BY t.id, t.template_name, t.description, t.created_date;
```

### View All Sections for a Template
```sql
SELECT
    section_order,
    name,
    type,
    title,
    height
FROM sections
WHERE template_id = 1
ORDER BY section_order;
```

### View Sections with Image Info
```sql
SELECT
    section_order,
    name,
    background_image,
    CASE
        WHEN background_image_data IS NOT NULL
        THEN ROUND(OCTET_LENGTH(background_image_data)::numeric / 1024, 2) || ' KB'
        ELSE 'No image'
    END as bg_image_size,
    section_image,
    CASE
        WHEN section_image_data IS NOT NULL
        THEN ROUND(OCTET_LENGTH(section_image_data)::numeric / 1024, 2) || ' KB'
        ELSE 'No image'
    END as sec_image_size
FROM sections
WHERE template_id = 1
ORDER BY section_order;
```

### Count Total Images in Database
```sql
SELECT
    COUNT(*) as total_sections,
    SUM(CASE WHEN background_image_data IS NOT NULL THEN 1 ELSE 0 END) as bg_images,
    SUM(CASE WHEN section_image_data IS NOT NULL THEN 1 ELSE 0 END) as section_images,
    ROUND(SUM(OCTET_LENGTH(background_image_data))::numeric / 1024 / 1024, 2) || ' MB' as total_bg_size,
    ROUND(SUM(OCTET_LENGTH(section_image_data))::numeric / 1024 / 1024, 2) || ' MB' as total_sec_size
FROM sections;
```

---

## Search Commands

### Find Templates by Name
```sql
SELECT * FROM templates WHERE template_name LIKE '%portfolio%';
-- PostgreSQL also supports ILIKE for case-insensitive search
SELECT * FROM templates WHERE template_name ILIKE '%portfolio%';
```

### Find Templates Created Today
```sql
SELECT * FROM templates WHERE created_date::date = CURRENT_DATE;
```

### Find Templates with Images
```sql
SELECT DISTINCT t.*
FROM templates t
JOIN sections s ON t.id = s.template_id
WHERE s.background_image_data IS NOT NULL
   OR s.section_image_data IS NOT NULL;
```

### Find Sections by Type
```sql
-- Type 1=Navigation, 2=About, 3=Services, etc.
SELECT
    t.template_name,
    s.name,
    s.type
FROM sections s
JOIN templates t ON s.template_id = t.id
WHERE s.type = 1;  -- Navigation sections
```

---

## Management Commands

### Delete a Template (and all its sections)
```sql
-- Be careful! This deletes everything
DELETE FROM templates WHERE template_name = 'Old Template';
```

### Delete Old Templates (older than 30 days)
```sql
DELETE FROM templates WHERE created_date < CURRENT_DATE - INTERVAL '30 days';
```

### Update Template Description
```sql
UPDATE templates
SET description = 'New description here'
WHERE template_name = 'My Portfolio';
```

### Rename Template
```sql
UPDATE templates
SET template_name = 'New Name'
WHERE template_name = 'Old Name';
```

---

## Database Statistics

### Database Size
```sql
SELECT
    schemaname || '.' || tablename AS "Table",
    pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) AS "Size"
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC;
```

### Total Storage Used by Images
```sql
SELECT
    ROUND(SUM(OCTET_LENGTH(background_image_data))::numeric / 1024 / 1024, 2) || ' MB' as "Background Images Size",
    ROUND(SUM(OCTET_LENGTH(section_image_data))::numeric / 1024 / 1024, 2) || ' MB' as "Section Images Size",
    ROUND((SUM(OCTET_LENGTH(background_image_data)) + SUM(OCTET_LENGTH(section_image_data)))::numeric / 1024 / 1024, 2) || ' MB' as "Total Images Size"
FROM sections;
```

### Row Counts
```sql
SELECT
    'templates' as table_name,
    COUNT(*) as row_count
FROM templates
UNION ALL
SELECT
    'sections' as table_name,
    COUNT(*) as row_count
FROM sections;
```

### Get Table Information
```sql
SELECT
    tablename,
    pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) as size,
    n_live_tup as row_count
FROM pg_stat_user_tables
WHERE schemaname = 'public'
ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC;
```

---

## Export Commands (Terminal)

### Export Database to SQL File
```bash
pg_dump website_builder > website_builder_backup.sql
```

### Export Only Templates (no images)
```bash
pg_dump website_builder -t templates > templates_only.sql
```

### Export Specific Tables
```bash
pg_dump website_builder -t templates -t sections > tables_backup.sql
```

### Export with Custom Format (better compression)
```bash
pg_dump website_builder -Fc -f website_builder_backup.dump
```

### Import Database (from SQL file)
```bash
psql -d website_builder < website_builder_backup.sql
```

### Import from Custom Format
```bash
pg_restore -d website_builder website_builder_backup.dump
```

### Export to CSV
```bash
psql -d website_builder -c "COPY templates TO STDOUT WITH CSV HEADER" > templates.csv
```

### Import from CSV
```bash
psql -d website_builder -c "COPY templates FROM '/path/to/templates.csv' WITH CSV HEADER"
```

---

## Exit PostgreSQL
```sql
\q
-- or press Ctrl+D
```

---

## One-Liner Commands (Without Logging In)

### View All Templates
```bash
psql -d website_builder -c "SELECT * FROM templates;"
```

### Count Templates
```bash
psql -d website_builder -c "SELECT COUNT(*) as total FROM templates;"
```

### View Latest Template
```bash
psql -d website_builder -c "SELECT * FROM templates ORDER BY created_date DESC LIMIT 1;"
```

### Export to CSV
```bash
psql -d website_builder -c "COPY (SELECT * FROM templates) TO STDOUT WITH CSV HEADER" > templates.csv
```

### Pretty Table Output
```bash
psql -d website_builder -c "SELECT * FROM templates;"
```

### Get Specific Value (tuples only, no headers)
```bash
psql -d website_builder -t -c "SELECT COUNT(*) FROM templates;"
```

---

## Useful PostgreSQL Meta-Commands

### Get Help
```sql
\?              -- List all meta-commands
\h              -- SQL command help
\h SELECT       -- Help for specific SQL command
```

### Describe Objects
```sql
\d              -- List all tables, views, and sequences
\dt             -- List tables only
\dv             -- List views
\di             -- List indexes
\df             -- List functions
\du             -- List users/roles
```

### Schema Information
```sql
\dn             -- List schemas
\dn+            -- List schemas with details
```

### Connection Information
```sql
\conninfo       -- Display connection information
\c database     -- Switch database
```

### Display Settings
```sql
\x              -- Toggle expanded display (good for wide tables)
\timing         -- Toggle query execution timing
```

### Output Control
```sql
\o filename     -- Send output to file
\o              -- Send output back to stdout
```

---

## Useful Aliases (Add to ~/.bashrc or ~/.zshrc)

```bash
# Quick database access
alias dbweb="psql -d website_builder"

# View all templates
alias templates="psql -d website_builder -c 'SELECT * FROM templates;'"

# View latest template
alias latest="psql -d website_builder -c 'SELECT * FROM templates ORDER BY created_date DESC LIMIT 1;'"

# Database backup
alias backup-web="pg_dump website_builder > ~/backup_$(date +%Y%m%d).sql"

# Database size
alias dbsize="psql -d website_builder -c 'SELECT pg_size_pretty(pg_database_size(current_database()));'"
```

After adding aliases, run:
```bash
source ~/.bashrc  # or source ~/.zshrc
```

Then you can just type:
```bash
dbweb          # Opens database
templates      # Shows all templates
latest         # Shows latest template
backup-web     # Creates backup
dbsize         # Shows database size
```

---

## PostgreSQL-Specific Features

### JSON Support
```sql
-- If you store JSON data in future
SELECT jsonb_pretty(your_json_column) FROM your_table;
```

### Full-Text Search
```sql
-- Search in text columns
SELECT * FROM templates
WHERE to_tsvector('english', description) @@ to_tsquery('english', 'portfolio');
```

### Array Operations
```sql
-- If using arrays in future versions
SELECT * FROM table_name WHERE 'value' = ANY(array_column);
```

### Window Functions
```sql
-- Rank templates by creation date
SELECT
    template_name,
    created_date,
    ROW_NUMBER() OVER (ORDER BY created_date DESC) as rank
FROM templates;
```

### UPSERT (Insert or Update)
```sql
INSERT INTO templates (template_name, description)
VALUES ('My Template', 'Description here')
ON CONFLICT (template_name)
DO UPDATE SET description = EXCLUDED.description, updated_date = CURRENT_TIMESTAMP;
```

---

## Common PostgreSQL Functions

### String Functions
```sql
-- Concatenation
SELECT template_name || ' - ' || description FROM templates;

-- Uppercase/Lowercase
SELECT UPPER(template_name), LOWER(template_name) FROM templates;

-- String length
SELECT template_name, LENGTH(template_name) FROM templates;
```

### Date/Time Functions
```sql
-- Current timestamp
SELECT CURRENT_TIMESTAMP;

-- Format dates
SELECT to_char(created_date, 'YYYY-MM-DD HH24:MI:SS') FROM templates;

-- Date arithmetic
SELECT created_date + INTERVAL '7 days' FROM templates;
```

### Aggregate Functions
```sql
-- Count, sum, avg, min, max
SELECT COUNT(*), AVG(height), MIN(height), MAX(height) FROM sections;

-- Group by with aggregates
SELECT type, COUNT(*) as count FROM sections GROUP BY type;
```

---

## Performance Tips

### Create Indexes
```sql
-- Create index for faster searches
CREATE INDEX idx_template_name ON templates(template_name);
CREATE INDEX idx_section_type ON sections(type);
```

### Analyze Tables
```sql
-- Update statistics for query planner
ANALYZE templates;
ANALYZE sections;
```

### Explain Queries
```sql
-- See query execution plan
EXPLAIN SELECT * FROM templates WHERE template_name = 'Test';

-- See actual execution with costs
EXPLAIN ANALYZE SELECT * FROM templates WHERE template_name = 'Test';
```

### Vacuum Database
```bash
# Reclaim storage and update statistics
vacuumdb -d website_builder

# Full vacuum (more thorough, requires exclusive lock)
vacuumdb -d website_builder --full
```

---

## Troubleshooting

### Check Active Connections
```sql
SELECT * FROM pg_stat_activity WHERE datname = 'website_builder';
```

### Kill Stuck Query
```sql
-- Find the PID from pg_stat_activity, then:
SELECT pg_terminate_backend(pid);
```

### Check Database Size
```sql
SELECT pg_size_pretty(pg_database_size('website_builder'));
```

### Check Table Bloat
```sql
SELECT
    schemaname || '.' || tablename AS table,
    pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) AS size,
    n_dead_tup AS dead_tuples
FROM pg_stat_user_tables
WHERE schemaname = 'public'
ORDER BY n_dead_tup DESC;
```

---

## Differences from MySQL

| Feature | MySQL | PostgreSQL |
|---------|-------|------------|
| CLI Tool | `mysql` | `psql` |
| Show Databases | `SHOW DATABASES;` | `\l` |
| Use Database | `USE db;` | `\c db` |
| Show Tables | `SHOW TABLES;` | `\dt` |
| Describe Table | `DESCRIBE table;` | `\d table` |
| Auto Increment | `AUTO_INCREMENT` | `SERIAL` |
| String Length | `LENGTH()` | `OCTET_LENGTH()` for bytes, `LENGTH()` for chars |
| Upsert | `ON DUPLICATE KEY UPDATE` | `ON CONFLICT ... DO UPDATE` |
| Dump Tool | `mysqldump` | `pg_dump` |
| Case Sensitivity | Case-insensitive by default | Case-sensitive (use `ILIKE` for insensitive) |
| Exit | `EXIT;` or `QUIT;` | `\q` |

---

## Quick Reference Card

```
┌────────────────────────────────────────┐
│      POSTGRESQL QUICK REFERENCE        │
├────────────────────────────────────────┤
│ CONNECT                                 │
│  psql -d website_builder               │
│                                         │
│ META-COMMANDS                           │
│  \l          List databases             │
│  \c db       Connect to database        │
│  \dt         List tables                │
│  \d table    Describe table             │
│  \du         List users                 │
│  \q          Quit                       │
│  \?          Help                       │
│  \x          Toggle expanded display    │
│                                         │
│ BACKUP & RESTORE                        │
│  pg_dump db > file.sql                 │
│  psql -d db < file.sql                 │
│                                         │
│ ONE-LINERS                              │
│  psql -d db -c "SQL"                   │
│  psql -d db -t -c "SQL"  (no headers)  │
│                                         │
│ EXPORT CSV                              │
│  COPY table TO '/path/file.csv' CSV;   │
│  \copy table TO 'file.csv' CSV HEADER  │
└────────────────────────────────────────┘
```

---

**Version:** 4.0 (PostgreSQL Edition)
**Database:** PostgreSQL 14.19
**Last Updated:** January 8, 2026
