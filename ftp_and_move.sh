#!/bin/bash
DIR="/opt/vasgate/ftpUpload/mradio"
DEST="/opt/vasgate/ftpUpload/backup"
file=`ls $DIR`
FTPLOG=/var/log/ftplog/
day=`/bin/date -d '-1 day' +%Y-%m-%d`
file="ftp_$day.txt"

HOST="x.y.z.t"
USER="mradio"
PASSWD="mradio@123"
DATE=`date +%F_%H:%M`;

cd $DIR
sleep 1
FILE=`ls -t *.txt| head -1`

ftp -n -v $HOST << END | tee /tmp/temp.txt
user $USER $PASSWD
put $FILE
END

Search=$FILE
FileToSearch="/tmp/temp.txt"
if grep $Search $FileToSearch; then
   echo $DATE >> $FTPLOG/$file
   echo "$FILE send OK"
   cat /tmp/temp.txt >> $FTPLOG/$file
   mv $FILE $DEST
else
   echo "$FILE send Fail cmnr.Goi admin send lai di ahihi"
fi
echo Author by: GCC