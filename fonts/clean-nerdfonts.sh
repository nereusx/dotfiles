#!/bin/sh
rm -f /usr/share/fonts/NerdFonts/ttf/Noto\ S*
rm -f /usr/share/fonts/NerdFonts/ttf/Noto\ E*
rm -f /usr/share/fonts/NerdFonts/otf/O*
rm -f /usr/share/fonts/NerdFonts/ttf/OpenD*
rm -f /usr/share/fonts/NerdFonts/ttf/3*
rm -f /usr/share/fonts/NerdFonts/ttf/M\+*
rm -f /usr/share/fonts/NerdFonts/ttf/Bi*
rm -f /usr/share/fonts/NerdFonts/ttf/Ios*
rm -f /usr/share/fonts/NerdFonts/ttf/Literation\ S*
rm -f /usr/share/fonts/NerdFonts/ttf/Tin*
rm -f /usr/share/fonts/NerdFonts/ttf/Ubu*
rm -f /usr/share/fonts/NerdFonts/ttf/R*
#rm -f /usr/share/fonts/NerdFonts/otf/3*
echo "+ update font-cache"
fc-cache
echo "+ done"
