#!/usr/bin/sh

# author GG weebcyberpunk@gmail.com
# version 0.0.0
# since Apr 17, 2022

# lists artists and them their albuns on dmenu, to choose what to play in mpd

ARTIST="$(mpc ls | dmenu -p 'Artist: ')"
if [ "$ARTIST" != "" ]
then
	ALBUM=$(mpc ls "$ARTIST" | awk -F / '{print substr($2, 0)}' | dmenu -p 'Album: ')
	mpc clear
	if [ "$ALBUM" != "" ]
	then
		mpc add "$ARTIST/$ALBUM"
		mpc play
	else
		mpc add "$ARTIST"
		mpc play
	fi
fi
