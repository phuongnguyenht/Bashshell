#!/bin/bash

if [ $# -ne 1 ]; then
	        echo "Usage: rtranscode <absolute_path_to_file>"
		        exit -1
		fi

		pending_file=$1
		remote_indir=/opt/raws
		remote_outdir=/opt/media

		#Input file will be an argument mentioned in the command
		#Copy this file to Transcoding server

		cp $pending_file $remote_indir

		#Call transcode script to transcode this file
		/opt/scripts/transcode.sh $pending_file
