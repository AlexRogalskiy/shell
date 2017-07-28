#!/bin/bash

FILE=/etc/passwd

read -p "ENTER username > " user_name

file_info=$(grep "^$user_name:" $FILE)

if [[ -n "$file_info" ]]; then
	OLD_IFS="$IFS"
	IFS=":"
	read user pw uid gid name home shell <<< "$file_info"
	IFS="$OLD_IFS"

	echo "USER = '$user'"
	echo "UID = '$uid'"
	echo "GID = '$gid'"
	echo "FULL NAME = '$name'"
	echo "HOME = '$home'"
	echo "SHELL = '$shell'"
else
	echo "No such user '$user_name'" >&2
	exit 1
fi