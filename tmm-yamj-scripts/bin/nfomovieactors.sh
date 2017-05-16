#!/bin/bash

export NFO_UTIL_BIN_PATH="/home/yamj/TMM-Conversion/bin"
export YAMJ_PEOPLEDIR="/home/yamj/People"

LANG=en_US.UTF-8
LOCALE=UTF-8
export LANG=en_US.UTF-8
export LOCALE=UTF-8

export PERL_UTF8_LOCALE=1 PERL_UNICODE=AS

moviename="${1}"

echo moviename = "${moviename}"

#name='this/has<lots>of|questionable"chars:in?it*now'
#echo ${name}
#name=${name//[<>\"|\/:?*]/-}
#echo ${name}

#name=$(grep -Po '(?i)<title>\K.*(?=</title>)' tvshow.nfo)




if [[ -e "movie.nfo" ]]; then
	file="movie.nfo"
	showid=$( xpath -e "//movie/id/text()" "${file}" 2>/dev/null )
	actorcount=$( xpath -e "count(//movie/actor)" "${file}" 2>/dev/null )
	movie=$( xpath -e "//movie/originaltitle/text()" "${file}" 2>/dev/null )
	year=$( xpath -e "//movie/year/text()" "${file}" 2>/dev/null )
	movie=${movie/&amp;/&}
	
	imagehost="http://movie-dude.co.uk"
	#imagehost="http://173.254.28.109"
			
	for i in `seq 1 $actorcount`;
	do
		name=$( xpath -e "//movie/actor[$i]/name/text()" "${file}" 2>/dev/null )
				
		thumb=$( xpath -e "//movie/actor[$i]/thumb/text()" "${file}" 2>/dev/null )

		role=$( xpath -e "//movie/actor[$i]/role/text()" "${file}" 2>/dev/null )
		if [[ ! -n ${moviename} ]]; then
			moviename="${movie} (${year})"
		fi 

		thumb1="${imagehost}/1Actors Images/${name}  ${moviename}.jpg"	
		thumb2="${imagehost}/1Actors Images/${name}  ${moviename} 1.jpg"	
		thumb3="${imagehost}/${name}  ${moviename}.jpg"
		thumb4="${imagehost}/${name}  ${moviename} 1.jpg"
		thumb5="${imagehost}/${name} ${moviename}.jpg"
		thumb6="${imagehost}/${name} ${moviename} 1.jpg"

				#echo Character Thumb: "${thumb}"
		
		#echo ${name}
		name=${name//[<>\"|\/:?*]/-}
		PF="CH-${name:0:1}"
				
		#echo ${name}	


		#thumbdir="${YAMJ_PEOPLEDIR}/Movie/${movie} (${year})"
		thumbdir="${YAMJ_PEOPLEDIR}/${PF}/"

		#echo "${role}"
		role=${role//[<>\"|\/:?*]/-}
		#echo "${role}"
		thumbname="${name} - ${role}.jpg"

		thumbdir="${YAMJ_PEOPLEDIR}/${PF}/"
		thumbfile="${thumbdir}${thumbname}"
	 	tempfile="/tmp/${PF}/${thumbname}"

		mkdir -p "${thumbdir}"
		mkdir -p "/tmp/${PF}"


		if [[ -n "${thumb1}" && ! -s "${thumbfile}" ]] ; then
			rm "${tempfile}"
			wget -O "${tempfile}" "${thumb1}"
			if [[ -s "${tempfile}" ]]; then
				mv "${tempfile}" "${thumbdir}"
			else
				rm "${tempfile}"
			fi	
		fi	
		if [[ -n "${thumb2}" && ! -s "${thumbfile}" ]] ; then
			rm "${tempfile}"
			wget -O "${tempfile}" "${thumb2}"
			if [[ -s "${tempfile}" ]]; then
				mv "${tempfile}" "${thumbdir}"
			else
				rm "${tempfile}"
			fi	
		fi	
		if [[ -n "${thumb3}" && ! -s "${thumbfile}" ]] ; then
			rm "${tempfile}"
			wget -O "${tempfile}" "${thumb3}"
			if [[ -s "${tempfile}" ]]; then
				mv "${tempfile}" "${thumbdir}"
			else
				rm "${tempfile}"
			fi	
		fi	
		if [[ -n "${thumb4}" && ! -s "${thumbfile}" ]] ; then
			rm "${tempfile}"
			wget -O "${tempfile}" "${thumb4}"
			if [[ -s "${tempfile}" ]]; then
				mv "${tempfile}" "${thumbdir}"
			else
				rm "${tempfile}"
			fi	
		fi	
		if [[ -n "${thumb5}" && ! -s "${thumbfile}" ]] ; then
			rm "${tempfile}"
			wget -O "${tempfile}" "${thumb5}"
			if [[ -s "${tempfile}" ]]; then
				mv "${tempfile}" "${thumbdir}"
			else
				rm "${tempfile}"
			fi	
		fi	
		if [[ -n "${thumb6}" && ! -s "${thumbfile}" ]] ; then
			rm "${tempfile}"
			wget -O "${tempfile}" "${thumb6}"
			if [[ -s "${tempfile}" ]]; then
				mv "${tempfile}" "${thumbdir}"
			else
				rm "${tempfile}"
			fi	
		fi	

								
		done
fi





