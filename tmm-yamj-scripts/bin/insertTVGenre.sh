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
		for FILE in $( find "${DIR}" -name 'tvshow.nfo') ; do
  			if [[ $(grep -PiL "<genre>${DIR}</genre>" "${FILE}") ]] ; then
				echo Wrong GENRE in ${FILE} 
				#remove any genre tag that may already exist
				sed -i "s,<genre>[^<]*</genre>,,"  ${FILE}
				# insert correct genre tag
				sed -i "s,<tvshow>,<tvshow><genre>${DIR}</genre>," ${FILE}
			#else 
				#echo Correct GENRE ${FILE}
			fi
			
			if [[ $(grep -Pic "<genre>" "${FILE}") -gt 1 ]] ; then
				echo found too many genres in ${FILE}
				#remove any genre tag that may already exist
				sed -i "s,<genre>[^<]*</genre>,,"  ${FILE}
				# insert correct genre tag
				sed -i "s,<tvshow>,<tvshow><genre>${DIR}</genre>," ${FILE}
			fi 
		done 
	fi
done

IFS=$SAVEIFS
