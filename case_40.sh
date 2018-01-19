#!/bin/bash
# usage make.sh <prefix> <files>

prefix=$1
shift
for i in "$@"
do
	echo "Renaiming file $i..."
	mv "$i" "$prefix$i"
done