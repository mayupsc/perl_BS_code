#!/usr/bin/perl -w

#use File::Spec;
#my $outFile_ge9 = File::Spec->catfile($outDir, join(".", @parts) . "_ge9." . $ext);

use strict;
use File::Spec;

my $script = "/Users/tang58/Kai_BS/myown/select_DMR_Ecker_method/select_DMR_output_list_v0.2.pl";
die unless (-e $script);

print STDERR "script used:\n";
print STDERR $script, "\n\n\n";

my $debug = 0;

#my $p_value = 0.01;

if($debug){
	print STDERR "debug = 1\n\n";
}
my $usage = "$0 \n <indir> <outdir> <p_value> <dep> \n\n";
die $usage unless(@ARGV == 4);

my $indir = shift or die;
die unless (-d $indir);

my $outdir = shift or die;
die unless (-d $outdir);

my $p_value = shift or die;
my $dep     = shift or die;

opendir(DIR, $indir) or die;
#my @files = grep /_both\.txt$/, readdir DIR;
my @files = grep /\.txt$/, readdir DIR;
closedir DIR;

#<input> <outdir> <pre> <p_value>
#col_0_pooled_vs_12_pooled_diff_bases_P0.01_depth_4_100_both.txt
foreach my $file (@files){
	if($file =~ /_vs_(\S+)_diff_.+\.txt$/){
		my $input = File::Spec->catfile($indir, $file);
		
		my $pre = $1;
		my $cmd = "time perl $script $input $outdir $pre $p_value $dep";
		print STDERR $cmd, "\n\n";
		if(!$debug){
			`$cmd`;
		}
	}
}

exit;

sub round {
    my($number) = shift;
    #return int($number + .5);
    return int($number + .5 * ($number <=> 0)); # take care of negative numbers too

}
