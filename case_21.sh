#!/bin/bash

while [[ -n $1 ]]; do # for j: do
	if [[ -r $1 ]]; then
		max_word=""
		max_len=0
		for i in $(strings $1); do
			len=${#i}
			#len=$(echo $i | wc -c)
			if (( len > max_len )); then
				max_len=$len
				max_word=$i
			fi
		done
		echo "$1: '$max_word' (length=$max_len)"
	fi
	shift
done