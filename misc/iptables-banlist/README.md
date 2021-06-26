# BANLIST

Ban IP addresses with iptables.
Every IP connection source address is stored at `/proc/net/xt_recent/CHECKIP`.
The conditions to store in this list (such as destination port, not intranet address) are described in `iptables.rules`.

Every minute the cron runs `banlist-every-minute`. The last runs scripts that checks the CHECKIP list and decides what to do. For now only one script runs that decides to ban any IP that does not belongs to GR or CY country codes.


## install

1. modify `iptable.rules`

2. At `rc.local` add to load the necessary iptables module
```
	modprobe ipt_recent
```

3. crontab
```
	crontab -e
	*/1 * * * * /usr/local/sbin/banlist-every-minute
```
