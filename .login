#
#	.login, tcsh login script
#	nicholas christopoulos (nereus@freemail.gr)
#

#	remake PATH
if ( $LOGNAME == "root" ) set path = ( /sbin /usr/sbin $path /usr/local/sbin )
set path = ( /bin /usr/bin $path /usr/local/bin /usr/dt/bin /usr/games )

## path's penticure
if ( -x /bin/path++ ) then
	setenv PATH `/bin/path++`
endif

# needed for android emulator
if ( $LOGNAME == "root" ) then
	echo 1024 > /proc/sys/dev/hpet/max-user-freq
endif

#	welcome
if ( $?TMUX ) exit

# Welcome
echo 
if ( $?tcsh == 0 ) then
	echo "Welcome to BSD C-Shell"
else
	echo "Welcome to Tenex C-Shell"
endif

/bin/echo -e "\033="_______________________________________________________________________
echo
/usr/games/fortune /usr/share/games/fortunes/diogenis
