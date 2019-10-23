#!/bin/sh

dest=/usr/local/sbin
if [ ! -d $dest ]; then
	mkdir -p $dest
	chown root:root $dest
	chmod 0750 $dest
fi
for f in *; do
	fb="${f%%.*}"
	if [ -x "$fb" ]; then
		echo $f
		cp $f "$dest/$f"
	fi
done


