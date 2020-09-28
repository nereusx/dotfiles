#!/bin/sh

### install viber

echo '*** downloading...'
wget https://download.cdn.viber.com/desktop/Linux/viber.AppImage

mv viber.AppImage /opt
chmod +x /opt/viber.AppImage

### run it
# /opt/viber/Viber &


