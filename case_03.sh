#!/bin/bash

ANSWER=try

if[ -z "$ANSWER" ]; then
	echo "There is no ANSWER" >&2
	exit 1
fi

if[ "$ANSWER" == "yes" ]; then
	echo "The ANSWER is $ANSWER"
elif [ "$ANSWER" == "no" ]; then
	echo "The ANSWER is $ANSWER"
elif [ "$ANSWER" == "try" ]; then
	echo "The ANSWER is $ANSWER"
else
	echo "The ANSWER is UNKNOWN"
fi