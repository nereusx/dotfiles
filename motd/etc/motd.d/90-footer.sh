#!/bin/sh
#
#	footer
#

if [ -f /etc/motd-tail ]; then
	cat /etc/motd-tail
else
	# reset terminal attributes
	echo "\033[0m"
fi
