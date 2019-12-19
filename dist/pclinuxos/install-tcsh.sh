#!/bin/sh

_create_links() {
	ln -svf /usr/bin/tcsh /bin/tcsh
	ln -svf /usr/bin/tcsh /bin/csh
	grep tcsh /etc/shells || echo '/bin/tcsh' >> /etc/shells
	}

if [ -d /usr/src/tcsh ]; then
	cd /usr/src/tcsh
	git pull
else
	cd /usr/src
	git clone https://github.com/tcsh-org/tcsh
	cd /usr/src/tcsh
fi
./configure --prefix=/usr && make && make install && _create_links

