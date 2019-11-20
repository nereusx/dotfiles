#!/bin/sh

# setup several local directories
backup=${HOME}/.backup
list="$backup $backup/text $backup/saves $HOME/.bin $HOME/.help $HOME/.misc"
for e in $list; do
	if [ ! -d $e ]; then
		mkdir -p $e
		chmod 0700 $e
	fi
done

# path
PATH=${HOME}/.bin:${HOME}/.help:$PATH
[ -x "/bin/path++" ] && PATH=$(/bin/path++)

