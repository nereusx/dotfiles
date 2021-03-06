#!/bin/tcsh -f

# install generic scripts
cd local-bin  && ./install.sh && cd ..
cd local-sbin && ./install.sh && cd ..

# fix JED installation path
if ( ! -d /usr/share/jed ) then
	mkdir /usr/share/jed
endif
if ( ! -l /usr/jed ) then
	ln -s /usr/share/jed /usr/jed
endif

#
if ( ! -f /etc/complete.tcsh ) then
	cp misc/complete.tcsh /etc
endif

# install configuration files
./misc/update-nano-syntax-files
./install-to-users \
	.tcshrc .zshrc .bashrc .environ .aliases \
	.bin .help .sounds \
	.jed .nanorc .grief .grinit .joerc .vimrc \
	.newsboat .mostrc \
	.gitconfig .config \
	.urxvt .xres .bc .tmux .tmux.conf

# rsync
if ( -d /srv/file-server ) then
	cp misc/fserv-sync /srv/file-server
endif

# various data files
cd icons      && ./install.sh && cd ..
cd wallpapers && ./install.sh && cd ..
cd sounds     && ./install.sh && cd ..

# post-install scripts
local-sbin/enable-bitmap-fonts


