#! /bin/sh
/sbin/service iptables status >/dev/null 2>&1
if [ $? = 0 ]; then
    /sbin/service iptables stop
else
    echo "Firewall is not running. Quit game"
fi