#!/bin/tcsh -f
ping 1.1.1.1 -c 1 -w 1 > /dev/null && set online
if ( $?online ) then
	echo "connected"
else
	echo "disconnected"
endif

