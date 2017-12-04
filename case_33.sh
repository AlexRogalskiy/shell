#!/bin/bash
echo $0: bad option $BADPARM 1>&2
echo Argument: $1
shift
echo Argument: $2
shift
echo Argument: $3

if [ "$1" = hi ]; then
#if [ x"$1" = x"hi" ]; then
	echo 'The first argument was "hi"'
else
	echo -n 'The first argument was not "hi" -- '
	echo It was '"'$1'"'
fi

if grep -q daemon /etc/passwd; then
	echo 1
else
	echo 2
fi