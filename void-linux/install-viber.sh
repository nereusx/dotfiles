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


