#!/bin/bash


LANG=en_US.UTF-8
LOCALE=UTF-8
export LANG=en_US.UTF-8
export LOCALE=UTF-8

export PERL_UTF8_LOCALE=1 PERL_UNICODE=AS

#name='this/has<lots>of|questionable"chars:in?it*now'

#echo ${name}
#name=${name//[<>\"|\/:?*]/-}
#echo ${name}

#name=$(grep -Po '(?i)<title>\K.*(?=</title>)' tvshow.nfo)


if [[ -e "tvshow.nfo" ]]; then
	file="tvshow.nfo"

	name=$(grep -Po '(?i)<title>\K.*(?=</title>)' tvshow.nfo)
	name=${name/&amp;/&}
	newnfo="${name}.nfo"

	#echo processing ${name}
	if [ ! -L "${newnfo}" ]; then
		rm -v "${newnfo}"
		#cp -v tvshow.nfo "${newnfo}"			
		ln -rs tvshow.nfo "${newnfo}"			
	fi


#	showid=$( xpath -e "//tvshow/id/text()" "${file}" 2>/dev/null )
	actorcount=$( xpath -e "count(//tvshow/actor)" "${file}" 2>/dev/null )
	for i in `seq 1 $actorcount`;
	do
		thumb=""
		thumb=$( xpath -e "//tvshow/actor[$i]/thumb/text()" "${file}" 2>/dev/null )
		#movie=$( xpath -e "//tvshow/title/text()" "${file}" 2>/dev/null )
		#movie=${movie/&amp;/&}
		
		#year=$( xpath -e "//tvshow/year/text()" "${file}" 2>/dev/null )

		origname=$( xpath -e "//tvshow/actor[$i]/name/text()" "${file}" 2>/dev/null )
		origrole=$( xpath -e "//tvshow/actor[$i]/role/text()" "${file}" 2>/dev/null )
		#name=${origname//[<>\"|\/:?*"]+/-}
		
		name=$(echo "${origname}" | sed -E 's/[<>\"|\/:?*]+/-/g')
		name=$(echo "${name}" | sed -E 's/\t+/ /g')		
		name=$(echo "${name}" | sed -E 's/  +/ /g')
		name=$(echo "${name}" | sed -E 's/^[ -]+//g')
		name=$(echo "${name}" | sed -E 's/[ -]+$//g')

		#role=${origrole//[<>\"|\/:?*"]+/-}
		role=$(echo "${origrole}" | sed -E 's/[<>\"|\/:?*]+/-/g')
		role=$(echo "${role}" | sed -E 's/\t+/ /g')		
		role=$(echo "${role}" | sed -E 's/  +/ /g')
		role=$(echo "${role}" | sed -E 's/^[ -]+//g')
		role=$(echo "${role}" | sed -E 's/[ -]+$//g')
		#echo role = ${role}

		if [[ ${origname} != ${name} ]]; then
			xmlstarlet edit -L -u "//tvshow/actor[$i]/name" -v "${name}" "${file}"
			echo changing ${origname} to ${name}
		fi
		if [[ ${origrole} != ${role} ]]; then
			xmlstarlet edit -L -u "//tvshow/actor[$i]/role" -v "${role}" "${file}"
			echo changing ${origrole} to ${role}
		fi

		#PF="CH-${name:0:1}"

		thumbname="${name} - ${role}.jpg"
		#thumbdir="${YAMJ_PEOPLEDIR}/${PF}/"
		thumbdir=/media-share/People/
#		kodithumbdir="${KODI_PEOPLEDIR}/"
		thumbfile="${thumbdir}${thumbname}"
