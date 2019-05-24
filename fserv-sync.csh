#!/bin/tcsh -f

# rsyncd authorized user
set user=nikosc

# root directory of local file-server
set fserv_root = /srv/file-server

# server name
set server = srv-x230.local

### end ###

if ( $#argv > 0 ) then
	set todo = $1
	if ( $#argv > 1 ) then
		set dir = $2
	else
		echo "directory missing"
		exit 1
	endif
else
	echo "usage: ./fserv-sync.csh {send|fetch} {directory}"
	exit 1
endif

set rflags = "--verbose --progress --stats --compress"
set rflags = "$rflags --recursive --times --perms --links --delete"
set rflags = "$rflags --exclude '*bak' --exclude '*~'"
	
set rlocal  = "$fserv_root/$dir/"
set rserver = "rsync://${user}@${server}/$dir/"

# synchronize with the server
switch ( $todo )
case s:
case send:
	eval "rsync $rflags $rlocal $rserver"
	breaksw
case f:
case fetch:
case g:
case get:
	eval "rsync $rflags $rserver $rlocal"
	breaksw
endsw





