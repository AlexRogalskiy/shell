#!/bin/bash

invalid_input() {
	echo "Invalid input '$REPLY'" >&2
	exit 1
}

read -p "ENTER a single item > "
if [[ -z $REPLY && invalid_input ]]; then
	echo "REPLY is empty"
	exit 1
fi

if [[ $(echo $REPLY | wc -w) > 1 && invalid_input ]]; then
	echo "REPLY with multiple params"
	exit 1
fi

if [[ $REPLY =~ ^[-[:alnum:]\._]+$ ]]; then
	echo "'$REPLY' is a valid filename"
	if [[ ! (-e $REPLY) ]]; then
		echo "FILE '$REPLY' does not exist"
		exit 1
	fi

	if [[ ! ($REPLY =~ ^-?[[:digit:]]*\.[[:digit:]]+$) ]]; then
		echo "'$REPLY' is not a floating point number"
		exit 1
	fi

	if [[ ! ($REPLY =~ ^-?[[:digit:]]+$) ]]; then
		echo "'$REPLY' is not an integer"
		exit 1
	fi
else
	echo "The string '$REPLY' is not a valid filename"
	exit 1
fi