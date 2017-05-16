#!/bin/bash

	ls -1 | grep -Pio '.*trailer.*' | while read FILE
	do
		FILENAME=`basename "${FILE}"`
		EXT="${FILENAME##*.}"
		BASE="${FILENAME%.*}"
		echo detected ${FILE}
		echo base ${BASE}
		echo extension ${EXT}
		if [[ "${BASE}" =~ .*\[Trailer.*\]-trailer$ ]]; then
			echo appears to be correct trailer
		elif [[ "${BASE}" =~ .*\[Trailer.*\]$ ]]; then
			echo appears to just have [Trailer]
			rename -v 's/\[Trailer(.*)\]/[Trailer$1]-trailer/i' "${FILE}"
		elif [[ "${BASE}" =~ .*-trailer$ ]]; then
			echo appears to just have -trailer
			rename -v 's/-trailer/.[Trailer]-trailer/i' "${FILE}"
		else
			echo appears to be something else
		fi

		#		vidfile=${file/-thumb.jpg/.videoimage.jpg}
		#echo new name: ${vidfile}
			#	echo matched pattern
			#	rename -n 's/-trailer\.([^\.]+)$/[Trailer]-trailer.$1/' *-trailer.*
	done
