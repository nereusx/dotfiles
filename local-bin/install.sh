#!/bin/sh

dest=/usr/local/bin
if [ ! -d $dest ]; then
	mkdir -p $dest
	chown root:root $dest
	chmod 0755 $dest
fi
for f in *; do
	bas=${f%.*}
	ext=${f#"$bas"}
	if [ -z "$ext" -a -x "$bas" ]; then
		echo $f
		cp $f "$dest/$f"
	fi
done
#install -m 755 -o root -g root gitstatus.py $dest/gitstatus.py


