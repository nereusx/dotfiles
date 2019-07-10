#!/bin/sh
systemctl --user start pulseaudio.socket
systemctl --user start pulseaudio.service
