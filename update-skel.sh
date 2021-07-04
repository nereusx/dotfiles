#!/bin/sh
skeldir=/etc/skel
if [ -d $skeldir ]; then
	# clean up
	[ -d $skeldir/.tmux ] && rm -rf $skeldir/.tmux
	[ -d $skeldir/.bin  ] && rm -rf $skeldir/.bin
	[ -d $skeldir/.help ] && rm -rf $skeldir/.help
	[ -d $skeldir/.config ] && rm -rf $skeldir/.config
	[ -d $skeldir/.local ] && rm -rf $skeldir/.local
	[ -d $skeldir/.xres ] && rm -rf $skeldir/.xres
	
	# install
	cp -r .xfce4-autoexec .bin .help .config\
		.tcshrc .bashrc .zshrc .environ .aliases\
		.mostrc\
		.tmux .tmux.conf\
		.urxvt .xres .Xresources\
		.jed .nanorc .newsboat .bc\
		$skeldir
fi
