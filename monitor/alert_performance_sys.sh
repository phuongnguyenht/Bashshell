#!/bin/bash
PATH=/bin:/usr/bin:/usr/local/bin:/usr/X11R6/bin:/sbin:/usr/sbin:/usr/local/sbin
export PATH
# Author Hocnv
# Email: hocnv2010@gmail.com
# Shell script to monitor services running or not
echo "Filename is alert_performance_sys.sh"
echo "Lastupdate: 2019-01-03"
###########################################################
# Some other variables here
###########################################################
domain=VASDEALER
dbhost=192.168.40.240
dbuser=root
dbpass=passwd
dbschema=sendmailalert
IP_monitor=192.168.40.201
contact="xxxx"
currTime=`date +"%Y-%m-%d %H:%M:%S"`
nickname=vasadmin
#nickname=hocnv

SersMonitor=Server
diffTime=10 # min
##########################################################
# All Script Functions Goes Here
##########################################################

#### get cac tham so he thong
idle=`vmstat |awk '{print$15}' |grep [0-9]|head -1|tail -1`
iowait=`vmstat |awk '{print$16}' |grep [0-9]|head -1|tail -1`
loadavg=`cat /proc/loadavg |awk '{print$1}' |grep [0-9]|head -1|tail -1 |cut -c1`
realloadavg=`cat /proc/loadavg |awk '{print$1}' |grep [0-9]|head -1|tail -1`
freemem=`vmstat |awk '{print$4}' |grep [0-9]|head -1|tail -1`

#### Bat dau check
if (( $idle < 40 ))
then
/usr/bin/mysql -u $dbuser -h $dbhost -p$dbpass -e "use $dbschema; \
insert into msg_alerter(domain,threshold,issue,alertmsg,current_threshold,alert_status,level,contact,groupname) \
value ('$domain',40,'performance','server $IP_monitor idle la $idle, THAP, thoi diem: $currTime, Vao kiem tra CPU server ngay!!!','$idle','1','serious','$contact','$nickname');"
fi

if (( $iowait > 5 ))
then
/usr/bin/mysql -u $dbuser -h $dbhost -p$dbpass -e "use $dbschema; \
insert into msg_alerter(domain,threshold,issue,alertmsg,current_threshold,alert_status,level,contact,groupname) \
value ('$domain',5,'performance','server $IP_monitor iowait la $iowait, CAO, thoi diem: $currTime, Vao kiem tra server ngay!!!','$iowait','1','serious','$contact','$nickname');"
fi

if (( $loadavg > 10 ))
then
/usr/bin/mysql -u $dbuser -h $dbhost -p$dbpass -e "use $dbschema; \
insert into msg_alerter(domain,threshold,issue,alertmsg,current_threshold,alert_status,level,contact,groupname) \
value ('$domain',10,'performance','server $IP_monitor loadavg la $loadavg, CAO, thoi diem: $currTime, Vao kiem tra server ngay!!!','$loadavg','1','serious','$contact','$nickname');"
fi

#freemem=412000
if (( $freemem < 512000 ))
then
#const=1048576
const=1024
freememM=`echo "scale=2 ; ($freemem/$const)" | bc`

/usr/bin/mysql -u $dbuser -h $dbhost -p$dbpass -e "use $dbschema; \
insert into msg_alerter(domain,threshold,issue,alertmsg,current_threshold,alert_status,level,contact,groupname) \
value ('$domain','500MB','performance','server $IP_monitor free RAM la $freememM MB, THAP, thoi diem: $currTime, Vao kiem tra server ngay!!!','$freememM MB','1','serious','$contact','$nickname');"

message="server $IP_monitor free RAM la $freememM MB, THAP, thoi diem: $currTime, Vao kiem tra server ngay!!!"

/usr/bin/curl "http://10.149.58.233:2010/vasdealer.php?mesg=$message"

fi

if (( $freemem < 1024000 ))
then
        echo thuc hien clear cache
        /bin/sh /opt/Scripts/clear_cache.sh
fi


exit 0
