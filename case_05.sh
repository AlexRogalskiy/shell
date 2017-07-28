#!/bin/bash

MINIMUM=1
MAXIMUM=100

INT=50

if [[ "$INT" =~ ^-?[0-9]+$ ]]; then #[ \( $INT -ge $MINIMUM -a $INT -le $MAXIMUM \) ]
	if [[ INT -ge MINIMUM && INT -le MAXIMUM ]]; then
		echo "$INT is within range ( $MINIMUM, $MAXIMUM )"
	else
		echo "$INT in out of range"
	fi
else
	echo "INT is not an integer" >&2
fi