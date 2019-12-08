#!/bin/sh
cd /usr/src
if [ -d mdcat ]; then
	cd mdcat
	git pull
else
	git clone https://github.com/lunaryorn/mdcat
	cd mdcat
fi
cargo install .
cp ~/.cargo/bin/mdcat /usr/local/bin
cargo clean
rm -rf ~/.cargo

