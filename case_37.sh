#!/bin/bash

for file in *.gif; do
	if [ ! -f $file ]; then
		exit
	fi
	b=$(basename $file.gif)
	echo Converting $b.gif to $b.png
	gittopnm $b.gif | pnmtopng > $b.png
done

#find . -name '*.gif' -print0 | xargs -0 file
#find . -name '*.gif' -exec file {} \
#tar cf - original | (cd target; tar xvf -)
#. config.sh
#read var
#tar cBvf - directory | ssh remote tar xBvpf -