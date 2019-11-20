#!/bin/sh
# aliases

if [ "$DISTRO" = "void" ]; then
	man() { command man -O width=$(($(tput cols)-2)) "$@"; }
fi
alias source='. '

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias dmesg='dmesg --color=always'

alias ll='ls --color=auto -lha'
alias ls='ls --color=auto'

alias cls='clear'
alias whereami='echo "`hostname -f` (`hostname -i`):`pwd`"'
alias remake='make clean; make' # warning: 'remake' began gnu project to debug makefiles
dff()     { echo "Filesystem      Size  Used Avail Use% Mounted on";df -h | grep '^/dev/'; }
mounted() {	mount | grep -E '^(tmpfs|/dev)' | grep -Ev 'AppImage|/dev/shm|/dev/fuse'; }

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

alias tmux-reload='tmux source-file ~/.tmux.conf'
alias test-colors='for c in {0..15}; do tput setaf $c; echo colour$c; tput op; done'

# youtube-dl
alias yt-get-audio='youtube-dl -i -c --extract-audio --audio-format vorbis "$*"'
alias yt-get-plist='youtube-dl -i -c --extract-audio --audio-format vorbis -o "%(title)s.%(ext)s" "$*"'


# calc
_bc() { echo "$*" | bc -l; }
if [ ! -x "$(command -vp calc)" ]; then
	if [ -x "$(command -vp wcalc)" ]; then
		alias calc='wcalc'
	else
		alias calc='_bc'
	fi
fi

#
_amionline()   {
	offline=1
	ping 1.1.1.1 -c 1 -w 1 > /dev/null && offline=0
	return $offline;
}
alias amionline='[ _amionline ] && echo "\033[1;32mOnline\033[0m" || echo "\033[1;31mOffline\033[0m"'
alias psu='ps S -o pid,pri,pcpu,pmem,rss:6,user,group,cmd'

# git
_git_q() { git add . && git commit -m "quick and dirty fix" && git push; }
alias git-q='_git_q'
_git_s() { git add . && git commit -m \""$*"\" && git push; }
alias git-s='_git_s'
alias git-c='git checkout'
alias git-d='git diff'
alias git-l='git log'

# common packager for root
if [ $USERID -eq 0 ]; then
	if [ -x /usr/src/dotfiles/dist/$DISTRO/$DISTRO ]; then
		alias app="/usr/src/dotfiles/dist/$DISTRO/$DISTRO"
	elif [ -x /usr/src/dotfiles/dist/$DISTRO/app ]; then
		alias app="/usr/src/dotfiles/dist/$DISTRO/app"
	fi
fi

