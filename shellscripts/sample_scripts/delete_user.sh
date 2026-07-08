#!/bin/bash

# This script is to delete user

read -p "Enter username: " username

if id "$username" $>/dev/null;
then
	sudo userdel -r "$username"
	echo "user deleted successfully"
else
	echo "User does not exist"
fi

