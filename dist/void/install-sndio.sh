#!/bin/sh
app=./void
$app -i sndio sndio-devel alsa-sndio mpg123-sndio pulseaudio-module-sndio
$app -e sndiod
