#!/bin/bash
shopt -s -o errexit
[ -d mint-themes ] && rm -rf mint-themes
git clone https://github.com/linuxmint/mint-themes
cd mint-themes
make && cp -rf usr/share/themes/* /usr/share/themes/
cd ..
rm -rf mint-themes

