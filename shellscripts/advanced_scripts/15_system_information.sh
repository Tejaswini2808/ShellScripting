#!/bin/bash
#############################################################
# Script Name : system_information.sh
# Description : Linux System Information Report
# Author      : Tejaswini Lingala
#############################################################
REPORT_DIR="/home/ubuntu/reports"
mkdir -p "$REPORT_DIR"
REPORT_FILE="$REPORT_DIR/system_report_$(date +%F_%H-%M-%S).txt"
exec > >(tee "$REPORT_FILE")
echo "=========================================="
echo "      SYSTEM INFORMATION REPORT"
echo "=========================================="
echo
echo "Hostname"
hostname
echo
echo "Operating System"
cat /etc/os-release
echo
echo "Kernel Version"
uname -r
echo
echo "Architecture"
uname -m
echo
echo "System Uptime"
uptime
echo
echo "Current Date"
date
echo
echo "Logged In Users"
who
echo
echo "CPU Information"
lscpu
echo
echo "Memory Usage"
free -h
echo
echo "Disk Usage"
df -h
echo
echo "Mounted File Systems"
mount
echo
echo "IP Address"
hostname -I
echo
echo "Routing Table"
ip route
echo
echo "DNS Configuration"
cat /etc/resolv.conf
echo
echo "Open Listening Ports"
ss -tuln
echo
echo "Running Services"
systemctl --type=service --state=running
echo
echo "Top 10 Memory Consuming Processes"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head
echo
echo "Top 10 CPU Consuming Processes"
ps -eo pid,ppid,cmd,%cpu,%mem --sort=-%cpu | head
echo
echo "=========================================="
echo "Report Generated Successfully"
echo "Location"
echo "$REPORT_FILE"
echo "=========================================="
