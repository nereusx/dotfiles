#

INSDIR = /bin
CFLAGS = -O -Wall -Wno-unused-result -static

all: path++

clean:
	rm path++

path++: pathpp.c
	gcc $(CFLAGS) pathpp.c -o path++

musl:
	musl-gcc $(CFLAGS) pathpp.c -o path++

install: path++
	install --mode=755 --owner=root --group=root -s path++ $(INSDIR)

