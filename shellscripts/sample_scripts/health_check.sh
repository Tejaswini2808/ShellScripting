#!/bin/bash

###################

This is a daily health check of system

###################

echo "Updating the system....."
sudo apt update -y
echo "Updated"

echo "Upgrading the system....."
sudo apt upgrade -y 
echo "Upgraded"

echo "Listing Contents..."
ls -ltr

echo "Number of CPUs running..."
nproc

echo "Memory Check"
free -mh

echo "Disk Usage"
df -h

