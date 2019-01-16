#!/bin/sh
# **********************************************************
# Author: Nolove
# Description: Check service viettalk and move log to folder
#
# **********************************************************

DATE=`date +%Y%m%d`
now=`date +"%H%M"`
path="/opt/viettalk-server/log"
services="viettalk-server"
flog="viettalk.log"
file=$flog"_"$DATE".log"
for service in $services
do
	if (( $(ps -ef | grep -v grep | grep $service | wc -l) > 0))
	then
		echo "$service is running"
	else
		echo "$service is not running"
		cd /opt/viettalk-server
		if [ -f "$path/$file" ]
		then
        		echo "$file found."
        		mv $flog $flog"_"$DATE"_"$now".log"
			mv $flog $flog"_"$DATE"_"$now".log" log
			touch $flog && chmod 644 $flog
		else
        		echo "$file not found."
			mv $flog $flog"_"$DATE".log" 
			mv $flog"_"$DATE".log" log
			touch $flog && chmod 644 $flog
		fi
		nohup ./viettalk-server  -c server.conf  >  viettalk.log &
	fi
done
