#!/bin/sh
xbps-remove pulseaudio rtkit
xbps-install -Sy \
autogen \
autoconf \
automake \
libsndfile-devel \
libltdl-devel \
gettext-devel \
alsa-lib-devel \
avahi-libs-devel \
speex-devel \
alsa-plugins-speex \
speex \
fftw \
fftw-devel \
libbluetooth libbluetooth-devel \
sbc sbc-devel \
json-c json-c++ json-c-devel \
libasyncns libasyncns-devel

# download
cd /usr/src
if [ -d pulseaudio ]; then
	cd pulseaudio
	git pull
else
	git clone git://anongit.freedesktop.org/pulseaudio/pulseaudio
	cd pulseaudio
fi

# build
./autogen.sh
./configure --prefix=/usr --enable-static-bins
make && make install
