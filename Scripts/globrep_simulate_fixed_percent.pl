#!/usr/bin/perl
#run simulation until a fixed percent of malicious nodes is met
#doit etre appele depuis le répertiore du fichier tcl
my $BASENAME = "percent_malicious.txt";
my $DIR = "malicious_percent_workspace";
my $BASEDIR = "..";

$ARGV < 1 or die "too few arguments";
my $required_percent = $ARGV[0];
my $accepted_error = $ARGV[1];
mkdir( $DIR );

sub launch_ns {
    my @ns_result = `ns ns2-aodv_1.tcl` or die "$!";
    my @percents = split(",", $ns_result[-2]);

    chdir( $DIR ) or die "Couldn't go inside $DIR Directory, $!";
    open FILE, "+>$BASENAME" or die "$!";
    foreach my $line (@ns_result) {
        print FILE $line;
    }
    close FILE;

    my $newname = int($percents[1]);
    $newname = $newname . "_" . $BASENAME;
    rename $BASENAME, $newname;

    chdir( $BASEDIR ) or die "Couldn't go inside $DIR Directory, $!";
    return $percents[1];
}

sub check_already_computed {
    chdir( $DIR ) or die "Couldn't go inside $DIR Directory, $!";
    my @files = glob( $DIR );

    my @names;
    foreach ( @files ){
        @names = split("_", $_);
        if (abs($names[0] - $required_percent) > $accepted_error) {
            return 1;
        }
    }

    chdir( $BASEDIR ) or die "Couldn't go inside $DIR Directory, $!";
    return 0;
}

if (!check_already_computed()) {
    my $percent = launch_ns();
    while ( abs($percent - $required_percent) > $accepted_error) {
        $percent = launch_ns();
    }
} else {
    print "already computed";
    print "\n";
}
