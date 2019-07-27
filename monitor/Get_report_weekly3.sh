#!/bin/bash
PATH=/bin:/usr/bin:/usr/local/bin:/usr/X11R6/bin:/sbin:/usr/sbin:/usr/local/sbin
export PATH
source $HOME/.bash_profile
# Author LinhNB
# Email: linhnb@vivas.vn
# Shell script to monitor Gen process hang or not
echo "Filename is Get_report_weekly3.sh"
echo "Lastupdate: 2019-03-05"
###########################################################
# Some other variables here
###########################################################
today=`date +%Y-%m-%d`
currTime=`date +"%Y-%m-%d %H:%M:%S"`
currentDate=`date +%s`
path_script="/opt/Scripts"
report_bak="/opt/Scripts/report_bak"

########## Config info Database ###########################
DB_UserName="sms_ads"
DB_Password="smsmkt20180racl3Ads0302"
DB_Port="1521"
DB_SERVICE_NAME="smsmkt"
DB_Host_01="192.168.38.158"
DB_Host_02="192.168.38.157"

########## Config info Email #############################
server_mail="smtp.vivas.vn"
server_port="587"
email_from="support.smsmktstaging@vivas.vn"
email_from_pass="vivas@12!"
email_to="linhnb@vivas.vn" 
#email_to="dungdc@vivas.vn,hanm@vivas.vn,hocnv@vivas.vn,hungnm@vivas.vn,linhnb@vivas.vn,lanhtk@vivas.vn,quangnm@vivas.vn,lieuhth@vivas.vn"

######### Config time for report #########################
total_start_time=$(date -d "-1 day" +%Y%m01)
total_end_time=$(date -d "-0 day" +%Y%m%d)
week_start_time=$(date -d "-7 day" +%Y%m%d)
week_end_time=$(date -d "-0 day" +%Y%m%d)
week_end_time01=$(date -d "-1 day" +%Y%m%d)

############# Config file export ########################
QC_noimang=`echo QC_noimang_$week_start_time\_$week_end_time\.xls`
CSKH_noimang=`echo CSKH_noimang_$week_start_time\_time_$week_end_time\.xls`
QC_noimang_tichluy=`echo QC_noimang_tichluy_$total_start_time\_$total_end_time\.xls`
CSKH_noimang_tichluy=`echo CSKH_noimang_tichluy_$total_start_time\_$total_end_time\.xls`
QC_ngoaimang_tichluy=`echo QC_ngoaimang_tichluy_$total_start_time\_$total_end_time\.xls`
CSKH_ngoaimang_tichluy=`echo CSKH_ngoaimang_tichluy_$total_start_time\_$total_end_time\.xls`

echo "set linesize 8000 pagesize 0 colsep ','" > export.conf
echo "set heading on" >> export.conf
echo "feedback off" >> export.conf
echo "verify off" >> export.conf
echo "trimspool on" >> export.conf
echo "trimout on" >> export.conf
echo "SET MARKUP HTML ON">> export.conf
echo "set NLS_LANG=AMERICAN_AMERICA.AL32UTF8">> export.conf
echo "spool &1" >> export.conf
export_conf = `less export.conf`

##########################################################
# Get All Request For SQLPLUS 
##########################################################

cd $path_script
qc_noimang=`less temp_get_sql.sql | grep "QC_noimang_time"`
qc_noimang=`echo "${qc_noimang/QC_noimang_time/$week_start_time}"`
qc_noimang=`echo "${qc_noimang/week_end_time/$week_end_time}"`
less export.conf > qc_noimang.sql
echo "$qc_noimang" >> qc_noimang.sql
echo "spool off" >> qc_noimang.sql
echo "exit;" >> qc_noimang.sql

cskh_noimang=`less temp_get_sql.sql| grep "CSKH_noimang_time"`
cskh_noimang=`echo "${cskh_noimang/CSKH_noimang_time/$week_start_time}"`
cskh_noimang=`echo "${cskh_noimang/week_end_time/$week_end_time}"`
less export.conf > cskh_noimang.sql
echo "$cskh_noimang" >> cskh_noimang.sql
echo "spool off" >> cskh_noimang.sql
echo "exit;" >> cskh_noimang.sql

qc_noimang_tichluy=`less temp_get_sql.sql | grep "QC_noimang_tichluy_time"`
qc_noimang_tichluy=`echo "${qc_noimang_tichluy/QC_noimang_tichluy_time/$total_start_time}"`
qc_noimang_tichluy=`echo "${qc_noimang_tichluy/total_end_time/$total_end_time}"`
less export.conf  > qc_noimang_tichluy.sql
echo "$qc_noimang_tichluy" >> qc_noimang_tichluy.sql
echo "spool off" >> qc_noimang_tichluy.sql
echo "exit;" >> qc_noimang_tichluy.sql

cskh_noimang_tichluy=`less temp_get_sql.sql | grep "CSKH_noimang_tichluy_time"`
cskh_noimang_tichluy=`echo "${cskh_noimang_tichluy/CSKH_noimang_tichluy_time/$total_start_time}"`
cskh_noimang_tichluy=`echo "${cskh_noimang_tichluy/total_end_time/$total_end_time}"`
less export.conf  > cskh_noimang_tichluy.sql
echo "$cskh_noimang_tichluy" >> cskh_noimang_tichluy.sql
echo "spool off" >> cskh_noimang_tichluy.sql
echo "exit;" >> cskh_noimang_tichluy.sql

