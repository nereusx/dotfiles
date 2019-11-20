#!/bin/sh
# EDITORS

# GRIEF
GRLIB="/usr/local/share/grief"
GRPATH="${HOME}/.grief-local:${GRLIB}/macros"
GRFLAGS="--utf8=yes -m grief-rc"
GRTERM="linux"
GRUTF8_FORCE=1
GRHELP="${GRLIB}/help"
GRDICTIONARIES="en,el"
GRDICTIONARY="/usr/share/aspell"

# JED
JED_HOME="$HOME/.jed"
alias jed-prep='xjed -batch -n -l preparse'

# customise your favourite editor here; the first one found is used
list="jed gr nano joe vim vi"
for EDITOR in $list; do
	EDITOR=$(command -pv "$EDITOR") && break
done
VISUAL="$EDITOR"
FCEDIT="$EDITOR"

# hexedit
list="ht hte dhex mcedit"
for HEXEDITOR in $list; do
	HEXEDITOR=$(command -pv "$HEXEDITOR") && break
done
alias hexedit="$HEXEDITOR"

# hexdump
if [ ! "$(command -vp hex)" ]; then
	if [ "$(command -vp hexdump)" ]; then
		alias hex='hexdump -C'
	else
		alias hex='od -t x1'
	fi
fi

# select BRIEF editor
alias b="$EDITOR"
list="jed gr nano"
for e in $list; do
	if [ "$(command -vp $e)" ]; then
		alias b="$e"
		break
	fi
done
