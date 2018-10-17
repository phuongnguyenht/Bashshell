#!/bin/bash
# bash lay gia tri trong file a.txt ma khong cos trong file b.txt


for i in `cat a.txt`
do
        grep $i b.txt;
        result=`echo $?`
        if [ $result -gt 0 ]
        then
                echo $i >> c.txt;
        else
                echo  "so $i khong co trong file b.txt";
        fi
done