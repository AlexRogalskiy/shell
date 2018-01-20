VerifyCmd ()
{
# VerifyCmd  
# Checks to see if given command exists, optional output.
[ $1 -eq 1 ] && echo -n "Checking for $2: "
if which $2 > /dev/null 2>&1; then
	[ $1 -eq 1 ] && echo "OK"
	return 0
else
	[ $1 -eq 1 ] && echo "FAILED"
	return 1
fi


ErrorMsg ()
{
# ErrorMsg  
# Displays either a minor (warning) or critical error, exiting on an critical.
# If message starts with "n", a newline is printed before message.
[[ $(expr substr "$2" 1 1) == "n" ]] && echo
if [ "$1" == "ERR" ]; then
	# This is a critical error, game over.
	echo "  ERROR: ${2#n}"
	exit 1
elif [ "$1" == "WRN" ]; then
	# This is only a warning, script continues but may not work fully.
	echo "  WARNING: ${2#n}"
fi
}

#ErrorMsg ERR "nFailed to locate the nudez!!"