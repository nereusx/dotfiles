#!/bin/sh

dpkg -i missing-packages/libssl1.0.0_1.0.2n-1ubuntu6.2_amd64.deb
wget https://download.cdn.viber.com/cdn/desktop/Linux/viber.deb
dpkg -i viber.deb && rm viber.deb

