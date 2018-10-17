#!/bin/bash
DIR="/opt/vasgate/ftpUpload/mradio"
DEST="/opt/vasgate/ftpUpload/backup"
file=`ls $DIR`
FTPLOG=/var/log/ftplog/
day=`/bin/date +%Y-%m-%d`
file="ftp_$day.txt"

HOST="x.x.x.x"
USER="user"
PASSWD="passwd@123"
DATE=`date +%F_%H:%M:%S`;

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
	count=`cat $FTPLOG/$file | grep -e "bytes sent" | wc -l`
	echo "So luong File da sent la:"$count >> $FTPLOG/$file
else
	echo "$FILE send Fail cmnr.Goi admin send lai di ahihi"
fi
echo Author by: Nolove
