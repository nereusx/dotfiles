#!/bin/sh
#
#	Header
#

if [ -f /etc/motd-head ]; then
	cat /etc/motd-head
else
	echo
	echo "\033[1m\033[32mMessage Of The Day\033[0m"
	echo
fi
