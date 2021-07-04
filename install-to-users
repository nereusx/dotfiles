#!/bin/tcsh -f
#
#	copy files or directories to all users and sets the ownership
#
#	usage:
#		install-to-users [directory [file [...]]]

set echo_style=both
foreach f ( $* )
	set src = $f
	if ( ! -e $src ) continue

	echo "root\t$src -> /root"
	cp -r $src /root
	foreach dir ( /home/* )
		if ( ! -l $dir ) then
			set name = $dir:t
			unset found
			id -u $name > /dev/null && set found
			if ( $?found ) then
				echo "$name\t$src -> $dir"
				cp -r $src $dir
				chown -R ${name}:${name} $dir/$f
			endif
		endif
	end
end

