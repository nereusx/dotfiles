#!/bin/sh
cd /usr/src
pkg=alien_8.95
pkgdir=alien-8.95
if wget https://downloads.sourceforge.net/project/alien-pkg-convert/release/${pkg}.tar.xz; then
	tar xvf ${pkg}.tar.xz
	cd ${pkgdir}
	chmod +x Makefile.PL
	./Makefile.PL
	make
	make install
	make clean
	cd ..
	rm ${pkg}.tar.xz
fi
cd -
