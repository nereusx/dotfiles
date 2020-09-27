#

all: xde.bash

xde.bash: xde.database xde.awk
	awk -f xde.awk xde.database > xde.bash

clean:
	@rm xde.bash
