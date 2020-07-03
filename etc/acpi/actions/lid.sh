#!/bin/sh

# lid button pressed/released event handler
#logger "LID ARG $1 $2 $3"
if [[ "$2" == "LID" ]]; then
	if [[ "$3" == "close" ]]; then
		/etc/scripts/rc.suspend
	fi
	if [[ "$3" == "open" ]]; then
		/etc/scripts/rc.resume
	fi
fi
