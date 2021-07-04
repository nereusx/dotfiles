#!/bin/sh

chmod -R a-x,u+rwX,og-wx,og+X * .*
find . \( -name '*.sh' -o -name '*.csh' \)  -exec chmod +x \{\} \;

list=".bin local-bin local-sbin"
for d in $list; do
	chmod +x $d/*
done

