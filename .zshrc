# -*- mode: sh; tab-width: 4; indent-tabs-mode: t; indent-style: tab; encoding: utf-8; -*-
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
autoload -Uz run-help colors

#
#	ENVIRONMENT
#
setopt hist_no_store			# no store hist command
setopt hist_ignore_dups			# ignore duplicate last entry
#setopt hist_ignore_all_dups	# remove older duplicate entries from history
setopt hist_reduce_blanks		# remove superfluous blanks from history items
setopt inc_append_history		# save history entries as soon as they are entered
setopt share_history			# share history between different instances of the shell
setopt always_to_end			# move cursor to end if word had one match

setopt pushd_silent				# do not print when push in dirstack
setopt pushd_ignore_dups		# remove duplicated entries
setopt auto_pushd				# automatic save current directory before cd

setopt all_export				# export all new/modified variables
setopt prompt_subst				# allow functions in prompt

# lexical
setopt c_bases
setopt octal_zeroes
setopt c_precedences
setopt interactive_comments

emulate ksh
[[ -r ${HOME}/.environ ]] && source ${HOME}/.environ
emulate zsh

colors
list=(fzy pick)
pick_method=none
for e in $list; do
	if [[ -x "$(command -vp $e)" ]]; then
		pick_method=$e
		break
	fi
done

# hostnames
hosts+=(github.com sourceforge.net freemail.gr yandex.com yandex.ru duckduckgo.com)

unsetopt all_export				# stop automatic export variables

#
#	PROMPT
#
if whence -v prompt | grep function > /dev/null; then
    prompt off
fi
_ps[1]="%F{magenta}"
if [ $USERID -eq 0 ]; then
	_ps[2]="%F{red}"
	_ps[4]="%F{red}"
else
	_ps[2]="%F{yellow}"
	_ps[4]="%F{blue}"
fi
if [ -n "${REMOTEHOST-}" ]; then
	_ps[3]="%F{yellow}"
else
	_ps[3]="%F{green}"
fi
PS1="%B${_ps[1]}%T%f ${_ps[2]}%n%f${_ps[3]}@%M%f ${_ps[4]}%38<..<%~%f%b %# "
export PS1

#
[[ -d ${HOME}/.cache ]] && export HISTFILE=${HOME}/.cache/.zsh_history
[[ -d ${HOME}/.cache ]] && export DIRSTACKFILE=${HOME}/.cache/.zsh_dirs
HISTSIZE=2048
SAVEHIST=${HISTSIZE}
DIRSTACKSIZE=64
KEYTIMEOUT=1
MAILCHECK=0

# EMACS mode
bindkey -e

#
#	completion
#
autoload -Uz compinit
zmodload zsh/complete zsh/complist zsh/datetime
compinit
_comp_options+=(globdots)

unsetopt	menu_complete
unsetopt	auto_menu
setopt		auto_list
setopt		list_ambiguous
setopt		always_last_prompt

zstyle ':completion:*' rehash true max-errors 0 numeric
zstyle ':completion:*' show-ambiguity 1\;31
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# Use zsh-completions if it exists
if [[ -d "/usr/share/zsh-completions" ]]; then
    fpath=(/usr/share/zsh-completions $fpath)
fi
if [[ -d "/usr/local/share/zsh-completions" ]]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi

# kill correction by any means
unsetopt correct_all
unsetopt correct
CORRECT_IGNORE='*'
CORRECT_IGNORE_FILE='*'

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
setenv() { typeset -x "${1}${1:+=}${(@)argv[2,$#]}" }  # csh

_hc_cmd() {
	local x
	case $pick_method in
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

_go_back_cmd() {
	local x
	case $pick_method in
	fzy)	x="$(builtin dirs -v | fzy | cut -f1 )";;
	pick)	x="$(builtin dirs -v | pick -S | cut -f1 )";;
	esac
	if [[ -n "$x" ]]; then
		cd +$x
	fi
	}
alias cd--='_go_back_cmd'

_go_fwd_cmd() {
	local x
	case $pick_method in
	fzy)	x="$(ls -d1 */ --color=never | fzy)";;
	pick)	x="$(ls -d1 */ --color=never | pick)";;
	esac
	if [[ -n "$x" ]]; then
		cd "$x"
	fi
	}
alias cd++='_go_fwd_cmd'

_go_cmd() {
	local x
	x="$*"
	if [[ -z "$x" ]]; then
		_go_fwd_cmd
	elif [[ "$x" == "-" ]]; then
		_go_back_cmd
	else
		pushd "$x"
	fi
	}
alias go='_go_cmd'

#
#	GIT prompt
#
autoload -Uz vcs_info
precmd() {
	psvar=()
	vcs_info
	[[ -n $vcs_info_msg_0_ ]] && psvar[1]="$vcs_info_msg_0_"
	}

git_rprompt() {
#	echo "%m%(1v.%F{green}%1v%f.)"
	if [[ $#psvar -eq 0 ]]; then
		echo "(idle)"
	else
		echo $psvar[1]
	fi
	}

RPROMPT='$(git_rprompt)'

# plugins manager ?
#if [[ -x "$(command -vp antibody)" ]]; then
#	source <(antibody init)
#	[[ -r ~/.zsh_plugins.txt ]] && antibody bundle < ~/.zsh_plugins.txt
#fi

# install: curl -L git.io/antigen > $ANTIGEN_PATH/antigen.zsh
ANTIGEN_PATH=/usr/local/bin
if [[ -e $ANTIGEN_PATH/antigen.zsh ]]; then
	source $ANTIGEN_PATH/antigen.zsh
	antigen use oh-my-zsh
	list=(git\
		zsh-users/zsh-syntax-highlighting\
		zsh-users/zsh-completions\
		zsh-users/zsh-history-substring-search\
		djui/alias-tips\
		caarlos0/zsh-mkc\
		caarlos0/zsh-open-github-pr\
		)
	#antigen theme robbyrussell
	for e in $list; do
		antigen bundle $e
	done
	antigen apply
fi

#
#	login shell
#
if [[ -o login ]]; then
	list=(diogenis fortune neofetch)
	echo -e "Welcome to \033[1;32mZSH\033[0m $ZSH_VERSION"
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

#	Completion LIST/MENU options
#	again ... somewhere changed
unsetopt	menu_complete
unsetopt	auto_menu
setopt		auto_list
setopt		list_ambiguous
setopt		always_last_prompt
