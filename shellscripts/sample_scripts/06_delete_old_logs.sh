#!/bin/bash

#This script is to delete old logs more than 30 days

sudo find /var/log -name "*.log" -mtime +30 -delete

echo "Old logs deleted"
