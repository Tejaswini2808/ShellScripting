#!/bin/bash

#############################################################
# Description : Clean up unused Docker resources
# Author      : Tejaswini Lingala
#############################################################

echo "=========================================="
echo "        DOCKER CLEANUP SCRIPT"
echo "=========================================="

# Check if Docker is installed
if ! command -v docker &>/dev/null
then
   echo "Docker is not installed."
   exit 1
fi

# Check Docker service
if ! systemctl is-active --quiet docker
then
   echo "Docker service is not running."
   exit 1
fi
echo
echo "Docker Disk Usage Before Cleanup"
echo "--------------------------------"
docker system df
echo
echo "Removing stopped containers..."
docker container prune -f
echo
echo "Removing dangling images..."
docker image prune -f
echo
echo "Removing unused images..."
docker image prune -a -f
echo
echo "Removing unused volumes..."
docker volume prune -f
echo
echo "Removing unused networks..."
docker network prune -f
echo
echo "Removing build cache..."
docker builder prune -f
echo
echo "Docker Disk Usage After Cleanup"
echo "-------------------------------"
docker system df
echo
echo "=========================================="
echo "Docker Cleanup Completed Successfully"
echo "=========================================="
