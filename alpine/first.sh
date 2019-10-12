#!/bin/sh
apk update
apk add git gcc mc nano joe wget
cd /usr
mkdir src
cd src
git clone https://github.com/nereusx/dotfiles
git clone https://github.com/nereusx/unix-utils
git clone https://github.com/nereusx/jed
git clone https://github.com/nereusx/xsg-fonts
# unmark repositories
nano /etc/apk/repositories
apk update
apk upgrade
adduser alpuser

