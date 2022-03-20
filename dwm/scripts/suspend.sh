#!/usr/bin/sh
slock &
systemctl suspend
$HOME/.local/bin/dwm_refresh_status.sh
