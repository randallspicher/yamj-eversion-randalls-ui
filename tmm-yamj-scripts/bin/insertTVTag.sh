#!/bin/bash

LANG=en_US.UTF-8
LOCALE=UTF-8
export LANG=en_US.UTF-8
export LOCALE=UTF-8
export PERL_UTF8_LOCALE=1 PERL_UNICODE=ASD

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

for DIR in * ; do
	if [[ -d "${DIR}" ]] ;  then
		echo parsing "${DIR}"
		#TAG="TV ${DIR}"
		TAG="${DIR}"
		for FILE in $( find "${DIR}" -name 'tvshow.nfo') ; do
  			if [[ $(grep -PiL "<tag>${TAG}</tag>" "${FILE}") ]] ; then
				#echo Wrong TAG in ${FILE} 
				#remove any tag tag that may already exist
				#sed -i "s,<tag>[^<]*</tag>,,"  ${FILE}
				# insert correct tag tag
				echo adding tag ${TAG} to ${FILE}
				sed -i "s,<tvshow>,<tvshow><tag>${TAG}</tag>," ${FILE}
			#else 
				#echo Correct TAG ${FILE}
			fi

			if [[ $(grep -Pic "<tag>" "${FILE}") -gt 1 ]] ; then
				echo found too many genres in ${FILE}
				#remove any genre tag that may already exist
				sed -i "s,<tag>[^<]*</tag>,,"  ${FILE}
				# insert correct genre tag
				sed -i "s,<tvshow>,<tvshow><tag>${DIR}</tag>," ${FILE}
			fi 
			
		done 
	fi
done

IFS=$SAVEIFS
