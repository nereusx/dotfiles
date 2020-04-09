#!/bin/sh

### install openssl-1.0
#
# wget https://www.openssl.org/source/openssl-1.0.2s.tar.gz
# tar xvfz openssl-1.0.2s.tar.gz
# cd openssl-1.0.2s
# ./config
# make
# make install
# cd -
#

### install alien

cd missing-packages/alien-8.95
chmod +x Makefile.PL
./Makefile.PL
make
make install
cd -

### install viber

wget https://download.cdn.viber.com/cdn/desktop/Linux/viber.deb
alien -t --scripts viber.deb
tar xvfz viber-*.tgz -C /
rm viber.deb viber-*.tgz

### run it
#
# /opt/viber/Viber &
#

