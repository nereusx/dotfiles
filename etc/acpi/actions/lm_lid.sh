#!/bin/sh

test -f /lib/udev/lmt-udev || exit 0

# lid button pressed/released event handler
#logger "LID ARG $1 $2 $3"
if [[ "$3" == "close" ]]; then
	/etc/scripts/rc.suspend
fi
/lib/udev/lmt-udev
if [[ "$3" == "open" ]]; then
	/etc/scripts/rc.resume
fi
