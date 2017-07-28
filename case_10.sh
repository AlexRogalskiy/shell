#!/bin/bash

clear
echo "
Please Select:

1. Display System Info
2. Display Disk Space
3. Display Home Space
0. Quit
"

read -p "ENTER choice [0-3] > "

if [[ $REPLY =~ ^[0-3]$ ]]; then
	if [[ $REPLY == 0 ]]; then
		echo "Program terminated"
		exit
	fi
	if [[ $REPLY == 1 ]]; then
		echo "Hostname: $HOSTNAME"
		uptime
		exit
	fi
	if [[ $REPLY == 2 ]]; then
		df -h
		exit
	fi
	if [[ $REPLY == 3 ]]; then
		if [[ $(id -u) -eq 0 ]]; then
			echo "Home Space (all users)"
			du -sh /home/*
		else
			echo "Home Space ($USER)"
			du -sh $HOME
		fi
		exit
	fi
else
	echo "Invalid entry < $REPLY >" >&2
	exit 1
fi