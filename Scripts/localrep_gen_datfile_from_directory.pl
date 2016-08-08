#!/usr/bin/perl
#must be used in a directory with only appropriate files
#is designed to work after localrep_run_n_sims
use 5.010;

open $output, "+>", "locale_rep_ssrv.dat" or die "failed to open file: $!";
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
$dir = $dir . "*_res.txt";
say "we are looking for files matching $dir";

my @files = glob($dir);
foreach $currfile (@files ){
    say $currfile;
    open $input, "<" , "$currfile" or die "failed to open file: $!";
    my @nb_requette_envoyees_extractor = split("=", $lines[-4]);
    my $nb_requette_envoyees = $nb_requette_envoyees_extractor[-1];
    my @nb_requettes_supprimees_extractor = split("=", $lines[-3]);
    my $nb_requette_supprimees = $nb_requettes_supprimees_extractor[-1];
    while ($line = <$input>) {
      if ($line =~ /\s*nombre de requete envoyees\s*=\s*\d+/) {
        @nb_requette_envoyees_extractor = split("=", $line);
        $nb_requette_envoyees = $nb_requette_envoyees_extractor[-1];
      }

      if ($line =~ /\s*nombre de requete supprimees\s*=\s*\d+/) {
        @nb_requettes_supprimees_extractor = split("=", $line);
        $nb_requette_supprimees = $nb_requettes_supprimees_extractor[-1];
      }
    }
    close $input;
    say '$nb_requette_envoyees ' . "$nb_requette_envoyees";
    say '$nb_requette_supprimees ' . "$nb_requette_supprimees";

    my @time_extractor = split("_", $currfile);
    my $time = $time_extractor[-2];
    say 'time ' . "$time";
    say $output "#" . $currfile;
    print $output $time;
    print $output "\t";
    print $output 100*$nb_requette_supprimees/($nb_requette_supprimees + $nb_requette_envoyees);
    print $output "\n";
}
print "done! \n";
close FILE;
