#!/bin/bash
LANG=en_US.UTF-8
LOCALE=UTF-8
export LANG=en_US.UTF-8
export LOCALE=UTF-8
export PERL_UTF8_LOCALE=1 PERL_UNICODE=ASD

while (( "$#" )); do 
	origfile="$1"

	#echo orig: $origfile
	ext=${origfile##*.}
	fname=`basename "$origfile" $ext`
	FILEMKV="${fname}mkv" 

	if [ "$ext" = "webm" ]; then
		if [ -f "$origfile" ]; then
			ffmpeg -i "$origfile" "$FILEMKV" && rm "$origfile" 
		fi
	fi
	#echo $FILEMKV
shift
done


