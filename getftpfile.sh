#!/bin/bash 
#
####################################################
# Author: 
# Description: 
#   
#
####################################################


HOST=x.y.z.t        #This is the FTP servers host or IP address. 
USER=user           #This is the FTP user that has access to the server. 
PASS=passwd       #This is the password for the FTP user. 

LOGFILE="/opt/FTP/getfile.log"

# VMS generated a file with all subscriber status each day at 03:00 AM
REMOTEDIR=`date -d '-1day' '+%Y%m%d'`
LOCALDIR="/opt/FTP/$REMOTEDIR"
REMOTEFILE="$REMOTEDIR.txt"
LOCALFILE=$REMOTEFILE

mkdir -p $LOCALDIR || echo "`date '+%Y:%m:%d %H:%M:%S'`: ERROR - Cannot create folder $LOCALDIR"


getfile()
{
	# Uses the ftp command with the -inv switches.  
	#-i turns off interactive prompting. 
	#-n Restrains FTP from attempting the auto-login feature. 
	#-v enables verbose and progress.  

	ftp -inv $HOST << EOF 
	user $USER $PASS 
	lcd $LOCALDIR
	cd $REMOTEDIR
	get $REMOTEFILE

	bye 
	EOF
}


LOGDATETIME=`date '+%Y:%m:%d %H:%M:%S'`
cd $LOCALDIR

# Check if the file is already there in LOCAL
if [ -f "$LOCALFILE" ]
then
  echo "$LOGDATETIME: $LOCALFILE file already exists in $LOCALDIR." >> $LOGFILE
else
  getfile
  if [ -f "$LOCALFILE" ]
  then
     echo "$LOGDATETIME: Get $LOCALFILE file succeded." >> $LOGFILE
  else
     echo "$LOGDATETIME: ERROR - Get $LOCALFILE file failed. File not found." >> $LOGFILE
  fi
fi

exit
