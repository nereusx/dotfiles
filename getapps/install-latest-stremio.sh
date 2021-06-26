#!/bin/sh

### install alien
if ! command -v alien >/dev/null 2>&1 ; then
	./install-latest-alien.sh
fi

###
cd /usr/src

###
pkgver=4.4.106
wget https://dl.strem.io/linux/v${pkgver}/stremio_${pkgver}-1_amd64.deb
alien -t --scripts stremio*.deb
tar xvfz stremio*.tgz -C /
rm stremio*.deb stremio*.tgz
rm -r /install

### run it
# /opt/viber/Viber &


