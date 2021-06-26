#!/bin/sh
go get -u github.com/gokcehan/lf
cp ~/go/bin/lf /usr/local/bin
cp ~/go/src/github.com/gokcehan/lf/lf.1 /usr/local/share/man/man.1
rm -rf ~/go
