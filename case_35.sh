#!/bin/bash

case $1 in
	bye)
		echo Fine, bye.
		;;
	hi|hello)
		echo Nice to see you.
		;;
	what*)
		echo Whatever?
		;;
	*)
		echo 'Hub?'
		;;
esac

for str in one two three four five six; do
	echo $str
done

FILE=/tmp/whitetest.$$;
echo firstline > $FILE
while tail -10 $FILE | grep -q firstline; do
	echo -n Number of lines in $FILE: ' '
	wc -l $FILE | awk '{print $1}'
	echo newline >> $FILE
done
rm -f $FILE

FLAGS=$(grep ^flags /proc/cpuinfo | sed 's/.*://' | head -1)
echo Current processor supports:
for f in $FLAGS; do
	case $f in
		fpu)
			MSG="floating point unit"
			;;
		3dnow)
			MSG="3DNOW graphics extensions"
			;;
		mtrr)
			MSG="memory type range register"
			;;
		*)
			MSG="unknown"
			;;
	esac
	echo $f: $MSG
done


