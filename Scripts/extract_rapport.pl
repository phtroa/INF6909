#!/usr/bin/perl
use warnings;
use 5.10.0;

my $mode_global = 0;
my $mode = $ARGV[0];
chomp $mode;
if ($mode eq "glob") {
    $mode_global = 1;
}

my $is_reading_rapport = 0;
my $buffer = "";
if (!$mode_global) {
    while (<>) {
        if (/Rapport/) {
            $is_reading_rapport = 1;
            $buffer = "";
        } elsif (/^-+$/) {
            $is_reading_rapport = 0;
        } elsif ($is_reading_rapport) {
            $buffer = $buffer . $_;
        }
    }
    print$buffer;
} else {
    my $dir;
    $dir = `pwd`;
    chomp $dir;
    my $dir_ending = substr $dir, -1;
    if ($dir_ending ne "/") {
        $dir = $dir . "/";
    }
    $dir = $dir . "*_res.txt";
    my @files = glob($dir);
    foreach my $currfile (@files ) {
        open $input, "<", "$currfile";
        while (<$input>) {
            if (/Rapport/) {
                $is_reading_rapport = 1;
                $buffer = "";
            } elsif (/^-+$/) {
                $is_reading_rapport = 0;
            } elsif ($is_reading_rapport) {
                $buffer = $buffer . $_;
            }
        }
        close $input;
        open $output, "+>", $currfile;
        print $output $buffer;
        close $output;
        $buffer = "";
    }
}
