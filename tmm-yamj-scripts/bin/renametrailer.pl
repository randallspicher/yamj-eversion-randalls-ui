#!/usr/bin/perl



my $StartDir=`pwd`;
for ($StartDir) {
    s/^\s+//;
    s/\s+$//;
}  
print "Starting in $StartDir\n";

#  ($filename, $top_dir) = @ARGV 

sub recursedirs {
    my $Location=$_[0];
    chdir "$Location";
    print "Parsing in $Location\n";
    print `bash $ENV{'NFO_UTIL_BIN_PATH'}/webm2mkv.sh *.webm`;
    print `bash $ENV{'NFO_UTIL_BIN_PATH'}/renametrailer.sh`;
###    print `bash $ENV{'NFO_UTIL_BIN_PATH'}/nfolinks.sh`;
###    print `bash $ENV{'NFO_UTIL_BIN_PATH'}/nfowatched.sh`;
###    print `bash $ENV{'NFO_UTIL_BIN_PATH'}/nfotvactors.sh`;

    opendir($DIR, "$Location") || die "can't opendir '$Location': $!";
    my @dirlist = readdir($DIR) ;
    closedir($DIR) ;
    @dirlist=sort(@dirlist);
    foreach my $item (@dirlist){
	next if $item eq '.';
	next if $item eq '..';
	if (-d "$Location/$item"){
            recursedirs ("$Location/$item");
            chdir "$Location";
	}

    
    }   
}

recursedirs("$StartDir");

