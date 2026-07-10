#!/bin/bash

# This is to check disk usage

usage=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')

if [ "$usage" -gt 80 ];
then
	echo "Disk usage is high: $usage%"
else
	echo "Disk usage is normal: $usage%"
fi
