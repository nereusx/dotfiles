#!/bin/tcsh -f

set dest=/usr/local/sbin
if ( ! -d $dest ) then
	mkdir -p $dest
	chown root:root $dest
	chmod 0750 $dest
endif
if ( "$1" == "-s" ) then
	foreach f ( * )
		if ( $f:e == "" ) then
			if ( -x $f ) then
				ln -svf "$PWD/$f" "$dest/$f"
			endif
		endif
	end
else
	foreach f ( * )
		if ( $f:e == "" ) then
			if ( -x $f ) then
				cp $f $dest/$f
			endif
		endif
	end
endif

echo "the iptables.rules will be not installed"
