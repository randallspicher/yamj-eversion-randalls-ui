#!/bin/bash

LANG=en_US.UTF-8
LOCALE=UTF-8
export LANG=en_US.UTF-8
export LOCALE=UTF-8
export PERL_UTF8_LOCALE=1 PERL_UNICODE=ASD






ls -1 *.nfo | while read file
do
	echo ${file} 

	AIRED=$( xpath -e "//episodedetails/aired/text()" "${file}" 2>/dev/null )
	REALSEASON=$( xpath -e "//episodedetails/season/text()" "${file}" 2>/dev/null )

	echo aired $AIRED
	regex='(....)-(..)-(..)'
	[[ ${AIRED} =~ $regex ]]
		
	
	FAKESEASON="${BASH_REMATCH[1]}"
	echo fakeseason $FAKESEASON

	FAKEEPISODE="${BASH_REMATCH[2]}${BASH_REMATCH[3]}"
	echo fakeepisode $FAKEEPISODE

	xmlstarlet ed -L -d "//episodedetails/airsBeforeSeason" "${file}"
	xmlstarlet ed -L -d "//episodedetails/airsBeforeEpisode" "${file}"
	xmlstarlet ed -L -d "//episodedetails/airsAfterSeason" "${file}"

#	if [[ $REALSEASON == "0" ]] ; then
#		xmlstarlet ed -L -s "//episodedetails" -t elem -n "airsBeforeSeason" -v "${FAKESEASON}" "${file}"
#		xmlstarlet ed -L -s "//episodedetails" -t elem -n "airsBeforeEpisode" -v "${FAKEEPISODE}" "${file}"
#	fi
		xmlstarlet ed -L -u "//episodedetails/season" -v "${FAKESEASON}" "${file}"
		xmlstarlet ed -L -u "//episodedetails/episode" -v "${FAKEEPISODE}" "${file}"
	
		
#	sed -i "s|<movies|${CATEGORYTEXT}<movies|" "${file}"


done



