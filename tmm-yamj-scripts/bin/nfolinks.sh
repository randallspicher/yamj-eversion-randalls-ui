#!/bin/bash

LANG=en_US.UTF-8
LOCALE=UTF-8
export LANG=en_US.UTF-8
export LOCALE=UTF-8
export PERL_UTF8_LOCALE=1 PERL_UNICODE=ASD

find . -type f -size 29c -name '*jpg' -exec rm -v {} \; 



symlinks -d .

DIRNAME=$(basename "$(pwd)")

#echo DIRNAME = ${DIRNAME}


if [ -e movie.nfo ]
then
	if [ -e VIDEO_TS ]
	then
		rm "${DIRNAME}".nfo
		ln -s movie.nfo "${DIRNAME}".nfo
	fi
	if [ -e BDMV ]
	then
		rm "${DIRNAME}".nfo
		ln -s movie.nfo "${DIRNAME}".nfo
	fi
fi




if [ -e tvshow.nfo ]
then
	name=$(grep -Po '(?i)<title>\K.*(?=</title>)' tvshow.nfo)

	name=${name/&amp;/&}

	echo ${name}
	
	if [ -e "${name}.nfo" ]
	then
		rm "${name}.nfo"
	fi
	ln -s tvshow.nfo  "${name}.nfo"
	
	
	#	echo doing symlinks
	rm "Set_${name}_1.jpg"
	ln -s  poster.jpg "Set_${name}_1.jpg"
	rm "Set_${name}_1.banner.jpg"
	ln -s banner.jpg "Set_${name}_1.banner.jpg" 
	rm "Set_${name}_1.fanart.jpg"
	ln -s fanart.jpg "Set_${name}_1.fanart.jpg" 
	ln -s poster.jpg folder.jpg
	#echo finished symlinks
	
	
	
	
	
	ls -1 | grep -Pio '(season\d\d)' | while read file
	do
		if [ ! -e "${file}" ]
		then 
			mkdir ${file}
		fi
		if [ -f "${file}-poster.jpg" ]
		then
			echo "linking poster ${file}-poster.jpg"
			rm "${file}/${file}.jpg"
			ln -s "../${file}-poster.jpg" "${file}/${file}.jpg"
			ln -s "../${file}-poster.jpg" "${file}/folder.jpg"
	
		fi
	
		if [ -f "${file}/banner.jpg" -a ! -h "${file}/banner.jpg" -a ! -f "${file}-banner.jpg" ]
		then
			mv -v "${file}/banner.jpg" "${file}-banner.jpg"
		fi
	
	
		if [ -f "${file}-banner.jpg" ]
		then
			echo "linking banner ${file}-banner.jpg"
			rm "${file}/${file}.banner.jpg"
			ln -s "../${file}-banner.jpg" "${file}/${file}.banner.jpg"
		fi
	
		if [ -f "${file}/fanart.jpg" -a ! -h "${file}/fanart.jpg" -a ! -f "${file}-fanart.jpg" ]
		then
			mv -v "${file}/fanart.jpg" "${file}-fanart.jpg"
		fi

		if [ -f "${file}-fanart.jpg" ]
		then
			echo "linking fanart ${file}-fanart.jpg"
			rm "${file}/${file}.fanart.jpg"
			ln -s "../${file}-fanart.jpg" "${file}/${file}.fanart.jpg"
		fi
	done


	file="season00"

	if [ -f "season-specials-poster.jpg" ]
	then
		echo "linking poster season-specials-poster.jpg"
		rm "${file}/${file}.jpg"
		ln -s "../season-specials-poster.jpg" "${file}/${file}.jpg"
		ln -s "../season-specials-poster.jpg" "${file}/folder.jpg"
	fi

	if [ -f "season-specials-banner.jpg" ]
	then
		echo "linking banner season-specials-banner.jpg"
		rm "${file}/${file}.banner.jpg"
		ln -s "../season-specials-banner.jpg" "${file}/${file}.banner.jpg"
	fi

	if [ -f "season-specials-fanart.jpg" ]
	then
		echo "linking fanart ${file}-fanart.jpg"
		rm "${file}/${file}.fanart.jpg"
		ln -s "../season-specials-fanart.jpg" "${file}/${file}.fanart.jpg"
	fi

fi


#if [ -e BDMV/movie.nfo ]
#then
#	ln -s BDMV/movie.nfo .
#fi


if [ -e movie.nfo ]
then
	name=$(grep -Po '(?i)<set>\K.*(?=</set>)' movie.nfo)


	name=${name/&amp;/&}

	echo SET=${name}
	

	if [ -e movieset-poster.jpg ]
	then
		rm "Set_${name}_1.jpg"
		ln -s  movieset-poster.jpg "Set_${name}_1.jpg"
	fi

	if [ -e movieset-folder.jpg ]
	then
		rm "Set_${name}_1.jpg"
		ln -s  movieset-folder.jpg "Set_${name}_1.jpg"
	fi


	if [ -e movieset-banner.jpg ]
	then
		rm "Set_${name}_1.banner.jpg"
		ln -s movieset-banner.jpg "Set_${name}_1.banner.jpg" 
	fi
	
	if [ -e movieset-fanart.jpg ]
	then
		rm "Set_${name}_1.fanart.jpg"
		ln -s movieset-fanart.jpg "Set_${name}_1.fanart.jpg" 
	fi
fi


	ls -1 | grep -Pio '(.*)-thumb.jpg' | while read file
	do
		#echo detected ${file}
		vidfile=${file/-thumb.jpg/.videoimage.jpg}
		#echo new name: ${vidfile}
		if [ -e "${vidfile}" ]
		then
				rm "${vidfile}"
		fi
		ln -s "${file}" "${vidfile}"
	
	done

#clean up any broken links we may have created
symlinks -d .

