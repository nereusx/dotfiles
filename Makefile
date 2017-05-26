#

INSDIR = /bin
CC = gcc
CFLAGS = -std=c99 -O

all: path++

clean:
	rm path++

path++: pathpp.c
	$(CC) $(CFLAGS) pathpp.c -o path++

install: path++ gettermsize
	install --mode=755 --owner=root --group=root -s path++ $(INSDIR)

