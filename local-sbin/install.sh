#!/bin/sh

dest=/usr/local/sbin
if [ ! -d $dest ]; then
	mkdir -p $dest
	chown root:root $dest
	chmod 0750 $dest
fi
for f in *; do
	bas=${f%.*}
	ext=${f#"$bas"}
	if [ -z "$ext" -a -x "$f" ]; then
		echo $f
		install -m 755 -o root -g root "$f" "$dest/$f"
	fi
done


