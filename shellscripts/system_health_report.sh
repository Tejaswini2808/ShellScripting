#!/bin/bash

LOGFILE="/home/ubuntu/reports/health_report_$(date +%F).log"
mkdir -p /home/ubuntu/reports
exec > "$LOGFILE" 2>&1


echo "======================================================================================================"
echo "					SYSTEM HEALTH REPORT"
echo "======================================================================================================"

echo 
echo "Hostname		: $(hostname)"
echo "IP Address		: $(hostname -I)"
echo "Operating System	: $(uname -o)"
echo "Kernel Version		: $(uname -r)"
echo "Current Date		: $(date)"
echo "Uptime			: $(uptime -p)"

echo
echo "========== CPU Usage =========="
top -bn1 | grep -i "CPU"

echo
echo "========== Memory Usage =========="
free -h

echo
echo "========== Disk Usage =========="
df -h

echo
echo "========== Top 5 Memory Consuming Processes =========="
ps -eo pid,comm,%mem --sort=-%mem | head -6

echo
echo "========== Top 5 CPU Consuming Processes =========="
ps -eo pid,comm,%cpu --sort=-%cpu | head -6

echo
echo "========== Logged-in Users =========="
who

echo
echo "========== Running Services =========="
systemctl list-units --type=service --state=running | head -15

echo
echo "========== Disk Space Alert =========="
usage=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')
if [ "$usage" -gt 80 ];
then
	echo "WARNING: Disk Usage is above 80% --> ($usage%)"
else
	echo "Disk Usage is normal ($usage%)"
fi

echo
echo "========== Memory Alert =========="
mem=$(free |awk '/Mem/ {print int($3/$2*100)}')
if [ "$mem" -gt 80 ];
then
	echo "WARNING: Memory Usage is above 80% --> ($mem%)"
else
	echo "Memory Usage is normal ($mem%)"
fi

echo
echo "========== Report Completed =========="



