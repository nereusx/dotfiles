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

#
#	ZSG ENVIRONMENT, OPTIONS
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
setopt no_bg_nice				# not renice background jobs
setopt complete_aliases			# don't expand aliases before completion has finished

# lexical
setopt c_bases
setopt octal_zeroes
setopt c_precedences
setopt interactive_comments

# other
setopt no_beep
unsetopt auto_cd
setopt no_bang_hist
#setopt extended_glob

#
#	Modules that we need
#
autoload -Uz colors parameter
#autoload -Uz curses
#autoload -Uz mathfunc
[[ $COLORTERM = *(24bit|truecolor)* ]] || zmodload zsh/nearcolor
autoload -Uz vcs_info

#
#	System Environment Variables
#

#	Common Environment Variables to all POSIX shells
setopt sh_word_split
[[ -r "${HOME}/.environ" ]] && source "${HOME}/.environ"
unsetopt sh_word_split

#	ZSH specific
colors
list=('fzy' 'pick')
PICKER='none'
for e in $list; do
	if [[ -x "$(command -vp $e)" ]]; then
		PICKER=$e
		break
	fi
done
export PICKER

# hostnames
hosts+=('github.com' 'sourceforge.net' 'freemail.gr'\
		'yandex.com' 'yandex.ru' 'duckduckgo.com')

# XDG
XDG_RUNTIME_DIR="/tmp/runtime-$USER"

# no more exports
unsetopt all_export

#
#	PROMPT
#
[[ -n "$functions[prompt]" ]] && prompt off

declare -A _ps
_ps[clock]="%F{magenta}"
if [ $USERID -eq 0 ]; then
	_ps[user]='%F{red}'
	_ps[dirs]='%F{magenta}'
else
	_ps[user]='%F{yellow}'
	_ps[dirs]='%F{blue}'
fi
if [ -n "${REMOTEHOST-}" ]; then
	_ps[host]='%F{yellow}'
else
	_ps[host]='%F{green}'
fi
#PS1="%B${_ps[clock]}%T%f ${_ps[user]}%n%f${_ps[host]}@%M%f ${_ps[dirs]}%38<..<%~%f%b %# "
PS1="%B${_ps[user]}%n%f${_ps[host]}@%M%f ${_ps[dirs]}%38<..<%~%f%b %# "

#
#	GIT PROMPT
#
_ps[frame]='%F{magenta}'
_ps[key1]='%F{white}'
_ps[key2]='%F{green}'

git_rprompt() {
	vcs_info
	if [[ -n $vcs_info_msg_0_ ]]; then
		echo "$vcs_info_msg_0_"
	else
		echo "${_ps[frame]}(%f%B${_ps[key1]}sys%f%b${_ps[frame]})-[?%? %f${_ps[key2]}%D{%H:%M}%f${_ps[frame]}]%f "
	fi
	}
RPROMPT='$(git_rprompt)'

#
#	ZSH Environment 
#
[[ -d "${HOME}/.cache" ]] && export HISTFILE="${HOME}/.cache/zsh.history"
[[ -d "${HOME}/.cache" ]] && export DIRSTACKFILE="${HOME}/.cache/zsh.dirs"

HISTSIZE=2048
SAVEHIST=${HISTSIZE}
DIRSTACKSIZE=128

# EMACS mode
bindkey -e

KEYTIMEOUT=1
MAILCHECK=60

#
#	Completion
#
autoload -Uz compinit
zmodload zsh/complist
compinit
_comp_options+=(globdots)

if [[ -d ~/.cache ]]; then
	zstyle ':completion:*' cache-path "${HOME}/.cache/zsh.completion-cache"
else
	zstyle ':completion:*' cache-path "${HOME}/.zsh-completion-cache"
fi
zstyle ':completion:*' use-cache off

zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)(CVS|\.git)'
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#(CVS|\.git)'
zstyle ':completion:*' rehash true max-errors 0 numeric
zstyle ':completion:*:functions' ignored-patterns '_*'

zstyle ':completion:*' show-ambiguity 1\;31
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %B%F{blue}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# Use zsh-completions if it exists
#[[ -e '/usr/share/zsh-completions'       ]] && fpath+=('/usr/share/zsh-completions')
#[[ -e '/usr/local/share/zsh-completions' ]] && fpath+=('/usr/local/share/zsh-completions')

# no menu, only list
unsetopt	menu_complete
unsetopt	auto_menu
setopt		auto_list
setopt		list_ambiguous
setopt		always_last_prompt

# kill correction by any means
CORRECT_IGNORE='*'
CORRECT_IGNORE_FILE='*'
unsetopt correct_all
unsetopt correct

#
#	Aliases
#

#	Common aliases to all POSIX shells
setopt sh_word_split
[[ -r "${HOME}/.aliases" ]] && source "${HOME}/.aliases"
unsetopt sh_word_split

#	ZSH specific
alias reload="source ${HOME}/.zshrc"
alias hist='history $(tput lines)'
alias dirs='builtin dirs -v'
setenv() { typeset -x "${1}${1:+=}${(@)argv[2,$#]}" }  # csh
alias save-last-cmd 'fc -ln -1 >> ~/.scrap'

# TUI: select from history to run again
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

# TUI: select from DIRSTACK to change directory
_go_back() {
	local x
	case $PICKER in
	fzy)	x="$(builtin dirs -v | fzy | cut -f1 )";;
	pick)	x="$(builtin dirs -v | pick -S | cut -f1 )";;
	esac
	if [[ -n "$x" ]]; then
		cd +$x
	fi
	}
