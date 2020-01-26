#!/bin/bash

LANG=en_US.UTF-8
LOCALE=UTF-8
export LANG=en_US.UTF-8
export LOCALE=UTF-8
export PERL_UTF8_LOCALE=1 PERL_UNICODE=ASD


SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

#for DIR in * ; do
#	if [[ -d "${DIR}" ]] ;  then
		echo parsing "${DIR}"
		for FILE in $( find . -name 'movie.nfo') ; do
  			if [[ $(grep -P "<genre>R</genre>" "${FILE}") ]] ; then
				echo fixing "${FILE}"
  				sed -i "s,<genre>R</genre>,,"  "${FILE}"
  				
  				
#				# insert correct genre tag
#				echo adding genre ${DIR} to ${FILE}
#				sed -i "s,<movie>,<movie><genre>${DIR}</genre>," ${FILE}
			fi
#  			if [[ $(grep -PiL "<genre>Slovak</genre>" "${FILE}") ]] ; then
#				# insert correct genre tag
#				echo adding genre Slovak to ${FILE}
#				sed -i "s,<movie>,<movie><genre>Slovak</genre>," ${FILE}
#			fi
#

		done 
#	fi
#done

IFS=$SAVEIFS
