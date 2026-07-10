#!/bin/bash
URL="http://localhost"
echo "========== NGINX HEALTH CHECK =========="
if systemctl is-active --quiet nginx
then
   echo "Nginx Service : Running"
else
   echo "Nginx Service : Stopped"
   echo "Restarting Nginx..."
   sudo systemctl restart nginx
fi
STATUS=$(curl -o /dev/null -s -w "%{http_code}" $URL)
if [ "$STATUS" -eq 200 ]
then
   echo "Website Status : Healthy"
else
   echo "Website Status : Failed"
   exit 1
fi
