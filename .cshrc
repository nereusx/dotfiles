# -- mode: sh; encoding: utf-8; tab-size: 4; indent: 4; --
#
#	~/.cshrc
#	nicholas christopoulos (nereus@freemail.gr)
#

# Skip remaining steps if not an interactive shell
if ($?TERM == 0 || $?prompt == 0) exit

# global's
setenv LDFLAGS -L/usr/lib64
setenv MOST_SWITCHES "-w"
#setenv EDITOR		/usr/bin/joe
#setenv EDITOR		/usr/bin/nano
setenv EDITOR		/usr/bin/jed
setenv HEXEDITOR	/usr/bin/ht
setenv LS_OPTIONS	"--color=auto"

#
setenv JED_HOME		${HOME}/.jed

#
setenv GRPATH		${HOME}/.Grief/:/usr/share/grief/macros
setenv GRFLAGS		"-m grief-rc"

#
setenv LESS -R
#setenv LESSOPEN "|/usr/bin/source-highlight-esc.sh %s"

setenv LESS_TERMCAP_mb '[1;31m'
setenv LESS_TERMCAP_md '[1;36m'
setenv LESS_TERMCAP_me '[0m'
setenv LESS_TERMCAP_se '[0m'
setenv LESS_TERMCAP_so '[01;44;33m'
setenv LESS_TERMCAP_ue '[0m'
setenv LESS_TERMCAP_us '[1;32m'

setenv PAGER less

if ( $TERM == "rxvt" )	setenv TERM rxvt-unicode
if ( $TERM == "rxvt-unicode" || $TERM == "rxvt-unicode-256color" ) bindkey "^[[8~" end-of-line
if ( $TERM == "st-256color" ) bindkey "[P" delete-char

#
#	prompt
#
if ( $?tcsh == 0 ) then
	if ( $LOGNAME == "root" ) then
		set prompt="# "
	else
		set prompt="% "
	endif
else
	if ( $?TMUX == 0 ) then # default prompt (not tmux)
		set prompt="%{\033[32m%}%B%m%b %l %C4%# "
	else # screen/tmux/by
		set prompt="%B%l %{\033[32m%}%C4%b %# "
	endif
endif

set dunique

#
#	history
#
#	!n		A number, referring to a particular event
#	!−n		An offset, referring to the event n before the current event
#	#		The current event. This should be used carefully in csh(1), where there is no check for recursion. tcsh allows 10 levels of recursion. (+)
#	!		The previous event (equivalent to ‘−1’)
#	!s		The most recent event whose first word begins with the string s
#	!?s?	The most recent event which contains the string s. The second ‘?’ can be omitted if it is immediately followed by a newline.
#
set history=256
#set histdup=all
set histdup
set histlit
set nohistclop
alias hist 'history 20'

#
#	completion
#
#	complete [command [word/pattern/list[:select]/[[suffix]/] ...]] (+)
#
if ( $?tcsh ) then
	source /etc/tcshrc.complete

	uncomplete ln
	uncomplete mount
	
	complete set 'p/1/s/'
	complete unset 'p/1/s/'
	complete setenv 'p/1/e/'
	complete unsetenv 'p/1/e/'
	#(kinda cool: complete first arg with an env variable, and add an =, continue completion of first arg with a filename. complete 2nd arg with a command)
	complete env 'c/*=/f/' 'p/1/e/=/' 'p/2/c/'
	
	complete xdvi 'n/*/f:*.dvi/'
	complete latex 'n/*/f:*.{tex,ltx}/'
	complete pdflatex 'n/*/f:*.{tex,ltx}/'
	complete xelatex 'n/*/f:*.{tex,ltx}/'
	complete adb 'n/push/f:*.{apk}/'
	complete kill 'c/-/S/' 'c/%/j/' 'n/*/`ps -u $user | awk '"'"'{print $1}'"'"'`/'
endif

#
#	alieses
#
alias edit $EDITOR
alias hexedit $HEXEDITOR
alias remake 'make clean; make'
alias psaux 'ps aux k rss'
alias diogenis 'fortune diogenis'
alias free-h 'free -h'
alias df-h 'df -h'

# colorize
alias ls 'ls --color'
alias grep 'grep --color=auto'
alias egrep 'egrep --color=auto'
alias dmesg 'dmesg --color=always'

# info
alias log30 'tail -n 30 /var/log/messages'
alias netlog 'netstat -lptu4'

# environment
#alias beepcmd '/usr/bin/play -q /usr/share/sounds/shell-beep.mp3'
unalias beepcmd
set padhour

#alias helpcommand '\!:1 --help' 
alias helpcommand 'man \!:1' 

#EOF

