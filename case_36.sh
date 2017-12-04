#!/bin/bash

TMPFILE1=$(mktemp /tmp/im1.XXXXXX)
TMPFILE1=$(mktemp /tmp/im2.XXXXXX)
cat /proc/interrupts > $TMPFILE1
sleep 2
cat /proc/interrupts > $TMPFILE2
diff $TMPFILE1 $TMPFILE2
trap "rm -f $TMPFILE1 $TMPFILE2; exit 1" INT

DATE=$(date)
cat << EOF
Date: $DATE

The output above is from the UNIX date command.
It\'s not a very long command.
EOF
