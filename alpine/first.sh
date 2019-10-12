#!/bin/sh
apk update
apk add git mc nano joe wget less build-base slang-dev
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
#
DEFUSER="user"
read -p "Add default user: " DEFUSER
adduser $DEFUSER


