#!/bin/sh
# basic settings

# Start TMUX automagically
# echo 'AUTOLOAD_TMUX=1' >> /etc/environment
AUTOLOAD_TMUX=${AUTOLOAD_TMUX:-0}
if [ $AUTOLOAD_TMUX -eq 1 ]; then
	if [ -z "${TMUX:-}" -a -z "${SUDO_USER:-}" ]; then
		exec tmux
	fi
fi

# Basic settings
DS='$'
[ "$TERM" = "rxvt" ] && TERM="rxvt-unicode"
USER=${USER:-$(id -un)}
HOME=${HOME:-"/home/$USER"}
USERID=${USERID:-$(id -u)}
HOSTNAME=${HOSTNAME:-$(hostname)}
TTY=${TTY:-$(tty | cut -f3-4 -d/)}
MAIL=${MAIL:-"/var/mail/$USER"}
MAILCHECK=${MAILCHECK:-0}
_get_distro() {
	if [ -r /etc/os-release ]; then
		echo $(awk '/^ID=/{gsub(/"/,"",$0);print tolower(substr($0,4))}' /etc/os-release)
	else
		echo $(uname -s)
	fi;
	}
: ${DISTRO:=$(_get_distro)}
: ${OSTYPE:=$(uname -s)}


