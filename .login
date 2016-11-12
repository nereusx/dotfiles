#
#	.login, tcsh login script
#	nicholas christopoulos (nereus@freemail.gr)
#

#echo "--- .login"

#
#	remake PATH
#
if ( $LOGNAME == "root" ) set path = ( /sbin /usr/sbin $path /usr/local/sbin )
set path = ( /bin /usr/bin $path /usr/local/bin /usr/dt/bin /usr/games )

#setenv PATH /opt/unicon/bin:$PATH

##setenv PKG_CONFIG_PATH /usr/local/lib/pkgconfig/

## android java sdk
#set path = ( $path /opt/android-sdk-linux/platform-tools /opt/android-sdk-linux/tools )

## Apple's FDK
#set path = ( $path /opt/FDK/Tools/linux/ )
#setenv FDK_EXE /opt/FDK/Tools/linux/

## crisp
##setenv CRPATH /usr/local/lib/crisp/macros/

## path's penticure
if ( -x /bin/path++ ) then
	setenv PATH `/bin/path++`
endif

#
#	misc
#

# needed for android emulator
if ( $LOGNAME == "root" ) then
	echo 1024 > /proc/sys/dev/hpet/max-user-freq
endif
# load user's services

#set pulse_pid=`pgrep -u $USER -x pulseaudio`
#if ( "$pulse_pid" == "" ) then
#	pulseaudio --start --log-target=syslog &
#endif

#
#	welcome
#

# if in tmux; exit
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
