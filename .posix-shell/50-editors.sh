#!/bin/sh
# EDITORS

GRLIB="/usr/local/share/grief"
GRPATH=${HOME}/.grief-local:${GRLIB}/macros
GRFLAGS="--utf8=yes -m grief-rc"
GRTERM=linux
GRUTF8_FORCE=1
GRHELP="${GRLIB}/help"
GRDICTIONARIES="en,el"
GRDICTIONARY="/usr/share/aspell"

JED_HOME=$HOME/.jed
alias jed-prep='xjed -batch -n -l preparse'

# customise your favourite editor here; the first one found is used
list="jed gr nano joe vim vi"
for EDITOR in $list; do
	EDITOR=$(command -pv "$EDITOR") && break
done
VISUAL="$EDITOR"
FCEDIT="$EDITOR"
alias b="$EDITOR"
list="ht hte dhex mcedit"
for HEXEDITOR in $list; do
	HEXEDITOR=$(command -pv "$HEXEDITOR") && break
done
alias hexedit="$HEXEDITOR"


