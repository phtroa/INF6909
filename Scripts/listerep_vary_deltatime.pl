#!/usr/bin/perl
#this scritp assumes the tcl script has a line starting with : set val(stop)

use 5.010;
use File::Copy;
use warnings;

@ARGV > 3 or die "too few arguments expected:
-script tcl
-nb run
-deltatime min
-incr
-deltatime max";

sub build_cmdl {
  my $simulator = $_[0];
  my $tcl_to_run = $_[1];
  my $output = $_[2];

  my $cmd = $simulator . " " . $tcl_to_run;
  my $cmdl = $cmd . " > " . $output;

  return $cmdl;
}

sub launch_simulation {
  my $cmdl = $_[0];
  `$cmdl` and die "error when launching simulation: $!";

  return;
}

my $simulator = "ns";
#script parameters
my $tcl_script = $ARGV[0];
say "tcl script : $tcl_script";
my $nb_run = $ARGV[1];
say "nb run : $nb_run";
my $min = $ARGV[2];
say "lowest time : $min";
my $incr = $ARGV[3];
say "time increment : $incr";
my $max = $ARGV[4];
say "greatest time : $max";

#the program that will be run
my $cmdline;
my $result_file;

#initialize the working dir
$tcl_script =~ /(.*)\.tcl/;
my $basename = $1;
my $working_dir = $basename . "_" . $min . "_" . $incr . "_" . $max;
say "the results will be in the directory : " . $working_dir;
if (! -e $working_dir) {
  mkdir $working_dir or die "unable to create dir: $!";
}
copy $tcl_script, $working_dir . "/" . $tcl_script;
chdir $working_dir or die "unable to change dir: $!";
say "moving to working dir";

my $current_tcl;
my $current_result;
for (my $i = $min; $i <= $max; $i += $incr) {
        open my $in, "<", $tcl_script or die "unable to open file : $!"; 
        $current_tcl = $basename . "_" . $i . ".tcl";
        say "producing files : $current_tcl";
        open my $out, "+>", $current_tcl or die "unable to open file : $!";
        while (my $line = <$in>) {
            #modifies the value of th int in the line set val(stop) 100;
            if ($line =~ /set\s+\w+\(deltaTime\)\s+\d+\s+;/) {
                $line =~ s/\d+/$i/;
            }
            print $out $line;
        }
        close $out;
        close $in;

    for (my $j = 0; $j < $nb_run; $j++) {
        $current_result = $basename . "_" . $i . "_run_" . "$j" . "_" . "res.txt";
        $cmdline = build_cmdl($simulator, $current_tcl, $current_result);
        say "we are going to run $cmdline for the $j time";
        launch_simulation $cmdline;
    }
}
