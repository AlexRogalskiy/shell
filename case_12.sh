#!/bin/bash

DELAY=5

while [[ true ]]; do
	clear
	cat <<- _EOF_
		Please Select:

		1. Display System Info
		2. Display Disk Space
		3. Display Home Space
		0. Quit

	_EOF_
	read -p "ENTER choice [0-3] > "

	if [[ $REPLY =~ ^[0-3]$ ]]; then
		if [[ $REPLY == 0 ]]; then
			break
		fi
		if [[ $REPLY == 1 ]]; then
			echo "Hostname: $HOSTNAME"
			uptime
			sleep $DELAY
			continue
		fi
		if [[ $REPLY == 2 ]]; then
			df -h
			sleep $DELAY
			continue
		fi
		if [[ $REPLY == 3 ]]; then
			if [[ $(id -u) -eq 0 ]]; then
				echo "Home Space (all users)"
				du -sh /home/*
			else
				echo "Home Space ($USER)"
				du -sh $HOME
			fi
			sleep $DELAY
			continue
		fi
	else
		echo "Invalid entry < $REPLY >" >&2
		sleep $DELAY
	fi
done
echo "Program terminated"