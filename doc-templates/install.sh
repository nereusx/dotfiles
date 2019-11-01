#!/bin/sh
homes=/home/*
homes=$homes" /root"
for d in $homes; do
	ud=$d/.config/user-dirs.dirs
	if [ -e $ud ]; then
		td=$(cat $ud | grep '^XDG_TEMPLATES_DIR=' | cut -d= -f2 | xargs echo)
		td=${td#*/}
		u=${d##*/}
		for f in *; do
			if [ ! -x "$f" ]; then
				echo "$f --> $d/$td"
				cp "$f" "$d/$td/$f"
				chown $u:$u "$d/$td/$f"
			fi
		done
	fi
done
