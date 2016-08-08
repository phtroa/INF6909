#!/usr/bin/perl
use 5.010;
use warnings;

my $mean = 0;
my $sd = 0;

readingEntry: while (<>) {
    next if (/^\s*$/);
    my @lign = split " ";

    for (my $i = 0; $i < @lign; $i++) {
        if ($i == 0) {
            print $lign[$i];
            next readingEntry if (substr($lign[$i], 1) eq "#");
            
        } else {
            $mean += $lign[$i];
            $sd += $lign[$i]**2;
        }
    }
    $mean /= (@lign - 1);
    $sd = sqrt( $sd/(@lign - 1) - $mean**2);
    say "\t" . ($mean - $sd) . "\t$mean\t" . ($mean + $sd);
    $mean = 0;
    $sd = 0;
}
