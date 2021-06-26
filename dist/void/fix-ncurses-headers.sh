#!/bin/sh
#
#	fix compatibility issues with ncurses library headers
#

files="curses.h cursesm.h cursslk.h form.h term.h tic.h cursesapp.h cursesp.h eti.h menu.h ncurses_dll.h term_entry.h unctrl.h cursesf.h cursesw.h etip.h nc_tparm.h panel.h termcap.h"

if [ -d /usr/include/ncurses ]; then
	echo "ncurses directory already exists"
	exit 0
fi

missingfile=0
for f in $files; do
	if [ -f /usr/include/$f ]; then
		echo "/usr/include/$f --- OK"
	else
		echo "/usr/include/$f --- missing"
		missingfile=1
	fi
done

if [ $missingfile -eq 1 ]; then
	echo 
	echo "ERROR: Some files are missing; abort"
	exit 1
fi

mkdir /usr/include/ncurses
for f in $files; do
	mv /usr/include/$f /usr/include/ncurses/$f
	ln -svf /usr/include/ncurses/$f /usr/include/$f
done
ln -svf /usr/include/ncurses/curses.h /usr/include/ncurses/ncurses.h
ln -svf /usr/include/ncurses/ncurses.h /usr/include/ncurses.h
ln -svf /usr/include/ncurses /usr/include/ncursesw

echo "* done *"
