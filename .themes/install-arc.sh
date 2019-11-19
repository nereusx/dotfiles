#!/bin/sh
git clone https://github.com/horst3180/arc-theme --depth 1
cd arc-theme
./autogen.sh --prefix=/usr
make install
cd ..
rm -r arc-theme

