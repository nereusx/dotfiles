# -- mode: sh; tab-size: 4; --
# AT&T's ksh93 startup

#
umask 022

# if non-interactive shell, exit
[[ $- == *i* ]] || return

# login shell
#shopt -q login_shell && echo 'Login shell' || echo 'Not login shell'

# interactive shell
if [ -r /etc/os-release ]; then
	. /etc/os-release
	export DISTRO=${ID:-$NAME}
	export OSTYPE=${OSTYPE:-$(uname -s)}
else
	export DISTRO=$(uname -s)
	export OSTYPE=$(uname -s)
fi

#
if [ $TERM == "rxvt" ]; then
	export TERM=rxvt-unicode
fi

# setup several local directories
export backup=${HOME}/.backup
for e in $backup $backup/text $backup/saves $HOME/.bin $HOME/.help $HOME/.misc; do
	if [ ! -d $e ]; then
		mkdir -p $e
		chmod 0700 $e
	fi
done

PATH=${HOME}/.bin:${HOME}/.help:$PATH
if [ -x "/bin/path++" ]; then
	PATH=$(/bin/path++)
fi
export PATH

# PROMPT
# smul/rmul = underline, sitm/ritm = italics
# bold, setaf (forground), setab (background), op (reset)
PS1='$(tput bold)$(tput setaf 2)${USER:=$(id -un)}'"@${HOSTNAME:=$(hostname)}$(tput op)"
PS1=$PS1' $PWD '
if [[ $USER == root ]]; then
	PS1+="\# "
else
	PS1+="\$ "
fi
export PS1

# --- EDITORS ---
export GRPATH=${HOME}/.grief-local:/usr/share/grief/macros:/usr/local/share/grief/macros
export GRFLAGS="-m grief-rc"
export GRUTF8_FORCE=1
export JED_HOME=$HOME/.jed
alias jed-prep='xjed -batch -n -l preparse'
# customise your favourite editor here; the first one found is used
for EDITOR in jed gr joe nano emacs vi; do
	EDITOR=$(whence -p "$EDITOR") && break
done
export EDITOR
export VISUAL="$EDITOR"
alias b="$EDITOR"
for HEXEDITOR in hte mcedit dhex; do
	HEXEDITOR=$(whence -p "$HEXEDITOR") && break
done
alias hexedit="$HEXEDITOR"

# --- PAGER ---
export LS_OPTIONS='--color=auto'
export LESS='-R'
export GROFF_ENCODING='utf8'
export LESS_TERMCAP_mb='[1;31m'		# begin bold,			ANSI: [1m
export LESS_TERMCAP_md='[1;36m'		# begin blink,			ANSI: [5m
export LESS_TERMCAP_me='[0m'     	# reset bold/blink,		ANSI: [21m[25m
export LESS_TERMCAP_so='[7m'			# begin reverse video,	ANSI: [7m
export LESS_TERMCAP_se='[27m'		# reset reverse video,	ANSI: [27m
export LESS_TERMCAP_us='[1;32m'		# begin underline,		ANSI: [4m
export LESS_TERMCAP_ue='[0m'			# reset underline,		ANSI: [24m
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)
#export LESSOPEN="|/usr/bin/source-highlight-esc.sh %s"
export MOST_SWITCHES='-w'
export MOST_EDITOR='jed %s -g %d'
export PAGER=less
#export PAGER=most
# --- end ---

# other settings
export LS_OPTIONS="--color=auto"
export BROWSER=firefox
cpus=$(cat /proc/cpuinfo | grep processor | tail -1 | sed 's/processor.*://g')
cpus=$(($cpus + 1))
export MAKEFLAGS="-j$cpus"
export __GL_YIELD='USLEEP'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias dmesg='dmesg --color=always'

alias ll='ls --color=auto -lha'
alias ls='ls --color=auto'

alias cls='clear'
alias whereami='echo "`hostname -f` (`hostname -i`):`pwd`"'
for e in /var/log/socklog/messages/current /var/log/messages /var/log/syslog /var/log/dmesg.log /var/log/dmesg; do
	if [ -r $e ]; then
		if [ -x "$(command -v clog)" ]; then
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
function _bc {
	echo "$*" | bc -l
}
if [ ! -x "$(command -v calc)" ]; then
	if [ -x "$(command -v wcalc)" ]; then
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
for e in ~/.mkshrc-*; do
	if [ -f $e ]; then
		. $e
	fi
done