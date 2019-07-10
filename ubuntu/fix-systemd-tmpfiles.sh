#!/bin/sh
cat /var/log/syslog | awk -f fix-tmpfiles-filter.awk


