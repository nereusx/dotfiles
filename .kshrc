# -- mode: sh; tab-size: 4; --
# pdksh startup

umask 022

# if non-interactive shell, exit
[[ -o interactive ]] || return

set -o emacs
set -o allexport
#set -o errexit

# load ~/.posix-shell/*
for script in ~/.posix-shell/*.sh; do
	[ -x $script ] && . $script
done

# PROMPT
PS1='\[$(tput bold)$(tput setaf 5)\]\A\[$(tput op)\] \[$(tput bold)$(tput setaf 2)\]\u'"@${HOSTNAME}\[$(tput op)\]"
PS1=$PS1' \w \$ '

# load local mkshrc files
for e in ~/.kshrc-*; do
	[[ -f $e ]] && . $e
done

# welcome screen
if [[ -o login ]]; then
	[[ $TTY == tty* ]] && /bin/echo -ne '\033='
	echo "Welcome to Korn Shell ($1) $KSH_VERSION"
	echo
	set -A list neofetch screenfetch diogenis fortunes
	for f in ${list[@]}; do
		if [[ -x $(command -vp $f) ]]; then
			$f;
			break
		fi
	done
fi
