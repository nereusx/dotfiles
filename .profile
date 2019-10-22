# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc"
    fi
elif [ -n "$KSH_VERSION" ]; then
	case $KSH_VERSION in
	*MIRBSD*)
		export ENV=$HOME/.mkshrc
		;;
	*PD*KSH*)
		if [ -f $HOME/.ksh88rc ]; then
			export ENV=$HOME/.ksh88rc
		else
			export ENV=$HOME/.kshrc
		fi
		;;
	*93*)
		if [ -f $HOME/.ksh93rc ]; then
			export ENV=$HOME/.ksh93rc
		else
			export ENV=$HOME/.kshrc
		fi
		;;
	*)
		export ENV=$HOME/.kshrc
		;;
	esac
elif [ -n "$YASH_VERSION" ]; then
#	export ENV=$HOME/.yashrc
	:
else
	tsh=$(ps -hp $$|awk '{print $5}')
	case $tsh in
	dash)
		;;
	ash)
		export ENV=$HOME/.ashrc
		;;
#	*)
#		export ENV=$HOME/.shrc
#		;;
	esac
	unset tsh
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