qc_ngoaimang_tichluy=`less temp_get_sql.sql | grep "QC_ngoaimang_tichluy_time"`
qc_ngoaimang_tichluy=`echo "${qc_ngoaimang_tichluy/QC_ngoaimang_tichluy_time/$total_start_time}"`
qc_ngoaimang_tichluy=`echo "${qc_ngoaimang_tichluy/total_end_time/$total_end_time}"`
less export.conf  > qc_ngoaimang_tichluy.sql
echo "$qc_ngoaimang_tichluy" >> qc_ngoaimang_tichluy.sql
echo "spool off" >> qc_ngoaimang_tichluy.sql
echo "exit;" >> qc_ngoaimang_tichluy.sql

cskh_ngoaimang_tichluy=`less temp_get_sql.sql | grep "CSKH_ngoaimang_tichluy_time"`
cskh_ngoaimang_tichluy=`echo "${cskh_ngoaimang_tichluy/CSKH_ngoaimang_tichluy_time/$total_start_time}"`
cskh_ngoaimang_tichluy=`echo "${cskh_ngoaimang_tichluy/total_end_time/$total_end_time}"`
less export.conf > cskh_ngoaimang_tichluy.sql
echo "$cskh_ngoaimang_tichluy" >> cskh_ngoaimang_tichluy.sql
echo "spool off" >> cskh_ngoaimang_tichluy.sql
echo "exit;" >> cskh_ngoaimang_tichluy.sql
sqlplus -s "$DB_UserName/$DB_Password@(DESCRIPTION=(LOAD_BALANCE=yes)(FAILOVER=YES)(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=$DB_Host_01)(PORT=$DB_Port))(ADDRESS=(PROTOCOL=TCP)(HOST=$DB_Host_02)(PORT=$DB_Port)))(CONNECT_DATA=(SERVER=dedicated)(SERVICE_NAME=$DB_SERVICE_NAME)))" @$path_script/qc_noimang.sql $QC_noimang
sqlplus -s "$DB_UserName/$DB_Password@(DESCRIPTION=(LOAD_BALANCE=yes)(FAILOVER=YES)(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=$DB_Host_01)(PORT=$DB_Port))(ADDRESS=(PROTOCOL=TCP)(HOST=$DB_Host_02)(PORT=$DB_Port)))(CONNECT_DATA=(SERVER=dedicated)(SERVICE_NAME=$DB_SERVICE_NAME)))" @$path_script/cskh_noimang.sql $CSKH_noimang
sqlplus -s "$DB_UserName/$DB_Password@(DESCRIPTION=(LOAD_BALANCE=yes)(FAILOVER=YES)(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=$DB_Host_01)(PORT=$DB_Port))(ADDRESS=(PROTOCOL=TCP)(HOST=$DB_Host_02)(PORT=$DB_Port)))(CONNECT_DATA=(SERVER=dedicated)(SERVICE_NAME=$DB_SERVICE_NAME)))" @$path_script/qc_noimang_tichluy.sql $QC_noimang_tichluy
sqlplus -s "$DB_UserName/$DB_Password@(DESCRIPTION=(LOAD_BALANCE=yes)(FAILOVER=YES)(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=$DB_Host_01)(PORT=$DB_Port))(ADDRESS=(PROTOCOL=TCP)(HOST=$DB_Host_02)(PORT=$DB_Port)))(CONNECT_DATA=(SERVER=dedicated)(SERVICE_NAME=$DB_SERVICE_NAME)))" @$path_script/cskh_noimang_tichluy.sql $CSKH_noimang_tichluy
sqlplus -s "$DB_UserName/$DB_Password@(DESCRIPTION=(LOAD_BALANCE=yes)(FAILOVER=YES)(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=$DB_Host_01)(PORT=$DB_Port))(ADDRESS=(PROTOCOL=TCP)(HOST=$DB_Host_02)(PORT=$DB_Port)))(CONNECT_DATA=(SERVER=dedicated)(SERVICE_NAME=$DB_SERVICE_NAME)))" @$path_script/qc_ngoaimang_tichluy.sql $QC_ngoaimang_tichluy
sqlplus -s "$DB_UserName/$DB_Password@(DESCRIPTION=(LOAD_BALANCE=yes)(FAILOVER=YES)(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=$DB_Host_01)(PORT=$DB_Port))(ADDRESS=(PROTOCOL=TCP)(HOST=$DB_Host_02)(PORT=$DB_Port)))(CONNECT_DATA=(SERVER=dedicated)(SERVICE_NAME=$DB_SERVICE_NAME)))" @$path_script/cskh_ngoaimang_tichluy.sql $CSKH_ngoaimang_tichluy

mkdir $today
mv $QC_noimang $today
mv $CSKH_noimang $today
mv $QC_noimang_tichluy $today
mv $CSKH_noimang_tichluy $today
mv $QC_ngoaimang_tichluy $today
mv $CSKH_ngoaimang_tichluy $today
zip -r $today.zip $today
echo -e "Bao cao san luong tu dong theo tuan! Thoi gian bao cao tuan tu ngay $week_start_time den ngay het ngay $week_end_time01 ! Thoi gian bao cao tich luy tu ngay $total_start_time den het ngay $week_end_time01 " | mailx -v -a $path_script/$today.zip -s "SMSMKT Bao cao SL Theo tung tuan" -S smtp-use-starttls -S ssl-verify=ignore -S smtp-auth=login -S smtp=smtp://$server_mail:$server_port -S from="$email_from(Ban Dich Vu Ky Thuat)" -S smtp-auth-user=$email_from -S smtp-auth-password=$email_from_pass -S ssl-verify=ignore -S nss-config-dir=~/.certs $email_to
mv $today.zip $report_bak
rm -rf $today

