#!/bin/bash
#############################################################
# Script Name : user_audit.sh
# Description : Linux User Security Audit
# Author      : Tejaswini Lingala
#############################################################
REPORT_DIR="/home/ubuntu/reports"
mkdir -p "$REPORT_DIR"
REPORT_FILE="$REPORT_DIR/user_audit_$(date +%F_%H-%M-%S).log"
exec > >(tee "$REPORT_FILE")
echo "=================================================="
echo "            LINUX USER AUDIT REPORT"
echo "=================================================="
echo
echo "Hostname : $(hostname)"
echo "Date     : $(date)"
######################################################
# Total Users
######################################################
echo
echo "========== Total Users =========="
cut -d: -f1 /etc/passwd
echo
echo "Total Users : $(wc -l < /etc/passwd)"
######################################################
# Sudo Users
######################################################
echo
echo "========== Sudo Users =========="
getent group sudo | cut -d: -f4 | tr ',' '\n'
######################################################
# Users with UID 0
######################################################
echo
echo "========== UID 0 Users =========="
awk -F: '$3==0 {print $1}' /etc/passwd
######################################################
# Last Login
######################################################
echo
echo "========== Last Login =========="
lastlog
######################################################
# Logged-in Users
######################################################
echo
echo "========== Logged In Users =========="
who
######################################################
# Password Status
######################################################
echo
echo "========== Password Status =========="
sudo passwd -S $(whoami)
######################################################
# Expired Accounts
######################################################
echo
echo "========== Expired Accounts =========="
sudo awk -F: '($7=="/usr/sbin/nologin"){print $1}' /etc/passwd
######################################################
# Home Directories
######################################################
echo
echo "========== Home Directories =========="
ls -ld /home/*
echo
echo "=================================================="
echo "Audit Completed Successfully"
echo "Report Saved At:"
echo "$REPORT_FILE"
echo "=================================================="
