#!/bin/sh
#
#	Not Network-Manager yet?
#	setting up network with static IPs
#

# interface
dev=eth0

# my ip
xip=192.168.1.100

# router's ip
gw=192.168.1.254

#
ifconfig $dev $xip
route add -net 0.0.0.0 gw $gw
grep 1.1.1.1 /etc/resolv.conf > /dev/null || echo 'nameserver 1.1.1.1' > /etc/resolv.conf
