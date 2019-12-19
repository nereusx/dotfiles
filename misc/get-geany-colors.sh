#!/bin/sh
cd /usr/src
if [ -d geany-themes ]; then
	cd geany-themes
	git pull
else
	git clone https://github.com/codebrainz/geany-themes
	cd geany-themes
fi
./install.sh
