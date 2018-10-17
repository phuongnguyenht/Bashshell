#!/bin/bash
#Author: HungHK
#Script: Remove empty files then archive & gzip all files bigger than a size given by an argument

##/tmp/logbackup/listbigfile.txt
TMP_BKP_DIR="/tmp/logbackup"
TMP_FILE_LIST="$TMP_BKP_DIR/listbigfile.txt"
FNAME=$(basename $0)
SCRIPT_LOG="/opt/scripts_bkp/${FNAME%.*}.log"

##### DEFAULT ARGUMENT ######
DIR="/opt"
SIZE=500
LIMIT=5  # 5Gig

##### FUNCTION ########
function logdate
{
	  echo "$(date +'%Y-%m-%d %H:%M:%S'):"
  }

  ###################
  # gzip & remove files bigger than "Size" MB and smaller than LIMIT 4 in "Dir"
  function gzipbigfile()
  {
	          dir=$1
		          size=$2
			          echo -e "\n`logdate` REMOVE empty files"
				          find $dir -empty -delete
					          #find $dir -type f -size +${size}M -size -${LIMIT}G ! -newermt 2013-05-24 | grep -v ".gz$" > $TMP_FILE_LIST
						          find $dir -type f -size +${size}M -size -${LIMIT}G -mtime +2 | grep -v ".gz$" > $TMP_FILE_LIST
							          #find $dir -type f -size +${size}M ! -newermt 2013-05-20 > $TMP_FILE_LIST

								          [ ! -s $TMP_FILE_LIST ] && { echo "`logdate` NO file FOUND bigger than $size MB in $dir. FINISH"; exit; }
									          echo "=============== `cat $TMP_FILE_LIST | wc -l` files FOUND ================"
										          ls -lh `cat $TMP_FILE_LIST`
											          echo "================================================"
												          echo "`logdate` START gzip & remove the log files bigger than $size MB in $dir"
													          echo "=================START=================="
														          for f in $(cat $TMP_FILE_LIST)
																          do
																		                  cd $(dirname $f)
																				                  #tar -czpPf $(basename $f).tgz $f --remove-files
																						                  tar -czpPf $(basename $f).tgz $(basename $f) --remove-files
																								                  ls -lh $f.tgz
																										          done
																											          echo "=================FINISH=================="
																											  }

																											  if [ $# = 2 ] 
																											  then
																												          dir=$1
																													          size=$2
																													  else
																														          dir=$DIR
																															          size=$SIZE
																															  fi

																															  [ ! -d $TMP_BKP_DIR ] && mkdir -p $TMP_BKP_DIR

																															  start=$(date +%s)
																															  echo -e "\n\n=============BACKUP BIGFILES===================" >> $SCRIPT_LOG 2>&1
																															  gzipbigfile $dir $size >> $SCRIPT_LOG 2>&1

																															  #echo -e "\n`logdate` Remove temp backup directory" 
																															  #rm -rf $TMP_BKP_DIR

																														  end=$(date +%s)
																														  echo -e "`logdate` FINISH!! The script ended in *** `date -d @$(($end-$start)) +%M:%S` *** seconds" >> $SCRIPT_LOG 2>&1
