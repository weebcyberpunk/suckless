#!/usr/bin/sh

# author GG weebcyberpunk@gmail.com
# version 1.0.0
# since Mar 21, 2022

# send notify with libnotify with cmus info
notify () {

	CMUS_ARTIST="$(cmus-remote -Q 2> /dev/null | grep ' artist ' | awk '{print substr($0, 12)}')"  
	CMUS_ALBUM="$(cmus-remote -Q 2> /dev/null | grep ' album ' | awk '{print substr($0, 11)}')"  
	CMUS_TRACK="$(cmus-remote -Q 2> /dev/null | grep ' title ' | awk '{print substr($0, 11)}')"
	CMUS_TRACK_NUM="$(cmus-remote -Q 2> /dev/null | grep ' tracknumber ' | awk '{print substr($0, 17)}')"
	CMUS_STATUS="$(cmus-remote -Q 2> /dev/null | grep 'status ' | awk '{print substr($2, 0)}')"

	if [ "$CMUS_ARTIST" != "" ]
	then
		if [ "$CMUS_STATUS" == "playing" ]
		then
			CMUS_STATUS_ICON="契"

		else
			CMUS_STATUS_ICON=""
		fi

		notify-send --expire-time=3000 "$CMUS_TRACK_NUM - $CMUS_TRACK $CMUS_STATUS_ICON" "$CMUS_ARTIST - $CMUS_ALBUM"

	fi
}

# calls notify and refresh dwm panel
$HOME/.local/bin/dwm_refresh_status.sh
notify
