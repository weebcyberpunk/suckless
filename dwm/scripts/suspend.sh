#!/usr/bin/sh
slock &
systemctl suspend
$HOME/.local/share/bin/dwm_refresh_status.sh
