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
	*)
		export ENV=$HOME/.kshrc
		;;
	esac
elif [ -n "$YASH_VERSION" ]; then
	export ENV=$HOME/.yashrc
else
	export ENV=$HOME/.ashrc
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
