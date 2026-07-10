#!/bin/bash

#This script is to ping multiple servers

for server in google.com github.com amazon.com home.com teju.com
do 
	if ping -c 1 "$server" &>/dev/null;
	then
		echo "$server is reachable"
	else
		echo "$server is unreachable"
	fi
done
