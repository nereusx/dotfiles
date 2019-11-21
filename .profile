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
	*MIRBSD*)	rc="$HOME/.mkshrc" ;;
	*PD*KSH)	rc="$HOME/.ksh88rc" ;;
	^Version*)	rc="$HOME/.ksh93rc" ;;
	*)			rc="$HOME/.kshrc" ;;
	esac
	if [ -r $rc ]; then
		export ENV=$rc
	elif [ -r $HOME/.kshrc ]; then
		export ENV="$HOME/.kshrc"
	fi
elif [ -n "$YASH_VERSION" ]; then
	export ENV="$HOME/.yashrc"
else
	export ENV="$HOME/.ashrc"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
