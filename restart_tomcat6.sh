#!/bin/bash

function logdate
{
        echo $(date "+%d/%m/%Y %T:")
}

function restart_tomcat6
{
        pid=`ps -ef | grep tomcat.6 | grep -v grep | awk '{print $2}'`
        if [[ -n "$pid" ]] 
        then
                echo "`logdate` Shuting down tomcat6"
                /opt/WEB/tomcat.6.0.33/bin/shutdown.sh
                sleep 10
                if [[ `ps -ef | grep $pid | wc -l` -gt 1 ]]
                then 
                        echo "`logdate` Kill tomcat PID $pid"
                        kill -9 $pid
                        sleep 1
                fi
        fi
        n=`ps -ef | grep tomcat.6 | grep -v grep | wc -l`
        if [[ $n -eq 0 ]] 
        then
                /opt/WEB/tomcat.6.0.33/bin/startup.sh
                pid=`ps -ef | grep tomcat.6 | grep -v grep | awk '{print $2}'`
                echo "`logdate` Startup Tomcat6....(pid $pid)"
        else
                echo "`logdate` $n Tomcat6 still running..."
        fi
}


echo "==================================================="

#1min load
#load=`uptime | cut -d":" -f5 | cut -d"." -f1`


#15min load
load=`uptime | cut -d":" -f5 | cut -d"," -f3 | cut -d"." -f1`
echo "`logdate` Check 15min load average: $load"
if [[ $load -ge 12 ]]
then
        echo "`logdate` [ERROR] Load average higher than 12"
        echo "`logdate` [INFO] Check FREE mem before restarting tomcat6"
        free -m
        top -n 1 | head
        restart_tomcat6
        echo "`logdate` [INFO] Done."
        echo "`logdate` [INFO] Check FREE mem after restarting tomcat6"
        free -m
        sync; echo 3 > /proc/sys/vm/drop_caches
fi