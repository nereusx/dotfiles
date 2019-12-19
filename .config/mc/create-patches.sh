#!/bin/sh
cp mc.ext mc.ext.ndc
cp mc.menu mc.menu.ndc
cp /etc/mc/mc.ext .
cp /etc/mc/mc.menu .
diff -u mc.ext mc.ext.ndc > mc-ext-patch
diff -u mc.menu mc.menu.ndc > mc-menu-patch
path -p0 < mc-ext-patch
path -p0 < mc-menu-patch
