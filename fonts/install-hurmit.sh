#!/bin/sh

set -e
. ./TTFDIR
#
echo "+ download..."
wget "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hermit/Medium/complete/Hurmit%20Medium%20Nerd%20Font%20Complete%20Mono.otf" 
wget "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hermit/Medium/complete/Hurmit%20Medium%20Nerd%20Font%20Complete.otf"
wget "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hermit/Bold/complete/Hurmit%20Bold%20Nerd%20Font%20Complete%20Mono.otf"
wget "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hermit/Bold/complete/Hurmit%20Bold%20Nerd%20Font%20Complete.otf"
wget "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hermit/Light/complete/Hurmit%20Light%20Nerd%20Font%20Complete%20Mono.otf"
wget "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hermit/Light/complete/Hurmit%20Light%20Nerd%20Font%20Complete.otf"
echo "+ copy to system directory"
mv Hurmit* $x11dir
echo "+ update font-cache"
fc-cache
echo "+ done"

