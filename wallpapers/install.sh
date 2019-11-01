#!/bin/sh

list=(/usr/share/wallpapers /usr/share/backdrops /usr/share/backgrounds /usr/local/share/backgrounds)
for e in ${list[@]}; do
	if [ -d $e ]; then
		cp *.png $e
		exit 0
	fi
done
e=/usr/local/share/backgrounds
mkdir -p $e
cp *.png $e
