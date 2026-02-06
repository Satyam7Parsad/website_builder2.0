#!/bin/bash
# PostgreSQL Incremental Backup Script
# Backs up website_builder database to remote server every hour

BACKUP_DIR="/tmp/pg_backups"
REMOTE_HOST="root@10.20.14.151"
REMOTE_PATH="/var/BACKUP1/Satyam_201/postgrebk"
DB_NAME="website_builder"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="website_builder_incremental_${TIMESTAMP}.sql"
LOG_FILE="/Users/imaging/Desktop/Website-Builder-v2.0/scripts/backup.log"

# Create local backup directory if not exists
mkdir -p "$BACKUP_DIR"

# Log start
echo "[$(date)] Starting backup..." >> "$LOG_FILE"

# Create incremental backup (dump only data changes since we have schema)
pg_dump -h localhost -d "$DB_NAME" > "$BACKUP_DIR/$BACKUP_FILE"

if [ $? -eq 0 ]; then
    echo "[$(date)] Local backup created: $BACKUP_FILE" >> "$LOG_FILE"

    # Transfer to remote server
    scp "$BACKUP_DIR/$BACKUP_FILE" "$REMOTE_HOST:$REMOTE_PATH/"

    if [ $? -eq 0 ]; then
        echo "[$(date)] Backup transferred to remote server successfully" >> "$LOG_FILE"

        # Keep only last 24 local backups (1 day)
        cd "$BACKUP_DIR"
        ls -t website_builder_incremental_*.sql | tail -n +25 | xargs -r rm

        echo "[$(date)] Backup completed successfully" >> "$LOG_FILE"
    else
        echo "[$(date)] ERROR: Failed to transfer backup to remote server" >> "$LOG_FILE"
    fi
else
    echo "[$(date)] ERROR: Failed to create local backup" >> "$LOG_FILE"
fi
