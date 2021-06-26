#!/bin/sh
set -e
. ./TTFDIR
#
echo "+ unzip"
tar xvf fonts-ubuntu.tar.gz -C $sysdir
echo "+ update font-cache"
fc-cache
echo "+ done"

