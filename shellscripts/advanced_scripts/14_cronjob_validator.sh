#!/bin/bash
#############################################################
# Script Name : cron_job_validator.sh
# Description : Validate Linux Cron Jobs
# Author      : Tejaswini Lingala
#############################################################
REPORT_DIR="/home/ubuntu/reports"
REPORT_FILE="$REPORT_DIR/cron_report_$(date +%F_%H-%M-%S).log"
mkdir -p "$REPORT_DIR"
echo "============================================"
echo "         CRON JOB VALIDATOR"
echo "============================================"
echo "Hostname : $(hostname)"
echo "Date     : $(date)"
echo
# Check cron service
if systemctl is-active --quiet cron
then
   echo "Cron Service : Running"
else
   echo "Cron Service : Not Running"
   exit 1
fi
echo
echo "============================================"
echo "Installed Cron Jobs"
echo "============================================"
crontab -l 2>/dev/null | tee "$REPORT_FILE"
echo
echo "============================================"
echo "Duplicate Cron Entries"
echo "============================================"
crontab -l 2>/dev/null | sort | uniq -d
echo
echo "============================================"
echo "Total Cron Jobs"
echo "============================================"
crontab -l 2>/dev/null | grep -v "^#" | grep -v "^$" | wc -l
echo
echo "Report Saved At"
echo "$REPORT_FILE"
echo
echo "Cron Validation Completed Successfully"
