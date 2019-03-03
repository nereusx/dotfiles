# FDM, officially replacement of procmail

Once you get it installed, you'll find example configurations in /etc/fdm/examples.
Look them over then start up your own at

	~/.fdm.conf

Once you think you have a decent config set up, run fdm as so:

	fdm -vvvvnf ~/.fdm.conf

This will let you test you config for syntax errors before you go messing up your mail.
Once you have it passing for syntax, run

	fdm -vvvva <myaccountname> poll

and see if it can check your mailservers ok.

Finally, add

	fdm -vvvla <myaccount1> -a <myaccount2> fetch

or simply (-l = use log, -k = keep messages)

	*/5 * * * * /usr/bin/fdm -lk fetch

to your crontab with

	crontab -e