alias go--='_go_back'

# TUI: select from local sub-directories
_go_fwd() {
	local x
	x="$(ls -d1 */ --color=never | $PICKER)"
	if [[ -n "$x" ]]; then
		cd "$x"
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
		cd -
	elif [[ "$x" == '--' ]]; then
		_go_back
	else
		pushd "$x"
	fi
	}
#alias go='_go'
go() { _go "$@" }
compdef -d go
zstyle ':completion:*:*:go:*:directories' verbose yes


#
#	File-type handle - and suffix aliases
#

# open for view
xopen() {
	local f
	for f in $*; do
		case $f in
		(*.pdf)	okular "$f";;
		(Makefile) ;&
		(*.(txt|inf|log|css|sh|csh|zsh|c|h|pas|tex))
				${PAGER-less} "$f";;
		(*.md)	mdcat "$f" | ${PAGER-less}
		(*.(htm|html))
				firefox "$f";;
		(*.menu)
				pick "$f";;
		(*.(mp3|ogg|wav|mp4))
				vlc "$f";;
		(*.(png|jpg|gif))
				ristretto "$f";;
#				gwenview "$f";;
		(*.[1-8].gz) ;&
		(*.[1-8]) ;&
		(*.(man|mdoc|ms|me|mom))
				xview-roff "$f";;
		(*)	echo "this file-type ($(file \"$f\")) it is not specified yet."
			return 1
		esac
	done
	}

# open for editing
xedit() {
	local f
	for f in $*; do
		case $f in
		(.*rc|Makefile) ;&
		(*.(txt|inf|log|note|sh|csh|zsh|c|h|pas|php|awk|sh|md|tex|menu))
				${EDITOR-vi} "$f";;
		(*.(htm|html|css))
				${EDITOR-vi} "$f";;
		(*.(mp3|ogg|wav|mp4))
				audiocity "$f";;
		(*.(sfd|ttf|otf|bdf))
				fontforge "$f";;
		(*.(png|jpg|gif|bmp|tif))
				gimp "$f";;
		(*.[1-8]) ;&
		(*.(man|mdoc|ms|me|mom))
				${EDITOR-vi} "$f";;
		(*)	echo "this file-type ($(file \"$f\")) it is not specified yet."
			return 1
		esac
	done
	}

# extract compressed files
extract() {
    if [ -f $1 ]; then
        case $1 in
		(*.tar.gz)      tar -zxvf $1						;;
		(*.tar.bz2)     tar -jxvf $1						;;
		(*.tar)         tar -xvf $1							;;
		(*.tgz)         tar -zxvf $1						;;
		(*.tbz2)        tar -jxvf $1						;;
		(*.gz)          gunzip $1							;;
		(*.bz2)         bunzip2 $1							;;
		(*.xz)          unxz $1								;;
		(*.Z)			uncompress $1						;;
		(*.(zip|ZIP))	unzip $1							;;
		(*.(rar|RAR))	unrar $1							;;
		(*.pax)			cat $1 | pax -r						;;
		(*.pax.Z)		uncompress $1 --stdout | pax -r		;;
		(*.cab)			cabextract $1						;;
		(*) echo "'$1' cannot be extracted/mounted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
    }

# standard tar-gz creator
function totgz() {
	local dir="$1"
	local tmp="/tmp/$1.tar"
	local -i sz

	if [[ $# -eq 0 ]] { echo "usage: totgz dirname"; return 1 }
	if [[ ! -d "$dir" ]] { echo "$dir" is not a directory; return 1 }
	# todo: parent=$dir:h; cd parent
	echo "Creating $tmp…";
	tar -cvf "$tmp" "$dir" > /dev/null || return 1;
	sz=$(stat -c"%s" "${tmp}" 2> /dev/null);
	echo "Compressing $tmp ($((sz / 1024)) KB)…";
	if [[ -f "${tmp}.gz" ]] rm "${tmp}.gz"
	gzip "$tmp" || return 1;
	sz=$(stat -c"%s" "$tmp.gz" 2> /dev/null);
	echo "${tmp}.gz ($((sz / 1024)) KB) created successfully.";
	}

# Suffixes
#alias -s pdf=okular
#alias -s txt=xopen
#alias -s 1=xview-roff
#alias -s 3=xview-roff

#
#	plugins manager (optional)
#
#		zsh-users/zsh-syntax-highlighting\
#		djui/alias-tips\
#		caarlos0/zsh-mkc\
#		caarlos0/zsh-open-github-pr\

# install: curl -L git.io/antigen > $ANTIGEN_PATH/antigen.zsh
ANTIGEN_PATH='/usr/local/bin'
if [[ -e "$ANTIGEN_PATH/antigen.zsh" ]]; then
	source "$ANTIGEN_PATH/antigen.zsh"
	antigen use oh-my-zsh
	list=(\
		git git-extras\
		zsh-users/zsh-completions\
		zsh-users/zsh-history-substring-search\
		)
	for e in $list; do
		antigen bundle $e
	done
	antigen apply
fi

#
#	login shell; Welcome screen
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

#
#	Load local RCs
#
setopt nonomatch
for e in ${HOME}/.zshrc-*; do
	[[ -r $e ]] && source $e
done
unsetopt nonomatch
