#!/bin/bash

PROGNAME=$(basename $0)

usage() {
	cat <<- _EOF_
		Usage: $PROGNAME PRINCIPAL INTEREST MONTHS

		Where:

			PRINCIPAL is the amount of the loan
			INTEREST is the APR as a number (e.g. 7%)
			MONTHS is the length of the loan\'s term

	_EOF_
}

if [[ $# != 3 ]]; then
	usage
	exit 1
fi

PRINCIPAL=$1
INTEREST=$2
MONTHS=$3

bc <<- _EOF_
	scale = 10
	i = $INTEREST / 100 / 12
	p = $PRINCIPAL
	n = $MONTHS
	a = p * ((i * ((1 + i) ^ n)) / (((1 + i) ^ n) - 1))
	print a, "\n"
_EOF_