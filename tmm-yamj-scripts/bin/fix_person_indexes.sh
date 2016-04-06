#!/bin/bash

LANG=en_US.UTF-8
LOCALE=UTF-8
export LANG=en_US.UTF-8
export LOCALE=UTF-8
export PERL_UTF8_LOCALE=1 PERL_UNICODE=ASD


#<category count="1" current="true" name="Person">
    #      <index current="true"
            #         currentIndex="1"
            # first="Person_Lou Diamond Phillips_1"
            # last="Person_Lou Diamond Phillips_1"
            # lastIndex="1"
            # name="Lou Diamond Phillips"
            # next="Person_Lou Diamond Phillips_1"
            # previous="Person_Lou Diamond Phillips_1">Person_Lou Diamond Phillips_1</index>
#  </category>






#find . -name 'Person_*.xml' -print0 | tr "\n" "\0" | xargs -0 sed -i 's,<genre>[^<]*</genre>,,' 


ls -1 Person_*_1.xml | while read file
do
		echo ${file} 
		
	if grep -Po '(<category)' "${file}"
	then
		echo "Category Found"
	else
	
		regex='Person_(.+)_1+\.xml'

		[[ ${file} =~ $regex ]]

	
		PERSON="${BASH_REMATCH[1]}"
		echo ${PERSON}
	
		CATEGORYTEXT="\n\
<category count=\"1\" current=\"true\" name=\"Person\">\n\
    <index current=\"true\"\n\
		currentIndex=\"1\"\n\
		first=\"Person_${PERSON}_1\"\n\
		last=\"Person_${PERSON}_1\"\n\
		lastIndex=\"1\"\n\
		name=\"${PERSON}\"\n\
		next=\"Person_${PERSON}_1\"\n\
		previous=\"Person_${PERSON}_1\">Person_${PERSON}_1</index>\n\
</category>\n\
"
		echo ${CATEGORYTEXT}
		
		
	sed -i "s|<movies|${CATEGORYTEXT}<movies|" "${file}"

		
	fi

done


#find . -name 'Person_*.xml' -print0 \
	#	| xargs -0 grep -PiL "\<category\>.+?\<\/category\>" \
	#| tr "\n" "\0" \
	#| xargs -0 sed -i 's,<movies,<movies,' 
