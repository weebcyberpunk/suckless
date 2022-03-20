#!/usr/bin/sh
slock &
systemctl suspend
while :
do
	if [ "$(pstree | grep slock)" != "" ]
	then
		sleep 5s

	else
		$HOME/.local/bin/dwm_refresh_status.sh
		exit

	fi
done
