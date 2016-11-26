#!/bin/bash

export NFO_UTIL_BIN_PATH="/d1/YAMJ/TMM-Conversion/bin"
export YAMJ_PEOPLEDIR="/d1/People"

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

		if [[ -n ${moviename} ]]; then
			thumb="${imagehost}/${name}  ${moviename}.jpg"
			thumb1="${imagehost}/${name}  ${moviename} 1.jpg"
			thumb2="${imagehost}/${name} ${moviename}.jpg"
			thumb3="${imagehost}/${name} ${moviename} 1.jpg"
			thumb4="${imagehost}/1Actors Images/${name}  ${moviename} (${year}).jpg"	
		else
			thumb="${imagehost}/${name}  ${movie} (${year}).jpg"
			thumb1="${imagehost}/${name}  ${movie} (${year}) 1.jpg"
			thumb2="${imagehost}/${name} ${movie} (${year}).jpg"
			thumb3="${imagehost}/${name} ${movie} (${year}) 1.jpg"
			thumb4="${imagehost}/1Actors Images/${name}  ${movie} (${year}).jpg"	
		fi
		#echo Character Thumb: "${thumb}"
		
		#echo ${name}
		name=${name//[<>\"|\/:?*]/-}
		
		#echo ${name}	


		#thumbdir="${YAMJ_PEOPLEDIR}/Movie/${movie} (${year})"
		thumbdir="${YAMJ_PEOPLEDIR}"

		#echo "${role}"
		role=${role//[<>\"|\/:?*]/-}
		#echo "${role}"
		thumbname="${name}-${role}.jpg"
		thumbfile="${thumbdir}/${thumbname}"
		mkdir -p "${thumbdir}"
		if [[ -n "${thumb4}" && ! -s "${thumbfile}" ]] ; then
			wget -O "/tmp/${thumbname}" "${thumb4}"
			if [[ -s "/tmp/${thumbname}" ]]; then
				mv "/tmp/${thumbname}" "${thumbdir}"
			fi
		fi	
		if [[ -n "${thumb}" && ! -s "${thumbfile}" ]] ; then
			wget -O "/tmp/${thumbname}" "${thumb}"
			if [[ -s "/tmp/${thumbname}" ]]; then
				mv "/tmp/${thumbname}" "${thumbdir}"
			fi
		fi	
		if [[ -n "${thumb1}" && ! -s "${thumbfile}" ]] ; then
			wget -O "/tmp/${thumbname}" "${thumb1}"
			if [[ -s "/tmp/${thumbname}" ]]; then
				mv "/tmp/${thumbname}" "${thumbdir}"
			fi
		fi	
		if [[ -n "${thumb2}" && ! -s "${thumbfile}" ]] ; then
			wget -O "/tmp/${thumbname}" "${thumb2}"
			if [[ -s "/tmp/${thumbname}" ]]; then
				mv "/tmp/${thumbname}" "${thumbdir}"
			fi
		fi	
		if [[ -n "${thumb3}" && ! -s "${thumbfile}" ]] ; then
			wget -O "/tmp/${thumbname}" "${thumb3}"
			if [[ -s "/tmp/${thumbname}" ]]; then
				mv "/tmp/${thumbname}" "${thumbdir}"
			fi
		fi	

								
		done
fi





