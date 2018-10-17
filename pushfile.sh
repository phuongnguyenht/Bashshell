#!/bin/bash
HOST="b.a.y.x"
USER="user"
PASSWD="passwd"
phuong=`/bin/date -d '1 hour ago' +%Y_%m_%d_%H`
cd /opt/daily
sleep 1

FILE=`ls -t Report_*.xls| head -1`

ftp -n $HOST << EOF
quote USER $USER
quote PASS $PASSWD
binary
put $FILE
EOF
