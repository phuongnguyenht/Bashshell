#!/bin/bash

function logdate
{
  echo "$(date +'%Y-%m-%d %H:%M:%S'):"
}

if [ $# -ne 3 ]; then

        echo "2"
        exit 2
fi

source_dir=$1
dest_dir=$2
host=$3
user="root@"
opt="-varogzcp --progress"
opt2="--rsh=\'ssh -p 2250\'"

ping $host -c 1 > /dev/null 2>&1
if [ $? -ne 0 ]; then
        echo "3"
        exit 3
fi

#echo $input_file

ssh -p 2250 $user$host mkdir -p $dest_dir
if [ $? -ne 0 ]; then
        echo "4"
        exit 4
fi


echo -e "\n`logdate` rsync $opt $opt2 $source_dir $user$host":"$dest_dir > /dev/null 2>&1" >> /opt/scripts/sync.log
rsync --rsh='ssh -p 2250' $opt $source_dir $user$host":"$dest_dir >> /opt/scripts/sync.log


if [ $? -ne 0 ]; then
        echo "1"
        exit 1
else
        echo "0"
        exit 0
fi
