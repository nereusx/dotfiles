#!/bin/sh
#
#	admin's message queue
#

if [ -f /etc/motd-queue ]; then
	cat /etc/motd-quote
else
	# no messages
	# print system info and the current date/time
	uname -a
	date
fi
