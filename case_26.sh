#!/bin/bash

usage() {
	echo "usage: $(basename $0) directory" >&2
	return
}

if [[ ! -d $1 ]]; then
	usage
	exit 1
fi

for i in {0..23}; do
	hours[i]=0
done

for i in $(stat -c %y "$1"/* | cut -c 12-13); do
	j=${i/#0}
	((++hours[j]))
	((++count))
done

echo -e "Hour\tFiles\tHour\tFIles"
echo -e "----\t-----\t----\t-----"

for i in {0..1}; do
	j=$((i + 12))
	printf "%02d\t%d\t%02d\t%d" $i ${hours[i]} $j ${hours[j]}
done

printf "\nTotal files = %d\n" $count