#!/bin/bash

function getusers {
	getent passwd | cut -f 1 -d : | xargs -n1 id
}
#type -a getusers

#----------------------------------------------------

function extract() {
	if[ -f $1 ] then
		case  $1 in
			*.tar) tar xf $1;;
			*.tar.bz2 | *.tbz2) tar xjf $1;;
			*.tar.gz | *.tgz) tar xzf $1;;
			*.gz) gunzip $1;;
			*.bz2) bunzip2 $1;;
			*.rar) rar x $1;;
			*.zip) unzip $1;;
			*.Z) uncompress $1;;
			*.7z|*.iso) 7z x $1;;
			*) echo "Unknown format for '$1'"; return 1;;
		esac
	else
		echo "'$1' is not a file"; return 1
	fi
}
#type -a extract

#----------------------------------------------------
set -x
until ping -c1 -w1 8.8.8.8; do sleep 1; date; done

df -h /run/shm
findmnt /run/shm
T=$(mktemp -d /run/shm/XXXXXX)
find DCIM -type f -print0 | xargs -0 -n1 md5sum | while read sum file; do echo $file >> $T/$sum; done
find $T -type f | xargs -n1 wc -l | awk '$1 > 1 {print $2}' | xargs -n1 -t cat

find DCIM -name '*.jpg' | while read FN; do echo $FN $(dirname $FN)/$(basename $FN .jpg).jpeg; done | xargs -n2 -P ($nproc) mv

bzip2 -kf dvd.iso &
while ps p$!; do ls -lh dvd.iso.bz2; sleep 1; done

for node in $(seq 1 254); do ping -c 1 -W 1 192.168.1.$node; done

for file in $(find DCIM -name '*.jpg'); do convert $file -resize 100x $(basename $file .jpg).mini.jpg; done

PROMPT_COMMAND = case $? in
		0|127) PROMPT_COLOR=`tput sgr0`;;
		13[01]) PROMPT_COLOR=`tput rev`;;
		1) PROMPT_COLOR=`tput bold`;;
		*) echo "exit code = $?"; PROMPT_COLOR=`tput bold`;;
	esac
PS1='`echo $PROMPT_COLOR`\u@\h \w\$ `tput sgr0`'


if test -b /dev/cdrom; then eject /dev/cdrom; fi

which clear && clear || tput clear
power=$(($(nproc) * 100))
temp=$(( $(cat /sys/class/thermal/thermal_zone0/temp)/1000 ))
load=$(awk '{printf "%d", $1 * 100 + $2 * 10 + $3}' < /proc/loadavg)

find /var/lib/dpkg/info -name '*.list' \
-mtime +$[ ($(date +%s) - $(date -d 2015-12-25 +%s)) / (24 * 60 * 60) ] \
-mtime -$[ ($(date +%s) - $(date -d 2015-12-20 +%s)) / (24 * 60 * 60) ] |
xargs stat -c %y:%n

fimd /lib /usr/lib -name '*.so.*' -size +$((1024 * 1024 * 10))c

dpkg -S $(whick lspci) | cut -f 1 -d : | xargs dpkg -S

rm -f $(find /tmp -user $(id -un) -size 0)

targ cjf dotconfig-$(date +%F).tbz2 ~/.config

find . -name '*.iso' | xargs -P 2 pbzip2 -p2 &
find /tmp -user bender -size 0 -print0 2>/dev/null | xargs -0 rm -f
tr -dc a-zA-Z0-9 </dev/urandom | fold -w 8 | head -3

find / -size 0 1>empty 2>/dev/null
cut -f 1 -d : /etc/passwd 1>users; sed -n 5,8p users

ipcs -m -p
sudo fuser -v /dev/shm/*
dc -e 16010i8421380p

#----------------------------------------------------

usage() {
	echo "Usage: $(basename $0) name | /.../libname.so.0" >&2
	exit 1
}

[ -z "$1" ] && usage
ldpath=$(grep -h '^[^#]' /etc/ld.so.conf.d/*.comf)

case $1 in
	/*/lib*.so.[0-9]) what=$1;;
	*) what=$(find $ldpath -name "lib$1.so.[0-9]" 2>/dev/null);;
esac

if ! [ -f "$what" ]
	then
		echo "Library $1 is not found in $LDPATH"
		usage
fi

where=$(printenv PATH | tr ':' ' ')

find $where -type f | xargs file -L | grep ':.*ELF' | cut -f 1 -d : | while read exe; do ldd $exe | grep -q $what && echo $exe; done

#----------------------------------------------------

ps axo rss, comm | grep -F chromium
grep '^[^#]' /etc/wgetrc
file -Li /*bin/* /usr/*bin/* | grep shellscript | cut -f 1 -d :
ps axo, rss:8, comm | grep chromium | cut -c 1-8 | paste -s -d + | bc

file -Li /*bin/* /usr/*bin/* | awk -F: '/shellscript/' { print $1 }
ps axo rss, comm | awk 'BEGIN { sum = 0 } /chromium/ { sum += $1 } END { print sum }'

ps axo rss, comm | sed '/chromium/!d'
sed '/^[^#]/!d' /etc/wgetrc

lspci -v | sed '/Ethernet/,/^$/!d'

find . | sort -f | sed -e 's:^..::' -e 's:[^/.][^/]*$:+-- &:' -e 's:[^/]*/:|    :g'

find . -name '*.py' | xargs grep -wl module | xargs sed -i '/import/ s:\<module\>:Module:g'

grep net.ipv4.ip_forward /etc/sysctl.conf
sudo sed -i '/net.ipv4.ip_forward/ s/^#//' /etc/sysctl.conf

#----------------------------------------------------

[ -n "$1" -a -f "$2"] && sed -i -e "/$1/ s/^#//" -e t -e "/$1/ s/^/#/" $2 || echo "Usage: toggle-comment RE file"

