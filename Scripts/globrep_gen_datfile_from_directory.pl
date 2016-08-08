#!/usr/bin/perl
#must be used in a directory with only appropriate files
#is designed to work after simulate_fixed_percent.pl
use 5.010;

open FILE, "+>ssrv.dat" or die "failed to open file: $!";
my $dir;
my $current_dir = `pwd`;
if ($ARGV < 1) {
    $dir = $current_dir;
} else {
    $dir = $ARGV[0];
}

chomp $dir;
my $dir_ending = substr $dir, -1;
if ($dir_ending ne "/") {
    $dir = $dir . "/";
}
$dir = $dir . "*.txt";

my @files = glob( $dir );
foreach $currfile (@files ){
    print $currfile . "\n";
    open CURRENTFILE, "<$currfile" or die "failed to open file: $!";
    my @lines = <CURRENTFILE>;
    my @percents = split(",", $lines[-2]);
    say FILE "#" . $currfile;
    print FILE $percents[1];
    print FILE " ";
    print FILE $percents[2];
    print FILE "\n";
    close CURRENTFILE;
}
print "done! \n";
close FILE;
