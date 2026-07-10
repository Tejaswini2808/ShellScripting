#!/bin/bash

#############################################################
# Description : Creates compressed backups and removes old backups based on retention policy
# Author      : Tejaswini Lingala
#############################################################

# Source directory
SOURCE="/home/ubuntu/shellscripts"

# Backup directory
BACKUP_DIR="/home/ubuntu/backups"

# Number of backups to retain
RETENTION=7

# Current timestamp
DATE=$(date +"%Y-%m-%d_%H-%M-%S")

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"
echo "========================================="
echo "Starting Backup..."
echo "========================================="

# Verify source directory exists
if [ ! -d "$SOURCE" ]; then
   echo "ERROR: Source directory does not exist."
   exit 1
fi

# Create compressed backup
tar -czf "$BACKUP_DIR/backup_$DATE.tar.gz" "$SOURCE"
if [ $? -eq 0 ]; then
   echo "Backup created successfully:"
   echo "$BACKUP_DIR/backup_$DATE.tar.gz"
else
   echo "Backup failed."
   exit 1
fi

echo
echo "Cleaning old backups..."

# Count total backups
TOTAL_BACKUPS=$(ls -1 "$BACKUP_DIR"/backup_*.tar.gz 2>/dev/null | wc -l)
if [ "$TOTAL_BACKUPS" -gt "$RETENTION" ]; then
   REMOVE_COUNT=$((TOTAL_BACKUPS - RETENTION))
   ls -1tr "$BACKUP_DIR"/backup_*.tar.gz | head -n "$REMOVE_COUNT" | while read FILE
   do
       echo "Deleting $FILE"
       rm -f "$FILE"
   done
else
   echo "No old backups to remove."
fi

echo
echo "========================================="
echo "Backup Rotation Completed Successfully"
echo "========================================="
