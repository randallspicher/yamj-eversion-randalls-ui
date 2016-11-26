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
	mkdir "/tmp/actorfiles/"
	file="tvshow.nfo"
#	showid=$( xpath -e "//tvshow/id/text()" "${file}" 2>/dev/null )
	actorcount=$( xpath -e "count(//tvshow/actor)" "${file}" 2>/dev/null )
	for i in `seq 1 $actorcount`;
	do
		name=$( xpath -e "//tvshow/actor[$i]/name/text()" "${file}" 2>/dev/null )
		role=$( xpath -e "//tvshow/actor[$i]/role/text()" "${file}" 2>/dev/null )
		thumb=$( xpath -e "//tvshow/actor[$i]/thumb/text()" "${file}" 2>/dev/null )
		movie=$( xpath -e "//tvshow/title/text()" "${file}" 2>/dev/null )
		movie=${movie/&amp;/&}
		
		year=$( xpath -e "//tvshow/year/text()" "${file}" 2>/dev/null )

		#echo ${name}
		name=${name//[<>\"|\/:?*]/-}
		#echo ${name}	

		#echo ${role}
		role=${role//[<>\"|\/:?*]/-}
		#echo ${role}
		thumbdir="${YAMJ_PEOPLEDIR}/TV/${movie} (${year})"
		thumbname="${name}-${role}.jpg"
		thumbfile="${thumbdir}/${thumbname}"
		mkdir -p "${thumbdir}"
		if [[ -n "${thumb}" && ! -s "${thumbfile}" ]] ; then
			echo getting $thumbfile
			wget -O "/tmp/actorfiles/${thumbname}" "${thumb}"
			if [[ -s "/tmp/actorfiles/${thumbname}" ]]; then
				cp "/tmp/actorfiles/${thumbname}" "${thumbdir}"
			fi
			if [[ ! -s "${YAMJ_PEOPLEDIR}/${name}-${role}.jpg" ]]; then
				mv "/tmp/actorfiles/${thumbname}" "${YAMJ_PEOPLEDIR}/${name}-${role}.jpg"
			fi
		fi	
		if [[ -n "${thumb}" && ! -s "${YAMJ_PEOPLEDIR}/${name}-${role}.jpg" ]]; then
			wget -O "/tmp/actorfiles/${thumbname}" "${thumb}"
			if [[ -s "/tmp/actorfiles/${thumbname}" ]]; then
				mv "/tmp/actorfiles/${thumbname}" "${YAMJ_PEOPLEDIR}/${name}-${role}.jpg"
			fi	
		fi
		
	done
	rm  "/tmp/actorfiles/*"
fi

if [[ -e "movie.nfo" ]]; then
	file="movie.nfo"
	showid=$( xpath -e "//movie/id/text()" "${file}" 2>/dev/null )
	actorcount=$( xpath -e "count(//movie/actor)" "${file}" 2>/dev/null )
	#movie=$( xpath -e "//movie/originaltitle/text()" "${file}" 2>/dev/null )
	#year=$( xpath -e "//movie/year/text()" "${file}" 2>/dev/null )
		
	for i in `seq 1 $actorcount`;
	do
		name=$( xpath -e "//movie/actor[$i]/name/text()" "${file}" 2>/dev/null )
		thumb=$( xpath -e "//movie/actor[$i]/thumb/text()" "${file}" 2>/dev/null )
		thumbdir="${YAMJ_PEOPLEDIR}"
		thumbfile="${YAMJ_PEOPLEDIR}/${name}.jpg"

		#echo ${name}
		name=${name//[<>\"|\/:?*]/-}
		#echo ${name}	


		if [[ -n "${thumb}" && ! -s "${thumbfile}" ]] ; then
			echo getting $thumbfile
			wget -O "${thumbfile}" "${thumb}"

		fi	

		done
fi
