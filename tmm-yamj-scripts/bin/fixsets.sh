#!/bin/bash

LANG=en_US.UTF-8
LOCALE=UTF-8
export LANG=en_US.UTF-8
export LOCALE=UTF-8
export PERL_UTF8_LOCALE=1 PERL_UNICODE=ASD






ls -1 tvshow.nfo movie.nfo 2>/dev/null | while read file
do

	if [[ -f "${file}" ]]; then	
		#echo ${file} 

		AIRED=$( xpath -e "//movie/premiered/text()" "${file}" 2>/dev/null )
		YEAR=$( xpath -e "//movie/year/text()" "${file}" 2>/dev/null )
		SETNAME=$( xpath -e "//movie/set/name/text()" "${file}" 2>/dev/null )
		SORTTITLE=$( xpath -e "//movie/sorttitle/text()" "${file}" 2>/dev/null )

		#echo AIRED $AIRED
		#echo YEAR $YEAR
		#echo SETNAME $SETNAME

		if [[ -z $AIRED ]] ; then
			AIRED=$YEAR	
		fi

		if [[ ! -z "${SETNAME}" ]] ; then
			echo need to convert the set for ${file}
			xmlstarlet ed -L -d "//movie/set" "${file}"
			xmlstarlet ed -L -s "//movie" -t elem -n "set" -v "${SETNAME}" "${file}"
			#xmlstarlet ed -L -u "//movie/set/text()" -v "${SETNAME}" "${file}"
		else
			#echo fetching plain set
			SETNAME=$( xpath -e "//movie/set/text()" "${file}" 2>/dev/null )
			#echo now set is $SETNAME
		fi

		if [[ ! -z "${SETNAME}" ]] ; then
			
			SETNAME=${SETNAME#The }
			SETNAME=${SETNAME#A /}
						
			WANTSORT="${SETNAME} ${AIRED}"
			echo WANTSORT ${WANTSORT}
			#echo HAVESORT ${SORTTITLE}
				
			if [[ ! -z "${WANTSORT}" ]] ; then
				if [[ "${WANTSORT}" != "${SORTTITLE}" ]] ; then
					echo need to set sort title to ${WANTSORT} for ${file}
					xmlstarlet ed -L -d "//movie/sorttitle" "${file}"
					xmlstarlet ed -L -s "//movie" -t elem -n "sorttitle" -v "${WANTSORT}" "${file}"
				fi	
			fi
		fi		
						#		regex='(....)-(..)-(..)'
		#[[ ${AIRED} =~ $regex ]]
		
		#FAKESEASON="${BASH_REMATCH[1]} ${BASH_REMATCH[2]}"
		#echo FAKESEASON $FAKESEASON

	#FAKEEPISODE="${BASH_REMATCH[3]}"
	#echo fakeepisode $FAKEEPISODE

	#xmlstarlet ed -L -d "//episodedetails/airsBeforeSeason" "${file}"
	#xmlstarlet ed -L -d "//episodedetails/airsBeforeEpisode" "${file}"
	#xmlstarlet ed -L -d "//episodedetails/airsAfterSeason" "${file}"

#	if [[ $REALSEASON == "0" ]] ; then
#		xmlstarlet ed -L -s "//episodedetails" -t elem -n "airsBeforeSeason" -v "${FAKESEASON}" "${file}"
#		xmlstarlet ed -L -s "//episodedetails" -t elem -n "airsBeforeEpisode" -v "${FAKEEPISODE}" "${file}"
#	fi
		#	xmlstarlet ed -L -u "//episodedetails/season" -v "${FAKESEASON}" "${file}"
		#   xmlstarlet ed -L -u "//episodedetails/episode" -v "${FAKEEPISODE}" "${file}"
	
		
#	sed -i "s|<movies|${CATEGORYTEXT}<movies|" "${file}"

	fi
done



