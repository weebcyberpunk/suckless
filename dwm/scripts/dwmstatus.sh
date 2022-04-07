#!/usr/bin/sh

BAT_NOTIFIED="no"
BAT_ALERTED="no"

while :
do

	# cmus widget
	STATUS=" "

	CMUS_ARTIST="$(cmus-remote -Q 2> /dev/null | grep ' artist ' | awk '{print substr($0, 12)}')"  
	CMUS_TRACK="$(cmus-remote -Q 2> /dev/null | grep ' title ' | awk '{print substr($0, 11)}')"
	CMUS_STATUS="$(cmus-remote -Q 2> /dev/null | grep 'status ' | awk '{print substr($2, 0)}')"

	if [ "$CMUS_ARTIST" = "" ]
	then
		STATUS="$STATUS nothing playing"

	else
		if [ "$CMUS_ARTIST" = "Various" ]
		then
			STATUS="$STATUS $CMUS_TRACK "
		else
			STATUS="$STATUS $CMUS_ARTIST - $CMUS_TRACK "
		fi

		if [ "$CMUS_STATUS" == "playing" ]
		then
			STATUS="$STATUS契"
		else
			STATUS="$STATUS"
		fi
	fi

	STATUS="$STATUS |"

	# pamixer volume
	STATUS="$STATUS  $(pamixer --get-volume-human)"

	STATUS="$STATUS | "

	# internet widget
	WLAN_STATUS=$(ip link | grep wlan0 | awk -F "," '{print $3}')
	ENP_STATUS=$(ip link | grep enp1s0 | awk '{print $9}')

	if [ "$WLAN_STATUS" = "UP" ]
	then
		STATUS="$STATUS直 "
	elif [ "$ENP_STATUS" = "UP" ]
	then
		STATUS="$STATUS爵 "
	else
		STATUS="$STATUS睊 "
	fi

	STATUS="$STATUS | "

	# battery widget and notify
	BATTERY="$(cat /sys/class/power_supply/BAT1/capacity)"
	CHARGING="$(cat /sys/class/power_supply/BAT1/status)"
	
	if [ $BATTERY != "" ]
	then
		if [ $CHARGING == "Charging" ]
		then
			STATUS="$STATUS $BATTERY%"
			BAT_NOTIFIED="no"
			BAT_ALERTED="no"

		else

			if [ $BATTERY -gt 80 ]
			then
				STATUS="$STATUS $BATTERY%"

			elif [ $BATTERY -gt 60 ]
			then
				STATUS="$STATUS $BATTERY%"

			elif [ $BATTERY -gt 40 ]
			then
				STATUS="$STATUS $BATTERY%"

			elif [ $BATTERY -gt 20 ]
			then
				STATUS="$STATUS $BATTERY%"

			elif [ $BATTERY -gt 10 ]
			then
				STATUS="$STATUS $BATTERY%"
				if [ "$BAT_NOTIFIED" == "no" ]
				then
					notify-send 'Low battery level.' 'Battery level is below 20%. Please connect the computer to the charger.'
					BAT_NOTIFIED="yes"
				fi

			else
				STATUS="$STATUS $BATTERY%"
				if [ "$BAT_ALERTED" == "no" ]
				then
					notify-send --urgency=critical 'Critical battery level.' 'Battery level is below 10%. Please connect the computer to the charger immediately.'
					BAT_ALERTED="yes"
				fi
				
			fi

		fi

	STATUS="$STATUS | "

	fi

	# date
	STATUS="$STATUS$(date +'%a %b %d, %H:%M')"

	xsetroot -name "$STATUS"

	# sleep so it doesn't take all our resources
	sleep 1m
done
