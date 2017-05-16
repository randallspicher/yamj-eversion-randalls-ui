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

	if [ ! -L "${newnfo}" ]; then
		rm -v "${newnfo}"
		#cp -v tvshow.nfo "${newnfo}"			
		ln -rs tvshow.nfo "${newnfo}"			
	fi


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
		PF="CH-${name:0:1}"
		

		#echo ${role}
		role=${role//[<>\"|\/:?*]/-}

		thumbname="${name} - ${role}.jpg"
		thumbdir="${YAMJ_PEOPLEDIR}/${PF}/"
		thumbfile="${thumbdir}${thumbname}"

		mkdir -p "${thumbdir}"
		mkdir -p "/tmp/${PF}"

	 	
	 	tempfile="/tmp/${PF}/${thumbname}"

		if [[ -n "${thumb}" && ! -s "${thumbfile}" ]]; then
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
		name=$( xpath -e "//movie/actor[$i]/name/text()" "${file}" 2>/dev/null )
		thumb=$( xpath -e "//movie/actor[$i]/thumb/text()" "${file}" 2>/dev/null )

		#echo ${name}
		name=${name//[<>\"|\/:?*]/-}
		#echo ${name}	
		PF="${name:0:1}"


		thumbname="${name}.jpg"
		thumbdir="${YAMJ_PEOPLEDIR}/${PF}/"
		thumbfile="${thumbdir}${thumbname}"
	 	tempfile="/tmp/${PF}/${thumbname}"

		mkdir -p "${thumbdir}"
		mkdir -p "/tmp/${PF}"

		if [[ -n "${thumb}" && ! -s "${thumbfile}" ]]; then
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

