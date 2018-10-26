#System uptime
uptime=`cat /proc/uptime | cut -f1 -d.`
upDays=$((uptime/60/60/24))
upHours=$((uptime/60/60%24))
upMins=$((uptime/60%60))
upSecs=$((uptime%60))

echo "
===========================================================================
 - Hostname............: $HOSTNAME
 - Release.............: `cat /etc/redhat-release`
 - System uptime.......: $upDays days $upHours hours $upMins minutes $upSecs seconds
 - Users...............: Currently `users | wc -w` user(s) logged on
 - Current user........: $USER
===========================================================================
"

# MESSAGE=`/usr/bin/fortune | /usr/bin/cowsay -n`
# echo -e "$MESSAGE"

# time of day
# HOUR=$(date +"%H")
# if [ $HOUR -lt 12  -a $HOUR -ge 0 ]
# then    TIME="morning"
# elif [ $HOUR -lt 17 -a $HOUR -ge 12 ]
# then    TIME="afternoon"
# else
#     TIME="evening"
# fi