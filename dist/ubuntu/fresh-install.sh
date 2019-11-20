#!/bin/sh
/bin/echo -e "\033[32m=== basic and install generic packages ===\033[0m"
cat packages | xargs apt install -y
for ins in install-*.sh; do
	/bin/echo -e "\n\033[32m=== $ins ===\033[0m"
	./$ins
done
for ins in fix-*.sh; do
	/bin/echo -e "\n\033[32m=== $ins ===\033[0m"
	./$ins
done
/bin/echo -e "\n\033[32m=== /etc/default ===\033[0m"
cd etc/default
for ins in *; do
	if [ "$ins" -nt "/etc/default/$ins" ]; then
		echo $ins "-->" /etc/default/$ins
		cp $ins /etc/default/$ins
	fi
done
cd -
/bin/echo -e "\033[32m=== done ===\033[0m"
