#!/usr/bin/perl
#must be used in a directory with only appropriate files
#is designed to work after listerep_vary_deltatime.pl
use 5.010;

my $dir;
if ($ARGV < 1) {
    $dir = `pwd`;
} else {
    $dir = $ARGV[0];
}
chomp $dir;
my $dir_ending = substr $dir, -1;
if ($dir_ending ne "/") {
    $dir = $dir . "/";
}
$dir = $dir . "*_res.txt";
#say "we are looking for files matching $dir";

#reputation values
my $nb_malicieux_recu = 0;
my $nb_malicieux_supp = 0;
my $deltaTime = 0;
my %deltasTovalues = {};
my %isinitialized = {};

my @files = glob($dir);
foreach $currfile (@files ) {
    $currfile =~ m/.*?_(\d+)_run_.*/;
    $deltaTime = $1;
    open $input, "<", "$currfile" or die "unable to open file: $!";
    while (<$input>) {
        if (/malicieux recu.*?(\d+)/) {
            $nb_malicieux_recu = $1;
        } elsif (/malicieux supprimmes.*?(\d+)/) {
            $nb_malicieux_supp = $1;
        }
    }
    close $input;
    if (!$isinitialized{$deltaTime}) {
        $deltasTovalues{$deltaTime} = "$deltaTime";
        $isinitialized{$deltaTime} = 1;
    }
    $deltasTovalues{$deltaTime} = $deltasTovalues{$deltaTime} . "\t" . ($nb_malicieux_supp/$nb_malicieux_recu) * 100;
}

foreach (values(%deltasTovalues)) {
    say;
}
