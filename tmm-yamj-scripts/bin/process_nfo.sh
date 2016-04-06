#!/bin/bash


export NFO_UTIL_BIN_PATH="/d1/YAMJ/TMM-Conversion/bin"
export YAMJ_PEOPLEDIR="/d1/People"


LANG=en_US.UTF-8
LOCALE=UTF-8
export LANG=en_US.UTF-8
export LOCALE=UTF-8
export PERL_UTF8_LOCALE=1 PERL_UNICODE=ASD

perl "${NFO_UTIL_BIN_PATH}/nfolinks.pl"