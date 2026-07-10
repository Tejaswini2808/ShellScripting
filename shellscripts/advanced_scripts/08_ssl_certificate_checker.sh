#!/bin/bash
#############################################################
# Script Name : ssl_certificate_checker.sh
# Description : Monitor SSL certificate expiry
# Author      : Tejaswini Lingala
#############################################################
# List of websites
WEBSITES=(
"google.com"
"github.com"
"amazon.com"
)
# Alert threshold (days)
THRESHOLD=30
# Log directory
LOG_DIR="/home/ubuntu/logs"
LOG_FILE="$LOG_DIR/ssl_certificate.log"
mkdir -p "$LOG_DIR"
echo "=========================================="
echo "      SSL CERTIFICATE MONITOR"
echo "=========================================="
FAILED=0
for SITE in "${WEBSITES[@]}"
do
   echo
   echo "Checking : $SITE"
   EXPIRY=$(echo | openssl s_client -servername "$SITE" \
   -connect "$SITE:443" 2>/dev/null | \
   openssl x509 -noout -enddate | cut -d= -f2)
   if [ -z "$EXPIRY" ]
   then
       echo "Unable to retrieve certificate."
       echo "$(date) : $SITE : FAILED" >> "$LOG_FILE"
       FAILED=1
       continue
   fi
   EXPIRY_SECONDS=$(date -d "$EXPIRY" +%s)
   CURRENT_SECONDS=$(date +%s)
   DAYS_LEFT=$(( (EXPIRY_SECONDS - CURRENT_SECONDS) / 86400 ))
   echo "Expires On : $EXPIRY"
   echo "Days Left  : $DAYS_LEFT"
   if [ "$DAYS_LEFT" -le "$THRESHOLD" ]
   then
       echo "WARNING : Certificate expires within $THRESHOLD days."
       echo "$(date) : $SITE expires in $DAYS_LEFT days." >> "$LOG_FILE"
       FAILED=1
   else
       echo "Certificate is Healthy."
   fi
done
echo
echo "=========================================="
if [ "$FAILED" -eq 0 ]
then
   echo "All SSL Certificates are Healthy."
   exit 0
else
   echo "SSL Alert Detected."
   exit 1
fi
