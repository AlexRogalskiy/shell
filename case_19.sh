#!/bin/bash

PROGNAME=$(basename $0)
filename=""

fusage() {
	echo "$PROGNAME: usage: $PROGNAME [-f file | -i]"
	return
}

finteractive() {
	while [[ true ]]; do
		read -p "ENTER name of output file: " filename
		if [[ -e $filename ]]; then
			read -p "'$filename' exists. Overwrite? [y / n / q] > "
			case $REPLY in
				Y|y)	break
						;;
				Q|q)	echo "Program terminated"
						exit
						;;
				*)		continue
						;;
			esac
		elif [[ -z $filename ]]; then
			continue
		else
			break
		fi
	done
	return
}

while [[ -n $1 ]]; then
	case $1 in
		-f | --file)		shift
							filename=$1
							;;
		-i | --interactive)	finteractive
							exit
							;;
		-h | --help)		fusage
							exit
							;;
		*)					fusage >&2
							exit 1
							;;
	esac
	shift
done