# -*- tab-width: 4; indent-tabs-mode: t; indent-style: tab; encoding: utf-8; -*-
#
#	~/.bashrc
#	Nicholas Christopoulos (nereus@freemail.gr)
umask 022
#limit coredumpsize 0

# if !interactive, exit
[[ $- =~ i ]] || exit

#
#	BASH settings
#
set -o emacs
set -o allexport
set -o braceexpand
set -o noclobber
set -o notify
set +o errexit

PROMPT_COMMAND=()

bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

#
#	basic settings
#
DS='$'
[ $TERM == "rxvt" ] && TERM="rxvt-unicode"
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

# setup several local directories
backup=${HOME}/.backup
list="$backup $backup/text $backup/saves $HOME/.bin $HOME/.help $HOME/.misc"
for e in $list; do
	if [ ! -d $e ]; then
		mkdir -p $e
		chmod 0700 $e
	fi
done

# path
PATH=${HOME}/.bin:${HOME}/.help:$PATH
[ -x "/bin/path++" ] && PATH=$(/bin/path++)

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

#PS1='\u@\h \w \$ '
#PS1='\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\] \$ '
if [ $USERID -eq 0 ]; then
	PS1='\[\033[1;31m\]\u\[\033[0m\]'
else
	PS1='\[\033[1;32m\]\u\[\033[0m\]'
fi
if [ -n "${SSH_CONNECTION-}" ]; then
	PS1=$PS1'\[\033[1;31m\]@\h\[\033[00m\] '
else
	PS1=$PS1'\[\033[1;32m\]@\h\[\033[00m\] '
fi
PS1=$PS1'\[\033[1;34m\]\w\[\033[0m\] \$ '

#
#	--- EDITORS ---
#
GRPATH=${HOME}/.grief-local:/usr/share/grief/macros:/usr/local/share/grief/macros
GRFLAGS="-m grief-rc"
GRUTF8_FORCE=1
JED_HOME=$HOME/.jed
alias jed-prep='xjed -batch -n -l preparse'
# customise your favourite editor here; the first one found is used
list="jed gr nano joe vim vi"
for EDITOR in $list; do
	EDITOR=$(command -pv "$EDITOR") && break
done
VISUAL="$EDITOR"
FCEDIT="$EDITOR"
alias b="$EDITOR"
for HEXEDITOR in hte mcedit dhex; do
	HEXEDITOR=$(command -pv "$HEXEDITOR") && break
done
alias hexedit="$HEXEDITOR"

# --- PAGER ---
LESS='-R'
GROFF_ENCODING='utf8'
LESS_TERMCAP_mb='[1;31m'		# begin bold,			ANSI: [1m
LESS_TERMCAP_md='[1;36m'		# begin blink,			ANSI: [5m
LESS_TERMCAP_me='[0m'     	# reset bold/blink,		ANSI: [21m[25m
LESS_TERMCAP_so='[7m'			# begin reverse video,	ANSI: [7m
LESS_TERMCAP_se='[27m'		# reset reverse video,	ANSI: [27m
LESS_TERMCAP_us='[1;32m'		# begin underline,		ANSI: [4m
LESS_TERMCAP_ue='[0m'			# reset underline,		ANSI: [24m
LESS_TERMCAP_mr=$(tput rev)
LESS_TERMCAP_mh=$(tput dim)
#LESS_TERMCAP_ZN=$(tput ssubm)
#LESS_TERMCAP_ZV=$(tput rsubm)
#LESS_TERMCAP_ZO=$(tput ssupm)
#LESS_TERMCAP_ZW=$(tput rsupm)
#LESSOPEN="|/usr/bin/source-highlight-esc.sh %s"
MOST_SWITCHES='-w'
MOST_EDITOR='jed %s -g %d'
PAGER=less
#PAGER=most
# --- end ---

# other settings
LS_OPTIONS='--color=auto'
BROWSER=firefox
cpus=$(cat /proc/cpuinfo | grep processor | tail -1 | sed 's/processor.*://g')
cpus=$(($cpus + 1))
MAKEFLAGS="-j$cpus"
__GL_YIELD='USLEEP'

#
#	aliases
#
man() { command man -O width=$(tput cols) "$@"; }
alias source='. '

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias dmesg='dmesg --color=always'

alias ll='ls --color=auto -lha'
alias ls='ls --color=auto'

alias cls='clear'
alias whereami='echo "`hostname -f` (`hostname -i`):`pwd`"'
list="/var/log/messages\
	/var/log/socklog/messages/current\
	/var/log/current\
	/var/log/syslog\
	/var/log/dmesg.log\
	/var/log/dmesg"

for e in list; do
	if [ -r $e ]; then
		if [ -x "$(command -vp clog)" ]; then
			alias log30="tail -n 30 $e | clog"
		else
			alias log30="tail -n 30 $e"
		fi
		break
	fi
done
if [ -f /var/log/apache2/error.log ]; then
	alias phplog='tail /var/log/apache2/error.log'
elif [ -f /var/log/httpd/error.log ]; then
	alias phplog='tail /var/log/httpd/error.log'
fi
alias netlog='netstat -lptu4'
alias xmerge='xrdb -merge ~/.Xresources'
alias xmonitor-off='xset dpms force off'
alias cdwrite='xorrecord -v speed=16 dev=/dev/sr0 -eject blank=as_needed'
_bc() {
	echo "$*" | bc -l
	}
if [ ! -x "$(command -vp calc)" ]; then
	if [ -x "$(command -vp wcalc)" ]; then
		alias calc='wcalc'
	else
		alias calc='_bc'
	fi
fi

# git
_git_q() { _vcs add . && git commit -m "quick and dirty fix" && git push; }
alias git-q='_git_q'
_git_s() { _vcs add . && git commit -m \""$*"\" && git push; }
alias git-s='_git_s'
alias git-c='_vcs checkout'
alias git-d='_vcs diff'
alias git-l='_vcs log'

#
#	welcome screen
#
function _welcome {
	[[ $TTY =~ tty* ]] && /bin/echo -ne '\033='
	echo "Welcome to BaSH $BASH_VERSION"
	echo
	list="neofetch screenfetch diogenis fortunes"
	for f in $list; do
		if [ $(command -pv $f) ]; then
			$f;
			break
		fi
	done
}
#[ -o login_shell ] && _welcome
[[ $- =~ l ]] && _welcome
							
#	load local bashrc files
for e in ~/.bashrc-*; do
	[ -f $e ] && . $e
done

# clean-up
unset e f list cpus

# EOF
