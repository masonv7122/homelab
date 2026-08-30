#!/bin/bash
BACKUP_DIR="/mnt/immich-backup"
SOURCE_DIR="/mnt/data/immich"
LOG_FILE="/var/log/immich-backup.log"

echo "$(date): Backup started" >> "$LOG_FILE"
rsync -av "$SOURCE_DIR/" "$BACKUP_DIR/immich/" >> "$LOG_FILE" 2>&1
echo "$(date): Backup finished, unmounting" >> "$LOG_FILE"
umount "$BACKUP_DIR"
