#!/bin/bash
#############################################################
# Script Name : process_monitor.sh
# Description : Monitor critical Linux processes
# Author      : Tejaswini Lingala
#############################################################
# List of critical processes
PROCESSES=("java" "nginx" "docker" "sshd")
# Log directory
LOG_DIR="/home/ubuntu/logs"
LOG_FILE="$LOG_DIR/process_monitor.log"
mkdir -p "$LOG_DIR"
echo "=========================================="
echo "        PROCESS MONITOR"
echo "=========================================="
FAILED=0
for PROCESS in "${PROCESSES[@]}"
do
   echo
   echo "Checking Process : $PROCESS"
   PID=$(pgrep -x "$PROCESS")
   if [ -n "$PID" ]
   then
       echo "Status : RUNNING"
       echo "PID    : $PID"
       echo "$(date): $PROCESS is running (PID: $PID)" >> "$LOG_FILE"
   else
       echo "Status : NOT RUNNING"
       echo "$(date): $PROCESS is NOT running." >> "$LOG_FILE"
       FAILED=1
       case "$PROCESS" in
           nginx)
               echo "Attempting to restart nginx..."
               sudo systemctl restart nginx
               ;;
           docker)
               echo "Attempting to restart docker..."
               sudo systemctl restart docker
               ;;
           sshd)
               echo "Attempting to restart ssh..."
               sudo systemctl restart ssh
               ;;
           java)
               echo "Java process is not running."
               echo "Verify application deployment."
               ;;
       esac
   fi
done
echo
echo "=========================================="
if [ $FAILED -eq 0 ]
then
   echo "All Processes are Healthy."
   exit 0
else
   echo "Some Processes require attention."
   exit 1
fi
