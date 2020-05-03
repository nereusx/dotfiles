#!/bin/sh
tcver=0
if [ -x /bin/tcsh ]; then
	tcver=$(tcsh --version | awk '{print $2}')
	echo "Your tcsh version is $tcver"
else
	echo "new installation"
fi
if [ -x /usr/bin/curl ]; then
	file=$(curl -s https://astron.com/pub/tcsh/ | awk -F\" '/"tcsh-.*gz"/{print $2}')
else
	echo "install curl before proceed"
	exit 1
fi
if [ "$file" != "" ]; then
	echo "File found @astron.com: $file"
	echo -n "Press ENTER to continue or Ctrl+C to cancel..."
	read a
	cd /usr/src
	if wget "https://astron.com/pub/tcsh/$file" ; then
		tar xvf tcsh-${pkgver}.tar.gz
		cd tcsh-${pkgver}
		./configure --prefix=/usr && make && make install && make clean && ln -svf /usr/bin/tcsh /bin/tcsh
		rm ../tcsh-${pkgver}.tar.gz
	fi
	cd -
else
	echo "failed to get the latest version"
fi
