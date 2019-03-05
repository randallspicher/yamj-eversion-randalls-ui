#!/bin/bash


# link all videos to FLAT directory for Kodi
#cd /music-share/VIDEO/FLAT
#symlinks -d -c .
#ln -s ../Genres/Avan*/*/*.[IiWwMmAa][MmPpKkVvSsOo][VvGgIi4Oo] .
#ln -s ../Genres/Avan**/*/*/*.[IiWwMmAa][MmPpKkVvSsOo][VvGgIi4Oo] .
#ln -s ../Genres/Goth*/*/*.[IiWwMmAa][MmPpKkVvSsOo][VvGgIi4Oo] .
#ln -s ../Genres/Goth*/*/*/*.[IiWwMmAa][MmPpKkVvSsOo][VvGgIi4Oo] .
#ln -s ../Genres/Grunge/*/*.[IiWwMmAa][MmPpKkVvSsOo][VvGgIi4Oo] .
#ln -s ../Genres/Grunge/*/*/*.[IiWwMmAa][MmPpKkVvSsOo][VvGgIi4Oo] .
#ln -s ../Genres/Classic\ Rock/*/*.[IiWwMmAa][MmPpKkVvSsOo][VvGgIi4Oo] .
#ln -s ../Genres/Classic\ Rock/*/*/*.[IiWwMmAa][MmPpKkVvSsOo][VvGgIi4Oo] .
#ln -s ../Genres/Progressive*/*/*.[IiWwMmAa][MmPpKkVvSsOo][VvGgIi4Oo] .
#ln -s ../Genres/Progressive*/*/*/*.[IiWwMmAa][MmPpKkVvSsOo][VvGgIi4Oo] .
#ln -s ../Genres/New*/*/*.[IiWwMmAa][MmPpKkVvSsOo][VvGgIi4Oo] .
#ln -s ../Genres/New*/*/*/*.[IiWwMmAa][MmPpKkVvSsOo][VvGgIi4Oo] .
#ln -s ../Genres/Metal/*/*.[IiWwMmAa][MmPpKkVvSsOo][VvGgIi4Oo] .
#ln -s ../Genres/Metal/*/*/*.[IiWwMmAa][MmPpKkVvSsOo][VvGgIi4Oo] .
#ln -s ../Genres/Pop/*/*.[IiWwMmAa][MmPpKkVvSsOo][VvGgIi4Oo] .
#ln -s ../Genres/Pop/*/*/*.[IiWwMmAa][MmPpKkVvSsOo][VvGgIi4Oo] .
#ln -s ../Genres/Sixties/*/*.[IiWwMmAa][MmPpKkVvSsOo][VvGgIi4Oo] .
#ln -s ../Genres/Sixties/*/*/*.[IiWwMmAa][MmPpKkVvSsOo][VvGgIi4Oo] .
#symlinks -d -c .



# link videos artists directories for PLEX
cd /music-share/VIDEO/Artists
symlinks -d -c .
ln -s ../Genres/*/* .
symlinks -d -c .

# link flat artist directory for Headphones scanner
cd /music-share/FLAC-MP3/Artists
symlinks -d -c .
ln -s ../Genres/*/* .
symlinks -d -c .





