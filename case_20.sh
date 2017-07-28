#!/bin/bash

PROGNAME=$(basename $0)
TITLE="System Info for $HOSTNAME"
CUR_TIME=$(date +"%x %r %Z")
TIME_STAMP="Generated $CUR_TIME, by $USER"

show_uptime() {
	cat <<- _EOF_
		<h2>System Uptime</h2>
		<pre>$(uptime)</pre>
		_EOF_
	return
}

show_disk_usage() {
	cat <<- _EOF_
		<h2>Disk Space</h2>
		<pre>$(df -h)</pre>
		_EOF_
	return
}

show_home_usage() {
	local format="%8s%10s%10s\n"
	local i dir_list total_files total_dirs total_size user_name

	if [[ $(id -u) -eq 0 ]]; then
		dir_list=/home/*
		user_name="All Users"
	else
		dir_list=$HOME
		user_name=$USER
	fi

	echo "<h2>Home Space Usage ($user_name)</h2>"
	for i in $dir_list; do
		total_files=$(find $i -type f | wc -l)
		total_dirs=$(find $i -type d | wc -l)
		total_size=$(du -sh $i | cut -f 1)

		echo "<h3>$i</h3>"
		echo "<pre>"
		printf "$format" "Dirs" "Files" "Size"
		printf "$format" "----" "-----" "----"
		printf "$format" $total_dirs $total_files $total_size
		echo "</pre>"
	done
	return
}

show_usage() {
	echo "$PROGNAME: usage: $PROGNAME [-f file | -i]"
	return
}

show_system_info() {
	cat <<- _EOF_
		<html>
		<head><title>$TITLE</title></head>
		<body>
			<h1>$TITLE</h1>
			<p>$TIME_STAMP</p>
			$(show_uptime)
			$(show_disk_usage)
			$(show_home_usage)
		</body>
		</html>
	_EOF_
	return
}

filename=""
interactive=""

while [[ -n $1 ]]; then
	case $1 in
		-f | --file)		shift
							filename=$1
							;;
		-i | --interactive)	interactive=1
							;;
		-h | --help)		show_usage
							exit
							;;
		*)					show_usage >&2
							exit 1
							;;
	esac
	shift
done

if [[ -n $interactive ]]; then
	while [[ true ]]; do
		read -p "ENTER name of output file: " filename
		if [[ -e $filename ]]; then
			read -p "'$filename' exists. Overwrite? [y / n / q] > "
			case $REPLY in
				Y|y)	break
						;;
				Q|q)	echo "Program terminated"
						exit
						;;
				*)		continue
						;;
			esac
		fi
	done
fi

if [[ -n $filename ]]; then
	if touch $filename && [[ -f $filename ]]; then
		show_system_info > $filename
	else
		echo "$PROGNAME: Cannot write to file '$filename'" >&2
		exit 1
	fi
else
	show_system_info
fi
