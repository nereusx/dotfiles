#!/bin/sh
git clone --depth 1 https://github.com/nana-4/materia-theme
cd materia-theme
sudo ./install.sh
cd ..
rm -r materia-theme
