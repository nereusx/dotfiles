#!/bin/sh
#
#	print a quote
#

echo -n "\033[36m"
if [ -r /usr/share/fortunes/diogenis.dat ]; then
	fortune diogenis
else
	fortune
fi
echo "\033[0m"
