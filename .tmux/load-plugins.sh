#!/bin/bash

cd ~/.tmux/plugins
for dir in ~/.tmux/plugins/*; do
	if [ -d $dir ]; then
		for s in $dir/*.tmux; do
			if [ -x $s ]; then
				echo -n "$s: loading ... "
				$s && echo "activated" || echo "ERROR"
			fi
		done
	fi
done
