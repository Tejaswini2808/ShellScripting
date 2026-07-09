#!/bin/bash

###############################################################
# Description : Monitor CPU & Memory usage and generate alerts
# Author      : Tejaswini Lingala
###############################################################

CPU_THRESHOLD=80
MEM_THRESHOLD=80

LOG_DIR="/home/ubuntu/logs"
LOG_FILE="$LOG_DIR/system_alert.log"

mkdir -p "$LOG_DIR"

echo "======================================="
echo " CPU & MEMORY MONITOR "
echo "======================================="

#########################################
# CPU Usage
#########################################

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print int($2+$4)}')
echo "Current CPU Usage : $CPU_USAGE%"
if [ "$CPU_USAGE" -gt "$CPU_THRESHOLD" ]
then
   echo "$(date) : HIGH CPU USAGE -> $CPU_USAGE%" | tee -a "$LOG_FILE"
else
   echo "CPU Usage Normal"
fi

echo
#########################################
# Memory Usage
#########################################

MEM_USAGE=$(free | awk '/Mem:/ {print int($3/$2 * 100)}')
echo "Current Memory Usage : $MEM_USAGE%"
if [ "$MEM_USAGE" -gt "$MEM_THRESHOLD" ]
then
   echo "$(date) : HIGH MEMORY USAGE -> $MEM_USAGE%" | tee -a "$LOG_FILE"
else
   echo "Memory Usage Normal"
fi

echo
#########################################
# Summary
#########################################
echo "======================================="
if [ "$CPU_USAGE" -gt "$CPU_THRESHOLD" ] || [ "$MEM_USAGE" -gt "$MEM_THRESHOLD" ]
then
   echo "ALERT : System crossed threshold."
   exit 1
else
   echo "System is Healthy."
   exit 0
fi
