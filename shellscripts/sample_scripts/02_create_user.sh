#!/bin/bash

# This script is used to create users with no write access

read -p "Enter Username: " username

echo "You entered: $username"

if id  "$username" &>/dev/null;
then
	echo "User already exists"
else
	sudo useradd -m "$username"
	echo "New user added"

	echo "Giving read and execute access to $username"
	chmod -R 755 /home/ubuntu/shellscripts

	echo "Read & Execute Access has been assigned to $username"
fi
