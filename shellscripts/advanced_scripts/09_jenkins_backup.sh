#!/bin/bash
#############################################################
# Script Name : jenkins_backup.sh
# Description : Backup Jenkins Home Directory
# Author      : Tejaswini Lingala
#############################################################
# Jenkins Home Directory
JENKINS_HOME="/var/lib/jenkins"
# Backup Directory
BACKUP_DIR="/home/ubuntu/jenkins_backups"
# Log File
LOG_FILE="$BACKUP_DIR/backup.log"
# Retention (Days)
RETENTION=7
# Timestamp
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
mkdir -p "$BACKUP_DIR"
echo "========================================="
echo "      JENKINS BACKUP SCRIPT"
echo "========================================="
# Check Jenkins Service
if ! systemctl is-active --quiet jenkins
then
   echo "Jenkins service is not running."
   echo "$(date) : Jenkins service not running." >> "$LOG_FILE"
   exit 1
fi
echo "Jenkins Service : Running"
# Verify Jenkins Home
if [ ! -d "$JENKINS_HOME" ]
then
   echo "Jenkins Home not found."
   exit 1
fi
echo
echo "Creating Backup..."
tar -czf "$BACKUP_DIR/jenkins_backup_$DATE.tar.gz" "$JENKINS_HOME"
if [ $? -eq 0 ]
then
   echo "Backup Created Successfully."
   echo "$(date) : Backup Successful." >> "$LOG_FILE"
else
   echo "Backup Failed."
   echo "$(date) : Backup Failed." >> "$LOG_FILE"
   exit 1
fi
echo
echo "Removing Old Backups..."
find "$BACKUP_DIR" -name "*.tar.gz" -mtime +$RETENTION -exec rm -f {} \;
echo "Old Backups Deleted."
echo
echo "Available Backups"
ls -lh "$BACKUP_DIR"
echo
echo "========================================="
echo "Backup Completed Successfully"
echo "========================================="
