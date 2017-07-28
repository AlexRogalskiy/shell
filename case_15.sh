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

case $REPLY in
	0)
		echo "Program terminated"
		exit
		;;
	1)
		echo "Hostname: $HOSTNAME"
		uptime
		exit
		;;
	2)
		df -h
		exit
		;;
	3)	if [[ $(id -u) -eq 0 ]]; then
			echo "Home Space (all users)"
			du -sh /home/*
		else
			echo "Home Space ($USER)"
			du -sh $HOME
		fi
		;;
	*)	echo "Invalid entry < $REPLY >" >&2
		exit 1
		;;
esac