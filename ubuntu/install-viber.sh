#!/bin/sh
apt install flatpak
[ ! -d ~/.bin ] && mkdir ~/.bin
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak -y update
flatpak -y install com.viber.Viber
cat << EOF > ~/.bin/viber
#!/bin/sh
exec flatpak run com.viber.Viber
EOF
chmod +x ~/.bin/viber



