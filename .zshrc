# -- mode: shell; tab-width: 4; indent-tabs-mode: t; indent-style: tab; encoding: utf-8; --
#
#	~/.zshrc
#	Nicholas Christopoulos <mailto:nereus@freemail.gr>
#

# reset to zsh mode
emulate -RL zsh

# mode   umask
# 0777 - 0000 - extremly dangerous
# 0775 - 0002 - dangerous
# 0770 - 0007 - not so dangerous
# 0755 - 0022 - default
# 0750 - 0027 - logical
# 0700 - 0077 - nice
# 0000 - 0777 - paranoid
umask 022

# no coredumps
limit coredumpsize 0

# only interactive mode
[[ -o interactive ]] || exit

# modules that we need
autoload -Uz compinit run-help

#
#	ENVIRONMENT
#
setopt HIST_NO_STORE
setopt HIST_IGNORE_DUPS
setopt PUSHD_SILENT
setopt PUSHD_IGNORE_DUPS
setopt AUTO_LIST
setopt AUTO_PUSHD
setopt ALL_EXPORT

emulate ksh
[[ -r ${HOME}/.environ ]] && source ${HOME}/.environ
emulate zsh

list=(fzy pick)
pick_method=none
for e in $list; do
	if which $e > /dev/null; then
		pick_method=$e
		break
	fi
done

unsetopt ALL_EXPORT

#
#	PROMPT
#
prompt off
if [ $USERID -eq 0 ]; then
	_usercolor="%F{red}"
	_dirxcolor="%F{red}"
else
	_usercolor="%F{magenta}"
	_dirxcolor="%F{blue}"
fi
if [ -n "${REMOTEHOST-}" ]; then
	_hostcolor="%F{yellow}"
else
	_hostcolor="%F{green}"
fi
PS1="%T%B $_usercolor%n%f$_hostcolor@%M%f $_dirxcolor%38<..<%~%f%b %# "
export PS1

HISTSIZE=2048
SAVEHIST=2048
DIRSTACKSIZE=64
KEYTIMEOUT=1
MAILCHECK=0

#
#	completion
#
zmodload zsh/complete zsh/complist zsh/datetime
compinit
_comp_options+=(globdots)

zstyle ':completion:*' rehash true max-errors 0 numeric
unsetopt MENU_COMPLETE
setopt AUTO_LIST
setopt LIST_AMBIGUOUS
unsetopt AUTO_MENU

# EMACS mode
bindkey -e

#
#	Aliases
#
emulate ksh
[[ -r ${HOME}/.aliases ]] && source ${HOME}/.aliases
emulate zsh

alias reload="source ${HOME}/.zshrc"

alias help='run-help'
alias hist='history $(tput lines)'
alias dirs='builtin dirs -v'

case $pick_method in
fzy)	alias hc='x=$(fc -lnr | fzy) && eval $x';;
pick)	alias hc='x=$(fc -ln  | pick -S) && eval $x';;
esac

case $pick_method in
fzy)	alias go='x=$(builtin dirs -v | fzy | cut -f1);[ -n "$x" ] && cd +$x';;
pick)	alias go='x=$(builtin dirs -v | pick -S | cut -f1);[ -n "$x" ] && cd +$x';;
esac

# login shell
if [[ -o login ]]; then
	list=(diogenis fortune neofetch)
	echo "Welcome to ZSH $ZSH_VERSION"
	echo
	for e in $list; do
		if which $e > /dev/null; then
			$e
			break
		fi
	done
fi

# load local rcs
setopt nonomatch
for e in ${HOME}/.zshrc-*; do
	[[ -r $e ]] && source $e
done
unsetopt nonomatch

# Load zsh-syntax-highlighting; should be last
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

