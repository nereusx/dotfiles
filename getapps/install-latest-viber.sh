#!/bin/sh

### install alien
if ! command -v alien >/dev/null 2>&1 ; then
	./install-latest-alien.sh
fi

###
#cd /usr/src

### install openssl-1.0
# wget https://www.openssl.org/source/openssl-1.0.2s.tar.gz
# tar xvfz openssl-1.0.2s.tar.gz
# cd openssl-1.0.2s
# ./config
# make
# make install
# cd -

cd /tmp

### install viber
rm -f viber.deb viber-*.tgz

echo '*** downloading...'
wget https://download.cdn.viber.com/cdn/desktop/Linux/viber.deb

echo '*** convert to tar.gz ...'
alien -t --scripts viber.deb

read -p "*** install (y/N) ? " yn
case $yn in
[yY]* )
	tar xvfz viber-*.tgz -C /
	break;;
esac

rm -f viber.deb viber-*.tgz

### run it
# /opt/viber/Viber &


