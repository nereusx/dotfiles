#!/bin/csh -f
#
#	View man page for Xorg
#
# Copyright (C) 1998-2015 Nicholas Christopoulos (nereus@freemail.gr)ς
#
# This program and its data-file is free software: you can redistribute
# it and/or modify it under the terms of the GNU General Public License 
# as published by the Free Software Foundation, either version 3 of
# the License, or any later version.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#

set vw = xpdf
set vwlst = ( /usr/bin/qpdfview /usr/bin/evince /usr/bin/okular /usr/bin/xpdf )
foreach f ( $vwlst )
	if ( -e $f ) then
		set vw = $f
		break
	endif
end

set src = "$1"
if ( $#argv > 0 ) then
	set catcmd = cat
	if ( $src:e == "gz" ) then
		set catcmd = zcat
		set src = $src:r
	endif
	set tf = `mktemp -t xmanx-XXXXXXXX`
	set nf = ${tf}.ps
	mv $tf $nf
	set ext = $src:e
	switch ( $ext )
	case ms:
		$catcmd "$*" | groff -Tps -m ms > $nf
		breaksw
	case me:
		$catcmd "$*" | groff -Tps -m me > $nf
		breaksw
	case mm:
		$catcmd "$*" | groff -Tps -m mm > $nf
		breaksw
	case mdoc:
		$catcmd "$*" | groff -Tps -m mdoc > $nf
		breaksw
	case man:
	case [1-9n]:
		$catcmd "$*" | groff -Tps -m man > $nf
		breaksw
	default:
		$catcmd "$*" | groff -Tps -m mom > $nf
	endsw
	$vw $nf
	rm $nf
endif

