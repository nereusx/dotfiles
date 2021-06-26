#!/bin/sh
xbps-install -y flatpak
[ ! -d ~/.bin ] && mkdir ~/.bin
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak update
flatpak install com.viber.Viber
cat << EOF > ~/.bin/viber
#!/bin/sh
if [ -x /opt/viber/Viber ]; then
	exec /opt/viber/Viber
else
	exec flatpak run com.viber.Viber
fi
EOF
chmod +x ~/.bin/viber

# ajust scaling
# exec env QT_SCALE_FACTOR=0.5 flatpak run com.viber.Viber

