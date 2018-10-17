#!/bin/sh
# Script backup database and Compression file and delete file before 7 DAY

MYSQLDUMP=/usr/bin/mysqldump
BACKUPDIR=/backup/
DB_USER=root
DB_PASS=*********
DAY=7
DATE=`date -d now +%Y%m%d`
mkdir -p /backup/mysql_$DATE

echo 'GIO BAT DAU BACKUP: ' > /backup/mysql_$DATE.log
date >> /backup/mysql_$DATE.log

$MYSQLDUMP -u$DB_USER -p$DB_PASS --master-data=2 -R --events --databases database_name >/backup/mysql_$DATE/database_name.sql

echo 'GIO KET THUC BACKUP: ' >> /backup/mysql_$DATE.log
date >> /backup/mysql_$DATE.log

cd /backup/
tar -cvf mysql_$DATE.tar mysql_$DATE
rm -rf mysql_$DATE
find /backup/ -type f -mtime +$DAY | xargs rm -f

echo 'GIO NEN XONG, XOA FILE BACKUP CU XONG : ' >> /backup/mysql_$DATE.log
date >> /backup/mysql_$DATE.log