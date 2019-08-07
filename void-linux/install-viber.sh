#!/bin/sh
xbps-install -y flatpak
[ ! -d ~/.bin ] && mkdir ~/.bin
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak update
flatpak install com.viber.Viber
cat << EOF > ~/.bin/viber
#!/bin/sh
exec flatpak run com.viber.Viber
EOF
chmod +x ~/.bin/viber

# ajust scaling
# exec env QT_SCALE_FACTOR=0.5 flatpak run com.viber.Viber


# === without flatpak ===
#
### install openssl-1.0
#
# wget https://www.openssl.org/source/openssl-1.0.2s.tar.gz
# tar xvfz openssl-1.0.2s.tar.gz
# cd openssl-1.0.2s
# ./config
# make
# make install
# cd -
#
### install alien
#
# cd missing-packages/alien-8.95
# ./Makefile.PL
# make
# make install
# cd -
#
### install viber
#
# wget https://download.cdn.viber.com/cdn/desktop/Linux/viber.deb
# alien -t --scripts viber.deb
# tar xvfz viber[TAB] -C /
#
### run it
#
# /opt/viber/Viber &
#

