#!/bin/bash

# This is for backup of shellscripts directory

SOURCE=/home/ubuntu/shellscripts
BACKUP=/home/ubuntu/backup

tar -czPf "$BACKUP/backup_$(date +%F).tar.gz" "$SOURCE"

echo "Backup Completed"
