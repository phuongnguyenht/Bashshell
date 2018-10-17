#!/bin/bash

outdir="/opt/FTP_VMS_POSTPAID"
host="x.y.z.t"
user="statuspp"
pass="statuspp123"

# -nd: khong tao directory hierarchy khi download ve
# -N: kiem tra thoi gian de chi download file moi nhat
# --directory-prefix: luu file ve mot folder nhat dinh
# -r: download recursively toan bo folder

options="-N -nd --directory-prefix=$outdir -r"

filename="VASGATE_`date +%Y%m%d`*"

wget $options ftp://$user:$pass@$host/$filename > /dev/null 2>&1 &
#wget $options ftp://$user:$pass@$host/ #> /dev/null 2>&1
~
