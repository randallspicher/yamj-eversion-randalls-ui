#!/bin/bash

LANG=en_US.UTF-8
LOCALE=UTF-8
export LANG=en_US.UTF-8
export LOCALE=UTF-8
export PERL_UTF8_LOCALE=1 PERL_UNICODE=ASD



#name=$(grep -Po '(?i)<title>\K.*(?=</title>)' tvshow.nfo)






ls -1  | grep nfo$  | while read file
do
	if [[ -f "${file}" ]]; then	
		watched=$( grep -Po '(?i)<watched>\K.*(?=</watched>)' "${file}")
		if [[ "${watched}" == 'true' ]]; then
			if [[ $file =~ ^(.+)\.nfo ]]; then
				fileroot=${BASH_REMATCH[1]}
				if [[ ! -e "${fileroot}.watched" ]] ; then
					echo ${fileroot}.watched
					echo ${fileroot} >"${fileroot}.watched"
				fi
			fi
		fi
	fi
done




