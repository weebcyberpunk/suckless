COUNT=1
while :
do
	PROCESS="$(pstree -lp | grep dwmstatus.sh | awk -F '---' '{print substr($2, 6)}' | sed -e 's/(//g' -e 's/)//g')"
	if [ -n $(echo $PROCESS | awk '$0 ~/[^0-9]/') ]
	then
		kill $PROCESS
		exit

	else
		if [ $COUNT -gt 10 ]
		then
			exit
		else
			sleep 1s
			$COUNT=$(expr $COUNT + 1)

			continue
		fi
	fi
done
