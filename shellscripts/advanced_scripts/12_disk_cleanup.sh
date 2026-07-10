#!/bin/bash
LOG_DIR="/var/log"
TEMP_DIR="/tmp"
RETENTION=30
echo "========== DISK CLEANUP =========="
echo "Disk Usage Before Cleanup"
df -h
echo
echo "Deleting logs older than $RETENTION days..."
find $LOG_DIR -type f -name "*.log" -mtime +$RETENTION -exec rm -f {} \;
echo
echo "Cleaning Temporary Files..."
find $TEMP_DIR -type f -mtime +7 -exec rm -f {} \;
echo
echo "Cleaning Apt Cache..."
sudo apt-get clean
echo
echo "Disk Usage After Cleanup"
df -h
echo
echo "Cleanup Completed Successfully"
