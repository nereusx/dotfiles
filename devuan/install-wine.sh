#!/bin/sh
sudo apt-get upgrade
sudo apt-get update
sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ disco main'
wget -nc https://dl.winehq.org/wine-builds/winehq.key && sudo apt-key add winehq.key
sudo apt-get update
sudo apt remove wine
sudo apt install --install-recommends winehq-staging
ln -svf /opt/wine-staging/bin/wine /usr/bin/wine
ln -svf /opt/wine-staging/bin/wineserver /usr/bin/wineserver
