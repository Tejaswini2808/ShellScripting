#!/bin/bash

#############################################################
# Script Name : service_monitor.sh
# Description : Monitor and restart Linux services
# Author      : Tejaswini Lingala
#############################################################

SERVICES=("docker" "nginx" "ssh")
LOG_DIR="/home/ubuntu/logs"
LOG_FILE="$LOG_DIR/service_monitor.log"
mkdir -p "$LOG_DIR"

echo "=========================================="
echo "      SERVICE MONITOR"
echo "=========================================="

FAILED=0

for SERVICE in "${SERVICES[@]}"
do
   echo
   echo "Checking Service : $SERVICE"
   if systemctl is-active --quiet "$SERVICE"
   then
       echo "Status : RUNNING"
   else
       echo "Status : STOPPED"
       echo "$(date) : $SERVICE stopped. Restarting..." | tee -a "$LOG_FILE"
       sudo systemctl restart "$SERVICE"
       sleep 3
       if systemctl is-active --quiet "$SERVICE"
       then
           echo "Restart Successful"
           echo "$(date) : $SERVICE restarted successfully." >> "$LOG_FILE"
       else
           echo "Restart Failed"
           echo "$(date) : Failed to restart $SERVICE." >> "$LOG_FILE"
           FAILED=1
       fi
   fi
done
echo
echo "=========================================="
if [ $FAILED -eq 0 ]
then
   echo "All Services are Healthy."
   exit 0
else
   echo "Some services require attention."
   exit 1
fi
