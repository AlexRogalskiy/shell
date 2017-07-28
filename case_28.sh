#!/bin/bash

while read attr links owner group size date time filename; do
	cat <<- _EOF_
		Filename: 	$filename
		Size: 		$size
		Owner:		$owner
		Group:		$group
		Modified:	$date $time
		Links:		$links
		Attributes:	$attr
	_EOF_
done < <(ls -l | tail -n +2)