#!/bin/sh
if command -vp pman 2>&1 > /dev/null; then
	pear upgrade doc.php.net/pman
else
	pear install doc.php.net/pman
fi
