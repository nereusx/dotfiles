#!/bin/sh
#
#	empties all ~/.cache directories
#
list=$(awk -F: '{print $6}' /etc/passwd)
for dir in $list; do
	if [ ! "$dir" = "/proc" ]; then
		if [ -d "$dir/.cache" ]; then
			echo "rm -rf $dir/.cache/*"
			rm -rf $dir/.cache/*
		fi
	fi
done
