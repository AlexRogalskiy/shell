#.bashrc

PATH=/usr/local/bin:/usr/bin:/bin:/usr/games
PATH=$HOME/bin:$PATH

#\u = username
#\h = hostname
#\w = current directory
#\! = history number
#\s = shell name
#\$ = $ if regular user
#\# = # if superuser
PS1='\u\$'

EDITOR=vi
VISUAL=vi

PAGER=less
#F=quit at end, R=show raw characters, X=not use alt screen
LESS=FRX

export PATH EDITOR VISUAL PAGER LESS

umask 022

case $- in
	*i*)
		#interactive commands
		;;
	*)
		#non-interactive commands
		;;
esac

#.bash_profile
. $HOME/.bashrc