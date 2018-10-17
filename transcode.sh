#!/bin/bash

function logdate
{
  echo "$(date +'%Y-%m-%d %H:%M:%S'):"
}


if [ $# -ne 1 ]; then
        echo "Usage: transcode.sh <input_file_path>"
        exit -1
fi

#Input & output directories
indir=$1
fix_outdir=/opt/media
curdir=`pwd`
code=0

today=`/bin/date +%Y%m%d`
outdir="$fix_outdir/$today"

mkdir -p "$outdir"

echo "`logdate` Transcoding $indir -> $outdir" >> /opt/scripts/transcode.log

#Check whether the file exists in the input folder
#cd $indir
ls "$indir" > /dev/null 2>&1
if [ $? -ne 0 ]; then
        code=1
        echo "$code-File does not exist"
        exit -1
fi

#If file exists, then transcode the input file
#file_without_ext=`echo "$indir" | sed 's/\(\.mp3$\|\.wav$\)//g'`
file_without_ext=`echo "$indir" | sed 's/\(\.mp3$\|\.wav$\)//g' | sed 's/ /-/g'`
file_with_3gp_ext="$file_without_ext"".3gp"
file_with_wav_ext="$file_without_ext"".wav"

#Copy original file to output folder for HTTP streaming
cp $indir $outdir

#ffmpeg -i "$indir" -acodec libopencore_amrnb -b:a 12k -ac 1 -ar 8000 -y "$file_with_3gp_ext" > /dev/null 2>&1
ffmpeg -i "$indir" -acodec libfaac -b:a 16k -ac 2 -ar 8000 -y "$file_with_3gp_ext" > /dev/null 2>&1
if [ $? -ne 0 ]; then
        code=2
        echo "$code-Error while transcoding version .3gp of the file"
        echo "$code-Error while transcoding version .3gp of the file" >> /opt/scripts/transcode.log
        exit -1
fi

ffmpeg -i "$indir" -acodec pcm_s16le -b:a 16k -ac 1 -ar 8000 -y "$file_with_wav_ext" > /dev/null 2>&1
if [ $? -ne 0 ]; then
        code=3
        echo "$code-Error while transcoding version .wav of the file"
        echo "$code-Error while transcoding version .wav of the file" >> /opt/scripts/transcode.log
        exit -1
fi

#Get only filename from absolute path
wavfile=`echo "$file_with_wav_ext" | gawk -F/ '{print $NF}'`
gpfile=`echo "$file_with_3gp_ext" | gawk -F/ '{print $NF}'`
origfile=`echo "$indir" | gawk -F/ '{print $NF}'`

cp "$file_with_3gp_ext" "$outdir"
cp "$file_with_wav_ext" "$outdir"

#Hint the transcoded file
cd "$outdir"
MP4Box -hint "$outdir"/"$gpfile" > /dev/null 2>&1
if [ $? -ne 0 ]; then
        code=4
#       echo $code
        echo "$code-Error when hinting file $outdir/$gpfile"
        echo "$code-Error when hinting file $outdir/$gpfile" >> /opt/scripts/transcode.log
        exit -1
fi

#Output the streaming link back
echo $code
echo "|media/$today/$origfile" 
echo "|$today/$gpfile"
echo "|$outdir/$wavfile"
echo "|$outdir"
echo "|$origfile"
echo "|$gpfile"
echo "|$today"

cd "$curdir" 
rm -f "$file_with_3gp_ext"
rm -f "$file_with_wav_ext"