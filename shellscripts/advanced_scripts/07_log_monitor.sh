#!/bin/bash
#############################################################
# Script Name : log_monitor.sh
# Description : Monitor application logs for critical errors
# Author      : Tejaswini Lingala
#############################################################
# Log file to monitor
LOG_PATH="/var/log/syslog"
# Report directory
REPORT_DIR="/home/ubuntu/log_reports"
mkdir -p "$REPORT_DIR"
REPORT_FILE="$REPORT_DIR/log_report_$(date +%F_%H-%M-%S).log"
echo "========================================="
echo "        LOG MONITOR"
echo "========================================="
echo "Log File : $LOG_PATH"
echo
# Check if file exists
if [ ! -f "$LOG_PATH" ]
then
   echo "ERROR : Log file not found."
   exit 1
fi
echo "Searching for Critical Errors..."
echo
grep -Ei "ERROR|FATAL|CRITICAL|EXCEPTION" "$LOG_PATH" > "$REPORT_FILE"
ERROR_COUNT=$(grep -Eic "ERROR|FATAL|CRITICAL|EXCEPTION" "$LOG_PATH")
echo "Total Critical Errors : $ERROR_COUNT"
echo
if [ "$ERROR_COUNT" -gt 0 ]
then
   echo "Critical errors detected."
   echo "Report saved to"
   echo "$REPORT_FILE"
   exit 1
else
   echo "No Critical Errors Found."
   rm -f "$REPORT_FILE"
   exit 0
fi
