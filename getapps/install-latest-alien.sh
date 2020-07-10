#!/bin/sh

vers=8.95

##
cd /usr/src
pkg=alien_$vers
pkgdir=alien-$vers
if wget https://downloads.sourceforge.net/project/alien-pkg-convert/release/${pkg}.tar.xz; then
	tar xvf ${pkg}.tar.xz
	cd ${pkgdir}
	chmod +x Makefile.PL
	./Makefile.PL
	make
	make install
	make clean
	rm ../${pkg}.tar.xz
fi
cd -
