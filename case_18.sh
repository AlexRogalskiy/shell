#!/bin/bash

print_params() {
	echo "\$1 = $1"
	echo "\$2 = $2"
	echo "\$3 = $3"
	echo "\$4 = $4"
}

pass_params() {
	echo -e "\n" '$* :'; 	print_params $*
	echo -e "\n" '"$*" :'; 	print_params "$*"
	echo -e "\n" '$@ :'; 	print_params $@
	echo -e "\n" '"$@" :'; 	print_params "$@"
}

#$(basername $0) "word" "words with spaces"

#$(basername $0) -u jsmith -p notebooks -d 10-20-2011 -f pdf
while getopts u:d:p:f: option
do
	case "${option}"
		in
		u) USER=${OPTARG};;
		d) DATE=${OPTARG};;
		p) PRODUCT=${OPTARG};;
		f) FORMAT=$OPTARG;;
	esac
done