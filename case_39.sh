#.cshrc
setenv PATH /usr/local/bin:/usr/bin:/bin:$HOME/bin

setenv EDITOR vi
setenv VISUAL vi
setenv PAGER less
setenv LESS meiX

umask 022
#%n=username
#%m=hostname
#%/=current directory
#%h=history number
#%l=current terminal
#%%=%
set prompt="%m%% "

#.csh_profile
. $HOME/.cshrc