#!/bin/sh
cd /usr/src
if [ -d tmux ]; then
	cd tmux
	git pull
else
	git clone https://github.com/tmux/tmux.git
	cd tmux
fi
sh autogen.sh
./configure && make && make install && make clean
