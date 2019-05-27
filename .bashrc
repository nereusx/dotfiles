# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
umask 022

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

#
if [ -f /etc/os-release ]; then
	. /etc/os-release
	DISTRO="$NAME"
	if [ "$DISTRO" == "void" ]; then
		DISTRO="Void"
	fi
	export DISTRO
else
	export DISTRO="$(uname -o)"
fi

# setup several local directories
backup=$HOME/.backup
if [ ! -d $backup ]; then
	# setup several local directories
	list=($backup $backup/text $backup/saves $HOME/.bin $HOME/.help $HOME/.misc)
	for e in $list; do
		if [ ! -d $e ]; then
			mkdir -p $e
			chmod 0700 $e
		fi
	done
fi

# setup and cleanup path
if [[ :$PATH: != *:"${HOME}/.bin":* ]] ; then
	export PATH="$HOME/.bin:$HOME/.help:$PATH"
fi
if [ -x '/bin/path++' ]; then
	export PATH=$(/bin/path++)
fi

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

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
color_prompt=yes

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\] \$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h \w \$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# settings for JED
export JED_HOME="${HOME}/.jed"
alias jed-prep='xjed -batch -n -l preparse'

# settings for GRIEF
export GRPATH="${HOME}/.grief-local/:/usr/share/grief/macros:/usr/local/share/grief/macros"
export GRFLAGS="-m grief-rc"
export GRUTF8_FORCE=1
export GRDICTIONARIES="en,el"
export GRDICTIONARY="/usr/share/aspell"

# select default editor
list=(jed gr nano joe vim vi emacs ed)
for e in $list; do
	if [ -x /usr/bin/$e ]; then
		export EDITOR=$e
		break
	fi
done
export VISUAL="$EDITOR"
alias edit="$EDITOR"

# select default hex editor
list=(hte mcedit dhex)
export HEXEDITOR="/usr/bin/od -t x1 "
for e in $list; do
	if [ -x /usr/bin/$e ]; then
		export HEXEDITOR=$e
		break
	fi
done
alias hexedit="$HEXEDITOR"
if [ -x /usr/bin/hexdump ]; then
	alias hexdump='hexdump -C'
else
	alias hexdump='od -t x1'
fi

# select BRIEF editor
alias b="$EDITOR"
list=(jed gr emacs nano)
for e in $list; do
	if [ -x /usr/bin/$e ]; then
		alias b="$e"
		break
	fi
done

### PAGER ###
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

# use make in so many threads as your processors
if [ -f /proc/cpuinfo ]; then
	cpus=$(cat /proc/cpuinfo | grep processor | tail -1 | sed 's/processor.*://g')
	let "cpus = $cpus + 1"
	export MAKEFLAGS="-j$cpus"
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -lha'
alias la='ls -A'
alias l='ls -CF'
alias cls='clear'
alias xcopy='rsync -ah --progress'
alias xmerge='xrdb -merge ~/.Xresources'
alias xmonitor-off='xset dpms force off'
DS='$'
alias ltrim="sed 's/^[ \t\n\r]*//'"
alias rtrim="sed 's/[ \t\n\r]*$DS//'"
alias trim="sed 's/^[ \t\n\r]*//;s/[ \t\r\n]*$DS//'"

list=(/var/log/socklog/messages/current /var/log/messages /var/log/syslog /var/log/dmesg.log /var/log/dmesg)
for e in $list; do
	if [ -f $e ]; then
		alias log30="tail -n 30 $e"
		break
	fi
done
if [ -f /var/log/apache2/error.log ]; then
	alias phplog='tail /var/log/apache2/error.log'
elif [ -f /var/log/httpd/error.log ]; then
	alias phplog='tail /var/log/httpd/error.log'
fi
alias netlog='netstat -lptu4'
alias whereami='echo "`hostname -f` (`hostname -i`):`pwd`"'

if [ "$DISTRO" == "Void" ]; then
	alias man="man -O width=$(tput cols) "
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

#####
for e in ~/.bashrc-*; do
	if [ -f $e ]; then
		. $e
	fi
done



