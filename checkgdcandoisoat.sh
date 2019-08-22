#!/bin/bash

#############################
#Author: Phuong Nguyen
#Description: Monitor ma loi 08: Giao dich nghi van can kiem tra (topup pending / timeout) 
# Va ma loi 999: Loi He Thong
#
#############################
#yesterday
yesterday=`/bin/date -d '-2 day' +%Y-%m-%d`
today=`/bin/date +%Y-%m-%d`
err999=$(mysql -uroot -ppassword -s -N -e "SELECT count(id) cnt FROM smartgate.transaction_log where resp_code = 999 and created_at >= UNIX_TIMESTAMP('"$today"');")

if [ $err999 -eq "0" ]
then
	echo $err999
else
	echo "Co giao dich loi he thong bao Hai ÐT"
fi

err08=$(mysql -uroot -pVivas@123# -s -N -e "SELECT count(id) cnt FROM smartgate.transaction_log where resp_code = 8 and created_at >= UNIX_TIMESTAMP('"$today"');")

if [ $err08 -eq "0" ]
then
	echo $err08
else
	echo "Co thong bao giao dich can doi soat bao Hai ÐT"
fi
