#!/bin/bash

LANG=en_US.UTF-8
LOCALE=UTF-8
export LANG=en_US.UTF-8
export LOCALE=UTF-8
export PERL_UTF8_LOCALE=1 PERL_UNICODE=ASD


cd /media-share/kids/HOLIDAY

find . -name '*.nfo' -print0 | tr "\n" "\0" | xargs -0 sed -i 's,<genre>[^<]*</genre>,,' 


find CHRISTMAS -name '*.nfo' -print0 | xargs -0 grep -PiL "\<genre\>Christmas\<\/genre\>" | tr "\n" "\0" | xargs -0 sed -i 's,<movie>,<movie><genre>Christmas</genre>,' 

find EASTER -name '*.nfo' -print0 | xargs -0 grep -PiL "\<genre\>Easter\<\/genre\>" | tr "\n" "\0" | xargs -0 sed -i 's,<movie>,<movie><genre>Easter</genre>,' 

find HALLOWEEN -name '*.nfo' -print0 | xargs -0 grep -PiL "\<genre\>Halloween\<\/genre\>" | tr "\n" "\0" | xargs -0 sed -i 's,<movie>,<movie><genre>Halloween</genre>,' 

find NEWYEARS -name '*.nfo' -print0 | xargs -0 grep -PiL "\<genre\>New Years\<\/genre\>" | tr "\n" "\0" | xargs -0 sed -i 's,<movie>,<movie><genre>New Years</genre>,' 

find OTHER -name '*.nfo' -print0 | xargs -0 grep -PiL "\<genre\>Summer\<\/genre\>" | tr "\n" "\0" | xargs -0 sed -i 's,<movie>,<movie><genre>Summer</genre>,' 

find SUMMER -name '*.nfo' -print0 | xargs -0 grep -PiL "\<genre\>Summer\<\/genre\>" | tr "\n" "\0" | xargs -0 sed -i 's,<movie>,<movie><genre>Summer</genre>,' 

find THANKSGIVING -name '*.nfo' -print0 | xargs -0 grep -PiL "\<genre\>Thanksgiving\<\/genre\>" | tr "\n" "\0" | xargs -0 sed -i 's,<movie>,<movie><genre>Thanksgiving</genre>,' 

find VALENTINES -name '*.nfo' -print0 | xargs -0 grep -PiL "\<genre\>Valentines\<\/genre\>" | tr "\n" "\0" | xargs -0 sed -i 's,<movie>,<movie><genre>Valentines</genre>,' 
