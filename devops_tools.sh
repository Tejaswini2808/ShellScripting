#!/bin/bash

###################################
Install all DevOps related tools using this script on Ubuntu
##################################

# Upgrading and Updating System
echo
echo "======================================"
echo " Updating and Upgrading System	    "
echo "======================================"
sudo apt update
sudo apt upgrade -y
echo "=================================="
echo "Updated and Upgraded Successfully"
echo "================================="
# Installing Git 
echo
echo "======================================"
echo "		Installing Git		    "
echo "======================================"
sudo apt update
sudo apt install git 
echo "---------Checking Git Version----------"
echo "---------------------------------------"
echo "========================================"
echo "		Git Installed Successfully    "
echo "========================================"
#Installing Ansible
echo
echo "======================================="
echo "	Installing Ansible		     "
echo "======================================="
sudo apt update 
sudo apt install ansible -y
