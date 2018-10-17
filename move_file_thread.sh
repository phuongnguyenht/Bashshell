#!/bin/bash
# Move file smaller than 3k
src="/opt/DOWNLOAD"
bak="/opt/BIG_FILE"
dest="/opt/FTP"
threshold=3000
cd $src
ls > $dest/temp.txt
while read file
do 
        size_file=$(du -sb $file | awk '{print $1}')
        if [ $size_file -lt $threshold ]
        then  
                mv -f $src/$file $dest
        else
                mv -f $src/$file $bak
        fi
done < $dest/temp.txt
echo "Author by: NoLove"