#		kodithumbfile="${kodithumbdir}${thumbname}"
	 	#tempfile="/tmp/yamj/${PF}/${thumbname}"
	 	#tempfile="/tmp/yamj/${PF}/${thumbname}"
		tempfile=${thumbdir}/tmp/${thumbname}
		#echo nfo actor image ${thumb}
		#echo thumbfile  ${thumbfile}
		
		jpgpattern="jpg$"
		
		#mv -v "/media-share/People.source/${thumbname}" "/media-share/People/"

		if [[ -n "${thumb}" && "${thumb}" =~ $jpgpattern &&  ! -s "${thumbfile}" ]]; then
		#if [[ -n "${thumb}" && "${thumb}" =~ $jpgpattern ]]; then
			#mkdir -p "${thumbdir}"
			mkdir -p "/tmp/yamj/${PF}"
			echo need to fetch ${thumb} to ${tempfile}
			rm "${tempfile}"
			wget -O "${tempfile}" "${thumb}"
			if [[ -s "${tempfile}" ]]; then
				mv "${tempfile}" "${thumbdir}"
			else
				rm "${tempfile}"
			fi	
		fi
	done
fi

if [[ -e "movie.nfo" ]]; then
	file="movie.nfo"
	showid=$( xpath -e "//movie/id/text()" "${file}" 2>/dev/null )
	actorcount=$( xpath -e "count(//movie/actor)" "${file}" 2>/dev/null )
	#movie=$( xpath -e "//movie/originaltitle/text()" "${file}" 2>/dev/null )
	#year=$( xpath -e "//movie/year/text()" "${file}" 2>/dev/null )
				
	for i in `seq 1 $actorcount`;
	do
		####name=$( xpath -e "//movie/actor[$i]/name/text()" "${file}" 2>/dev/null )
		thumb=$( xpath -e "//movie/actor[$i]/thumb/text()" "${file}" 2>/dev/null )

		origname=$( xpath -e "//movie/actor[$i]/name/text()" "${file}" 2>/dev/null )
		origrole=$( xpath -e "//movie/actor[$i]/role/text()" "${file}" 2>/dev/null )

#		name=${origname//[<>\"|\/:?*"]+/-}
		name=$(echo "${origname}" | sed -E 's/[<>\"|\/:?*]+/-/g')
		name=$(echo "${name}" | sed -E 's/\t+/ /g')		
		name=$(echo "${name}" | sed -E 's/  +/ /g')
		name=$(echo "${name}" | sed -E 's/^[ -]+//g')
		name=$(echo "${name}" | sed -E 's/[ -]+$//g')

#		role=${origrole//[<>\"|\/:?*"]+/-}
		role=$(echo "${origrole}" | sed -E 's/[<>\"|\/:?*]+/-/g')
		role=$(echo "${role}" | sed -E 's/\t+/ /g')		
		role=$(echo "${role}" | sed -E 's/  +/ /g')
		role=$(echo "${role}" | sed -E 's/^[ -]+//g')
		role=$(echo "${role}" | sed -E 's/[ -]+$//g')

		if [[ ${origname} != ${name} ]]; then
			xmlstarlet edit -L -u "//movie/actor[$i]/name" -v "${name}" "${file}"
			echo changing ${origname} to ${name}
		fi
		if [[ ${origrole} != ${role} ]]; then
			xmlstarlet edit -L -u "//movie/actor[$i]/role" -v "${role}" "${file}"
			echo changing ${origrole} to ${role}
		fi


		#characterthumb="${name} - ${role}.jpg"
		#mv -v "/media-share/People.source/${characterthumb}" "/media-share/People/"

#
#		PF="${name:0:1}"
#		thumbname="${name}.jpg"
#		thumbdir="${YAMJ_PEOPLEDIR}/${PF}/"
#		thumbfile="${thumbdir}${thumbname}"
#	 	tempfile="/tmp/yamj/${PF}/${thumbname}"
#
#
#		jpgpattern="jpg$"
#
#
#		if [[ -n "${thumb}" && "${thumb}" =~ $jpgpattern && ! -s "${thumbfile}" ]]; then
#		echo need to fetch ${thumb}
#		mkdir -p "${thumbdir}"
#		mkdir -p "/tmp/yamj/${PF}"
#			rm "${tempfile}"
#			wget -O "${tempfile}" "${thumb}"
#			if [[ -s "${tempfile}" ]]; then
#				mv "${tempfile}" "${thumbdir}"
#			else
#				rm "${tempfile}"
#			fi	
#		fi

	done
fi

