#!/bin/bash

export PS4='$LINENO + '

set -x
if [[ -d $dir_name ]]; then
	if [[ cd $dir_name ]]; then
		rm *
	else
		echo "Cannot change directory to '$dir_name'" >&2
		exit 1
	fi
else
	echo "No such directory: '$dir_name'" >&2
	exit 1
fi
set +x