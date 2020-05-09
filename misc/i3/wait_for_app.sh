#!/bin/bash

while ! /usr/bin/wmctrl -l | grep "$1" > /dev/null
do
        sleep 1
done
