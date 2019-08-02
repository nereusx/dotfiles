#!/bin/sh
apt-get upgrade
apt-get update
apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ disco main'
wget -nc https://dl.winehq.org/wine-builds/winehq.key && sudo apt-key add winehq.key
apt-get update
apt remove wine
apt install --install-recommends winehq-staging
ln -svf /opt/wine-staging/bin/wine /usr/bin/wine
ln -svf /opt/wine-staging/bin/wineserver /usr/bin/wineserver
