#!/bin/bash

exit_SIGINT() {
	echo "INTERRUPTED" 2>&1
	exit 0
}

exit_SIGTERM() {
	echo "TERMINATED" 2>&1
	exit 0
}

trap exit_SIGINT SIGINT
trap exit_SIGTERM SIGTERM

for i in {1..100}; do
	echo "Iteration $i of 100"
	sleep 5
done

#tempfile=$(mktemp /tmp/foobar.$$.XXXXXXXX)
#[[ -d $HOME/tmp ]] || mkdir $HOME/tmp
