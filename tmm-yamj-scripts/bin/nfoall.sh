#!/bin/bash
LANG=en_US.UTF-8
LOCALE=UTF-8
export LANG=en_US.UTF-8
export LOCALE=UTF-8
export PERL_UTF8_LOCALE=1 PERL_UNICODE=ASD




#name=$(grep -Po '(?i)<title>\K.*(?=</title>)' tvshow.nfo)





#echo doing watched loop
find .  | grep nfo$  | while read file
do
#echo inside watched loop


    echo ${file}
  
	watched=$( grep -Po '(?i)<watched>\K.*(?=</watched>)' "${file}")
	if [ "${watched}" == 'true' ]
	then
		echo file= ${file}
#		echo watched=${watched}
		echo ${file} >"${file}.watched"
	fi

done
#echo finished watched loop




