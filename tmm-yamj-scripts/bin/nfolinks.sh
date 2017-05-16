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


if [[ -e movie.nfo ]]; then
	if [[ -e VIDEO_TS ]]; then
		if [ ! -L "${DIRNAME}".nfo ]
		then
			rm "${DIRNAME}".nfo
			ln -rs movie.nfo "${DIRNAME}".nfo
		fi	
	fi
	if [[ -e BDMV ]]; then
		if [[ ! -L "${DIRNAME}".nfo ]]; then
			rm "${DIRNAME}".nfo
			ln -rs movie.nfo "${DIRNAME}".nfo
		fi
	fi
fi

if [[ -e tvshow.nfo ]]; then
	name=$(grep -Po '(?i)<title>\K.*(?=</title>)' tvshow.nfo)

	name=${name/&amp;/&}

	echo ${name}
		
	#if [[ ! -L "${name}.nfo" ]]; then
	#	rm "${name}.nfo"
	#	ln -rs tvshow.nfo  "${name}.nfo"
	#fi
		
	
	#	echo doing symlinks
	
	if [[ ! -L "Set_${name}_1.jpg" ]]; then
		rm "Set_${name}_1.jpg"
		ln -rs  poster.jpg "Set_${name}_1.jpg"
	fi
	
	if [[ ! -L "Set_${name}_1.banner.jpg" ]]; then
		rm "Set_${name}_1.banner.jpg"
		ln -rs banner.jpg "Set_${name}_1.banner.jpg" 
	fi
	
	if [[ ! -L "Set_${name}_1.fanart.jpg" ]]; then
		rm "Set_${name}_1.fanart.jpg"
		ln -rs fanart.jpg "Set_${name}_1.fanart.jpg" 
	fi
	
	if [[ ! -L "folder.jpg" ]]; then
		ln -rs poster.jpg folder.jpg
	fi
	
	
	
	
	ls -1 | grep -Pio '(season\d+)' | while read file
	do
		if [[ ! -e "${file}" ]]; then 
			mkdir ${file}
		fi
		if [[ -f "${file}-poster.jpg" ]]; then
			if [[ ! -L "${file}/${file}.jpg" ]]; then
				echo "linking poster ${file}-poster.jpg"
				rm "${file}/${file}.jpg"
				ln -rs "${file}-poster.jpg" "${file}/${file}.jpg"
			fi
			if [[ ! -L "${file}/folder.jpg" ]]; then
				ln -rs "${file}-poster.jpg" "${file}/folder.jpg"
			fi
	
		fi
	
		if [[ -f "${file}/banner.jpg" && ! -h "${file}/banner.jpg" && ! -f "${file}-banner.jpg" ]]; then
			mv -v "${file}/banner.jpg" "${file}-banner.jpg"
		fi
	
	
		if [[ -f "${file}-banner.jpg" ]]; then
			echo "linking banner ${file}-banner.jpg"
			if [[ ! -L "${file}/${file}.banner.jpg" ]]; then
				rm "${file}/${file}.banner.jpg"
				ln -rs "${file}-banner.jpg" "${file}/${file}.banner.jpg"
			fi
			if [[ ! -L "${file}/banner.jpg" ]]; then
				ln -rs "${file}-banner.jpg" "${file}/banner.jpg"
			fi
		fi
	
		if [[ -f "${file}/fanart.jpg" && ! -h "${file}/fanart.jpg" && ! -f "${file}-fanart.jpg" ]]; then
			mv -v "${file}/fanart.jpg" "${file}-fanart.jpg"
		fi

		if [[ -f "${file}-fanart.jpg" ]]; then
			if [[ ! -L "${file}/${file}.fanart.jpg" ]]; then
				echo "linking fanart ${file}-fanart.jpg"
				rm "${file}/${file}.fanart.jpg"
				ln -rs "${file}-fanart.jpg" "${file}/${file}.fanart.jpg"
			fi
			if [[ ! -L "${file}/fanart.jpg" ]]; then
				ln -rs "${file}-fanart.jpg" "${file}/fanart.jpg"
			fi
		fi
	done


	file="season00"

	if [[ -f "season-specials-poster.jpg" ]]; then
		if [[ ! -L "${file}/${file}.jpg" ]]; then
			echo "linking poster season-specials-poster.jpg"
			rm "${file}/${file}.jpg"
			ln -rs "season-specials-poster.jpg" "${file}/${file}.jpg"
		fi
		if [[ ! -L "${file}/folder.jpg" ]]; then
			ln -rs "season-specials-poster.jpg" "${file}/folder.jpg"
		fi
	fi

	if [[ -f "season-specials-banner.jpg" ]]; then
		if [[ ! -L "${file}/${file}.banner.jpg" ]]; then
			echo "linking banner season-specials-banner.jpg"
			rm "${file}/${file}.banner.jpg"
			ln -rs "season-specials-banner.jpg" "${file}/${file}.banner.jpg"
		fi
		if [[ ! -L "${file}/banner.jpg" ]]; then
			ln -rs "season-specials-banner.jpg" "${file}/banner.jpg"
		fi
	fi

	if [[ -f "season-specials-fanart.jpg" ]]; then
		if [[ ! -L "${file}/${file}.fanart.jpg" ]]; then
			echo "linking fanart ${file}-fanart.jpg"
			rm "${file}/${file}.fanart.jpg"
			ln -rs "season-specials-fanart.jpg" "${file}/${file}.fanart.jpg"
		fi
		if [[ ! -L "${file}/fanart.jpg" ]]; then
			ln -rs "season-specials-fanart.jpg" "${file}/fanart.jpg"
		fi
	fi

