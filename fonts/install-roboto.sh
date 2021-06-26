#!/bin/sh
set -e
. ./TTFDIR
#
echo "+ unzip"
tar xvf fonts-roboto.tar.gz -C $sysdir
echo "+ update font-cache"
fc-cache
echo "+ done"

