#!/bin/sh
cd /usr/src
pkgver=6.22.02
if wget https://astron.com/pub/tcsh/tcsh-${pkgver}.tar.gz ; then
	tar xvf tcsh-${pkgver}.tar.gz
	cd tcsh-${pkgver}
	./configure --prefix=/usr && make && make install && make clean && ln -svf /usr/bin/tcsh /bin/tcsh
	rm ../tcsh-${pkgver}.tar.gz
fi
cd -
