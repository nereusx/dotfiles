#!/bin/tcsh -f

set dest=/usr/local/bin
if ( ! -d $dest ) then
	mkdir -p $dest
	chown root:root $dest
	chmod 0755 $dest
endif
if ( "$1" == "-s" ) then
	foreach f ( * )
		if ( $f != "install.sh" ) then
			if ( -x $f ) then
				ln -svf "$PWD/$f" "$dest/$f"
			endif
		endif
	end
else
	cp * $dest
	rm $dest/install.sh
endif

