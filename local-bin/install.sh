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
	if [ -z "$ext" ]; then
		echo $f
		cp $f "$dest/$f"
	fi
done


