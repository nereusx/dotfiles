#!/bin/sh
list="tmux-cpu tmux-battery"
# tmux-online-status
for m in $list; do
	rm -r $m
	git clone https://github.com/tmux-plugins/$m
	rm -r $m/.git
done

