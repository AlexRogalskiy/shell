#!/bin/bash

report_home_space() {
	if [[ $(id -u) -eq 0 ]]; then
		cat <<- _EOF_
			<h2>HOME SPACE (all users)</h2>
			<pre>$(du -sh /home/*)</pre>
			_EOF_
	else
		cat <<- _EOF_
			<h2>HOME SPACE ($USER)</h2>
			<pre>$(du -sh $HOME)</pre>
			_EOF_
	fi
	return
}