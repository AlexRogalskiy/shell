#!/bin/bash

for filename in *; do
	if [ -f $filename ]; then
		ls -l $filename
		file $filename
	else
		echo $filename is not a file
	fi
done
#[ file1 -nt file2]
#[ file1 -ot file2 ]
#[ file1 -ef file2 ]
#[ -z ""]
#[ -n "1"]
#[ 01 -eq 1 ] // -ne/-lt/-gt/-le/-ge
#[ 1 = 1 ]
