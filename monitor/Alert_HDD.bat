@echo off
::Stak Scheduler dat gio.
set Drive=C:
for /F "tokens=7" %%a in ('fsutil volume diskfree %Drive% ^| find /i "# of free"') do set free=%%a
set free=%free:~0,-9%

for /F "tokens=6" %%b in ('fsutil volume diskfree %Drive% ^| find /i "# of bytes"') do set tall=%%b
set tall=%tall:~0,-9%

set /a c=free*100/tall
set /a use=100 - c

echo %use%

set Low_Disk=90

IF  %use% GTR %Low_Disk% (
  E: && cd D:\script\MySQL\bin
  mysql -ualerts2vms -palerts2vms1122334455 -h10.16.0.1 -e"use smsgw6x54;insert into msg_alerter(domain,threshold,issue,alertmsg,current_threshold,alert_status,level,groupname,sms_sent) values ('Full_HDD_server203.162.71.163',1,'full_hdd','Dung luong HDD O %Drive% Chiem %use%%% , Check Now','1','1','serious','admin','1');" 
) else (
echo DiskFree C: %free%G > D:\script\Alert_HDD\HDD_C.txt 
)

########

set Drive=D:
for /F "tokens=7" %%a in ('fsutil volume diskfree %Drive% ^| find /i "# of free"') do set free=%%a
set free=%free:~0,-9%

for /F "tokens=6" %%b in ('fsutil volume diskfree %Drive% ^| find /i "# of bytes"') do set tall=%%b
set tall=%tall:~0,-9%

set /a c=free*100/tall
set /a use=100 - c

echo %use%

set Low_Disk=90

IF  %use% GTR %Low_Disk% (
  E: && cd D:\script\MySQL\bin
  mysql -ualerts2vms -palerts2vms1122334455 -h10.16.0.1 -e"use smsgw6x54;insert into msg_alerter(domain,threshold,issue,alertmsg,current_threshold,alert_status,level,groupname,sms_sent) values ('Full_HDD_server203.162.71.163',1,'full_hdd','Dung luong HDD O %Drive% Chiem %use%%% , Check Now','1','1','serious','admin','1');" 
) else (
echo DiskFree D: %free%G > D:\script\Alert_HDD\HDD_D.txt 
)

##########

set Drive=F:
for /F "tokens=7" %%a in ('fsutil volume diskfree %Drive% ^| find /i "# of free"') do set free=%%a
set free=%free:~0,-9%

for /F "tokens=6" %%b in ('fsutil volume diskfree %Drive% ^| find /i "# of bytes"') do set tall=%%b
set tall=%tall:~0,-9%

set /a c=free*100/tall
set /a use=100 - c

echo %use%

set Low_Disk=90

IF  %use% GTR %Low_Disk% (
  E: && cd D:\script\MySQL\bin
  mysql -ualerts2vms -palerts2vms1122334455 -h10.16.0.1 -e"use smsgw6x54;insert into msg_alerter(domain,threshold,issue,alertmsg,current_threshold,alert_status,level,groupname,sms_sent) values ('Full_HDD_server203.162.71.163',1,'full_hdd','Dung luong HDD O %Drive% Chiem %use%%% , Check Now','1','1','serious','admin','1');" 
) else (
echo DiskFree F: %free%G > D:\script\Alert_HDD\HDD_F.txt
)