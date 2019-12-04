# -*- tab-width: 4; indent-tabs-mode: t; indent-style: tab; encoding: utf-8; -*-
umask 022
#limit coredumpsize 0

# if !interactive, exit
[[ $- =~ i ]] || exit

#
#	BASH settings
#
set -o emacs
set -o braceexpand
set -o noclobber

# Correct dir spellings
shopt -q -s cdspell
# Make sure display get updated when terminal window get resized
shopt -q -s checkwinsize
# Turn on the extended pattern matching features 
shopt -q -s extglob
# Append rather than overwrite history on exit
shopt -s histappend
# Make multi-line commandsline in history
shopt -q -s cmdhist 
shopt -q -s lithist
# Get immediate notification of bacground job termination
set -o notify 

PROMPT_COMMAND=()

set -a
[ -r ~/.environ ] && . ~/.environ
if [ -d ~/.cache ]; then
	HISTFILE=${HOME}/.cache/.bash_history
fi
HISTFILESIZE=2048
set +a
shopt -q -s mailwarn

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

### PROMPT

# colors
cblack="\033[30m"
cred="\033[1;31m"
cgreen="\033[1;32m"
cbrown="\033[1;33m"
cblue="\033[1;34m"
cmagenta="\033[1;35m"
ccyan="\033[1;36m"
cwhite="\033[1;37m"
creset="\033[0m"

# prompt selections
ctimecolor="$cmagenta"
cusercolor="$cbrown"
if [ $USERID -eq 0 ]; then
	cusercolor="$cred"
fi
chostcolor="$cgreen"
if [ -n "${REMOTEHOST-}" ]; then
	chostcolor="$cbrown"
fi
cdirxcolor="$cblue"
if [ $USERID -eq 0 ]; then
	cdirxcolor="$cmagenta"
fi

PS1="\[$cusercolor\]\u\[$chostcolor\]@\h \[$cdirxcolor\]\w\[$creset\]"
export PS1=$PS1' \$ '

unset cblack cred cgreen cbrown cblue cmagenta ccyan cwhite
unset cusercolor chostcolor cdirxcolor

# find escape sequence to change terminal window title
case "$TERM" in
  (xterm|xterm[+-]*|gnome|gnome[+-]*|putty|putty[+-]*|cygwin)
    _tsl='\033];' _fsl='\a' ;;
  (*)
    _tsl=$( (tput tsl 0; echo) 2>/dev/null |
    sed -e 's;\\;\\\\;g' -e 's;;\\033;g' -e 's;;\\a;g' -e 's;%;%%;g')
    _fsl=$( (tput fsl  ; echo) 2>/dev/null |
    sed -e 's;\\;\\\\;g' -e 's;;\\033;g' -e 's;;\\a;g' -e 's;%;%%;g') ;;
esac

# if terminal window title can be changed...
if [ "$_tsl" ] && [ "$_fsl" ]; then

	# set terminal window title on each prompt
	_set_term_title() {
	if [ -t 2 ]; then
    	printf "$_tsl"'%s@%s:%s'"$_fsl" "${LOGNAME}" "${HOSTNAME%%.*}" \
	      "${${PWD:/$HOME/\~}/#$HOME\//\~\/}" >&2
	fi 
	}
	PROMPT_COMMAND=("$PROMPT_COMMAND" '_set_term_title')

	# reset window title when changing host or user
	ssh() {
		if [ -t 2 ]; then printf "$_tsl"'ssh %s'"$_fsl" "$*" >&2; fi
		command ssh "$@"
		}
	su() {
		if [ -t 2 ]; then printf "$_tsl"'su %s'"$_fsl" "$*" >&2; fi
		command su "$@"
		}
	sudo() {
		if [ -t 2 ]; then printf "$_tsl"'sudo %s'"$_fsl" "$*" >&2; fi
		command sudo "$@"
		}
fi

# print file type when executing non-executable files
_file_type() {
	if [ -e "$1" ] && ! [ -d "$1" ]; then
		file -- "$1"
	fi
}
COMMAND_NOT_FOUND_HANDLER=("$COMMAND_NOT_FOUND_HANDLER" '_file_type "$@"')

HISTCONTROL=‘ignoredups’

#
#	functions
#
split() {
	# Usage: split "string" "delimiter"
	IFS=$'\n' read -d "" -ra arr <<< "${1//$2/$'\n'}"
	printf '%s\n' "${arr[@]}"
	}
remove_array_dups() {
    # Usage: remove_array_dups "array"
    declare -A tmp_array
    for i in "$@"; do
        [[ $i ]] && IFS=" " tmp_array["${i:- }"]=1
    done
    printf '%s\n' "${!tmp_array[@]}"
	}
getfilename() {	echo ${1##*/}; }
getdirname()  { local fn; fn=${1##*/}; echo ${1%"$fn"}; }
getbasename() {	local fn; fn=${1##*/}; echo ${fn%.*}; }
getfileext()  { local fb bn; fn=${1##*/}; bn=${fn%.*}; echo ${fn#"$bn"}; }

#
#	aliases
#
[ -r ~/.aliases ] && . ~/.aliases
alias reload='. ~/.bashrc'
alias hist='history $(tput lines)'
alias dirs='dirs -v'

# pick
list="fzy pick"
PICKER="none"
for e in $list; do
	if [ -n "$(command -vp $e)" ]; then
		PICKER="$e"
		break
	fi
done
export PICKER

_hc_cmd() {
	local x
	case $PICKER in
	fzy)	x="$(fc -lnr | fzy)";;
	pick)	x="$(fc -lnr | pick -S)";;
	esac
	if [[ -n "$x" ]]; then
		if [[ ! "$x" == "hc" ]]; then
			eval "$x"
		fi
	fi
	}
alias hc="_hc_cmd"
#[ -n "$PICKER" ] && bind '[5~':_hc_cmd

_go_back() {
	local x
	x="$(command dirs -l -p | ${PICKER})"
	if [[ -n "$x" ]]; then
		command cd "$x"
	fi
	}
alias go--='_go_back'
#[ -n "$PICKER" ] && bind '[6~':_go_back

_go_fwd() {
	local x
	x="$(ls -d1 */ --color=never | ${PICKER})"
	if [[ -n "$x" ]]; then
		command cd "$x"
	fi
	}
alias go++='_go_fwd'

# TUI: select from sub-directories to change directory
_go() {
	local x
	x="$*"
	if [[ -z "$x" || "$x" == '++' ]]; then
		_go_fwd
	elif [[ "$x" == '-' ]]; then
		command cd -
	elif [[ "$x" == '--' ]]; then
		_go_back
	else
		pushd "$x"
	fi
	}
alias go='_go'
alias cd='pushd'
complete -o dirnames go

if [[ -d ~/.config/lf ]]; then
	# ctr+/: run lfcd (change directory)
	export LF_HOME="${HOME}/.config/lf"
	[[ -e $LF_HOME/lfcd.sh ]] && source $LF_HOME/lfcd.sh
#	bind '"^_":"lfcd\C-m"'
fi

#	welcome screen
if shopt | grep '^login_shell.*on$' > /dev/null; then
	if [[ $TTY =~ tty* ]]; then
		/bin/echo -ne '\033='
	fi
	echo -e "Welcome to \033[1;36mBaSH\033[0m $BASH_VERSION"
	echo
	list=(diogenis neofetch screenfetch fortune)
	for e in ${list[@]}; do
		if which $e > /dev/null; then
			$e
			break
		fi
	done
fi
							
#	load local bashrc files
for e in ~/.bashrc-*; do
	[ -f $e ] && . $e
done

# clean up
unset _fsl _tsl e list
