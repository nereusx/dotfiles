# -- mode: sh; tab-size: 4; --
# AT&T's ksh93 startup

# if non-interactive shell, exit
[[ $- == *i* ]] || return

set -o allexport
set -o emacs
#set -o errexit

umask 022

SHELL=$0
USER_UID=$(id -u)
[[ -z "$TTY" ]]  && TTY=$(tty|cut -f3-4 -d/)
[[ -z "$MAIL" ]] && MAIL="/var/mail/$USER"
MAILCHECK=600
HOSTNAME=$(hostname)

# login shell
#shopt -q login_shell && echo 'Login shell' || echo 'Not login shell'

# interactive shell
if [[ -r /etc/os-release ]]; then
	. /etc/os-release
	DISTRO=${ID:-$NAME}
	OSTYPE=${OSTYPE:-$(uname -s)}
else
	DISTRO=$(uname -s)
	OSTYPE=$(uname -s)
fi

# setup several local directories
backup=${HOME}/.backup
list=($backup $backup/text $backup/saves $HOME/.bin $HOME/.help $HOME/.misc)
for e in $list; do
	if [[ ! -d $e ]]; then
		mkdir -p $e
		chmod 0700 $e
	fi
done

PATH=${HOME}/.bin:${HOME}/.help:$PATH
[[ -x "/bin/path++" ]] && PATH=$(/bin/path++)

### Terminal & Keys
[[ $TERM == "rxvt" ]] && TERM=rxvt-unicode
function keyboard_trap {
case ${.sh.edchar} in
$'\e'[[O]F)   .sh.edchar=$'\cE';; # [END] = end-of-line
$'\e'[[\[]3~) .sh.edchar=$'\cD';; # [DEL] = delete-character
esac
}
trap keyboard_trap KEYBD

# PROMPT
#PS1='
#${LOGNAME}@${HOSTNAME} on ${TTY}
#[${PWD}] '
# smul/rmul = underline, sitm/ritm = italics
# bold, setaf (forground), setab (background), op (reset)
PS1='$(tput bold)$(tput setaf 2)${USER:=$(id -un)}'"@${HOSTNAME:=$(hostname)}$(tput op)"
PS1=$PS1' $PWD '
if [[ $USER == root ]]; then
	PS1+="\# "
else
	PS1+="\$ "
fi

# --- EDITORS ---
GRPATH=${HOME}/.grief-local:/usr/share/grief/macros:/usr/local/share/grief/macros
GRFLAGS="-m grief-rc"
GRUTF8_FORCE=1
JED_HOME=$HOME/.jed
alias jed-prep='xjed -batch -n -l preparse'
# customise your favourite editor here; the first one found is used
list=(jed gr joe nano emacs vi)
for EDITOR in $list; do
	EDITOR=$(whence -p "$EDITOR") && break
done
VISUAL="$EDITOR"
alias b="$EDITOR"
for HEXEDITOR in hte mcedit dhex; do
	HEXEDITOR=$(whence -p "$HEXEDITOR") && break
done
alias hexedit="$HEXEDITOR"

# --- PAGER ---
LS_OPTIONS='--color=auto'
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
LESS_TERMCAP_ZN=$(tput ssubm)
LESS_TERMCAP_ZV=$(tput rsubm)
LESS_TERMCAP_ZO=$(tput ssupm)
LESS_TERMCAP_ZW=$(tput rsupm)
#LESSOPEN="|/usr/bin/source-highlight-esc.sh %s"
MOST_SWITCHES='-w'
MOST_EDITOR='jed %s -g %d'
PAGER=less
#PAGER=most
# --- end ---

# other settings
LS_OPTIONS="--color=auto"
BROWSER=firefox
cpus=$(cat /proc/cpuinfo | grep processor | tail -1 | sed 's/processor.*://g')
cpus=$(($cpus + 1))
MAKEFLAGS="-j$cpus"
__GL_YIELD='USLEEP'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias dmesg='dmesg --color=always'

alias ll='ls --color=auto -lha'
alias ls='ls --color=auto'

alias cls='clear'
alias whereami='echo "`hostname -f` (`hostname -i`):`pwd`"'
list=(/var/log/current /var/log/socklog/messages/current /var/log/messages /var/log/syslog /var/log/dmesg.log /var/log/dmesg)
for e in $list; do
	if [[ -r $e ]]; then
		if [[ -x "$(command -v clog)" ]]; then
			alias log30="tail -n 30 $e | clog"
		else
			alias log30="tail -n 30 $e"
		fi
		break
	fi
done
if [[ -f /var/log/apache2/error.log ]]; then
	alias phplog='tail /var/log/apache2/error.log'
elif [[ -f /var/log/httpd/error.log ]]; then
	alias phplog='tail /var/log/httpd/error.log'
fi
alias netlog='netstat -lptu4'
alias xmerge='xrdb -merge ~/.Xresources'
alias xmonitor-off='xset dpms force off'
alias cdwrite='xorrecord -v speed=16 dev=/dev/sr0 -eject blank=as_needed'
function _bc {
	echo "$*" | bc -l
}
if [[ ! -x "$(command -v calc)" ]]; then
	if [[ -x "$(command -v wcalc)" ]]; then
		alias calc='wcalc'
	else
		alias calc='_bc'
	fi
fi
alias git-q='git add .; git commit -m "quick and dirty fix"; git push'
function _git_s {
	git add .
	git commit -m "$*"
	git push
}
alias git-s='_git_s'
if [[ $DISTRO == "void" ]]; then
	alias man='man -O width=$(tput cols) '
fi

# load local mkshrc files
for e in ~/.kshrc-*; do
	if [[ -f $e ]]; then
		. $e
	fi
done

unset e list cpus
