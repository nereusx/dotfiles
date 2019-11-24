# -*- tab-width: 4; indent-tabs-mode: t; indent-style: tab; encoding: utf-8; -*-
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

[ -r ~/.environ ] && . ~/.environ

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
cusercolor="$cgreen"
if [ $USERID -eq 0 ]; then
	cusercolor="$cred"
fi
chostcolor="$cgreen"
if [ -n "${REMOTEHOST-}" ]; then
	chostcolor="$cbrown"
fi
cdirxcolor="$cblue"
if [ $USERID -eq 0 ]; then
	cdirxcolor="$cred"
fi

#PS1='\u@\h \w \$ '
PS1="\[$cusercolor\]\u\[$chostcolor\]@\h \[$cdirxcolor\]\w\[$creset\]"
PS1=$PS1' \$ '

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

# aliases
[ -r ~/.aliases ] && . ~/.aliases
alias reload='. ~/.bashrc'

# pick
list="fzy pick"
pick_method="none"
for e in $list; do
	if [ -n "$(command -vp $e)" ]; then
		pick_method="$e"
		break
	fi
done
HISTCONTROL=‘ignoredups’
alias hist='history $(tput lines)'
#case $pick_method in
#fzy)
#	alias hc='x=$(history | fzy) && eval $x' 
#	alias go='x=$(dirs | fzy | awk '"'"'{print $1}'"'"'); [ -n "$x"] && cd =$x'
#	;;
#pick)
#	alias hc='x=$(history | pick -S) && eval $x'
#	alias go='x=$(dirs | pick -S | awk '"'"'{print $1}'"'"'); [ -n "$x" ] && cd =$x'
#	;;
#esac

#	welcome screen
if [[ -o login_shell ]]; then
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
fi
							
#	load local bashrc files
for e in ~/.bashrc-*; do
	[ -f $e ] && . $e
done

# clean up
unset _fsl _tsl f e list
