#!/bin/sh

# --- PAGER ---
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
#LESS_TERMCAP_ZN=$(tput ssubm)
#LESS_TERMCAP_ZV=$(tput rsubm)
#LESS_TERMCAP_ZO=$(tput ssupm)
#LESS_TERMCAP_ZW=$(tput rsupm)
#LESSOPEN="|/usr/bin/source-highlight-esc.sh %s"
MOST_SWITCHES='-w'
MOST_EDITOR='jed %s -g %d'
PAGER=less
#PAGER=most
# --- end ---

# other settings
LS_OPTIONS='--color=auto'
BROWSER=firefox
cpus=$(cat /proc/cpuinfo | grep processor | tail -1 | sed 's/processor.*://g')
cpus=$(($cpus + 1))
MAKEFLAGS="-j$cpus"
__GL_YIELD='USLEEP'