fi


#if [ -e BDMV/movie.nfo ]
#then
#	ln -rs BDMV/movie.nfo .
#fi


if [[ -e movie.nfo ]] ; then
	name=$(grep -Po '(?i)<set>\K.*(?=</set>)' movie.nfo)

	name=${name/&amp;/&}

	echo SET=${name}
	

	if [[ -e movieset-folder.jpg ]] ; then
		if [[ ! -L "Set_${name}_1.jpg" ]] ; then
			rm "Set_${name}_1.jpg"
			ln -rs  movieset-folder.jpg "Set_${name}_1.jpg"
		fi
		
		ln -frs  movieset-folder.jpg ../folder.jpg
	fi


	if [[ -e movieset-poster.jpg ]] ; then
		if [[ ! -L "Set_${name}_1.jpg" ]] ; then
			rm "Set_${name}_1.jpg"
			ln -rs  movieset-poster.jpg "Set_${name}_1.jpg"
		fi
		ln -frs  movieset-poster.jpg ../folder.jpg
	fi

	if [[ -e movieset-banner.jpg ]] ; then
		if [[ ! -L "Set_${name}_1.banner.jpg" ]] ; then
			rm "Set_${name}_1.banner.jpg"
			ln -rs movieset-banner.jpg "Set_${name}_1.banner.jpg" 
		fi
		ln -frs movieset-banner.jpg ../banner.jpg
	fi
	
	if [[ -e movieset-fanart.jpg ]]; then
		if [[ ! -L "Set_${name}_1.fanart.jpg" ]] ; then
			rm "Set_${name}_1.fanart.jpg"
			ln -rs movieset-fanart.jpg "Set_${name}_1.fanart.jpg" 
		fi
		ln -frs movieset-fanart.jpg  ../fanart.jpg 
	fi

	if [[ -e movieset-logo.png ]]; then
		if [[ ! -L "Set_${name}_1.logo.png" ]] ; then
			rm "Set_${name}_1.logo.png"
			ln -rs movieset-logo.png "Set_${name}_1.logo.png" 
		fi
		ln -frs movieset-logo.png  ../logo.png 
	fi

	if [[ -e movieset-clearlogo.png ]]; then
		if [[ ! -L "Set_${name}_1.clearlogo.png" ]] ; then
			rm "Set_${name}_1.clearlogo.png"
			ln -rs movieset-clearlogo.png  "Set_${name}_1.clearlogo.png" 
		fi
		ln -frs movieset-clearlogo.png  ../clearlogo.png 
	fi

	if [[ -e movieset-clearart.png ]]; then
		if [[ ! -L "Set_${name}_1.clearart.png" ]] ; then
			rm "Set_${name}_1.clearart.png"
			ln -rs movieset-clearart.png  "Set_${name}_1.clearart.png" 
		fi
		ln -frs movieset-clearart.png  ../clearlogo.png 
	fi

	if [[ -s "poster.jpg" && ! -s "folder.jpg" ]]; then
		ln -rs poster.jpg folder.jpg
	fi
	if [[ -s "poster.png" && ! -s "folder.png" ]]; then
		ln -rs poster.png folder.png
	fi
fi


	ls -1 | grep -Pio '(.*)-thumb.jpg' | while read file
	do
		#echo detected ${file}
		vidfile=${file/-thumb.jpg/.videoimage.jpg}
		#echo new name: ${vidfile}
		if [[ ! -L "${vidfile}" ]]; then
			rm "${vidfile}"
			ln -rs "${file}" "${vidfile}"
		fi
	done

#clean up any broken links we may have created
symlinks -d .


