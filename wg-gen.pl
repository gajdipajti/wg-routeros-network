#!/usr/bin/perl -w
#	Summary:	Generate Wireguard network for RouterOS
#	Version:	0.1 (2023-05-10)
#	Package:	crowbar-labs
#	License:	GPLv3 - https://choosealicense.com/licenses/gpl-3.0/
#	Developer:	gajdost
#	Changelog:	
#	Known limits:	

#	Run:		code/wg-gen.pl 10

use strict;
use warnings;
use feature qw(say);    # For 5.10 extra function.

# Global variables
my $idmax;
if ($#ARGV != 0) {
    say('#W# Using default values!');
	$idmax = 100;
} else {
	$idmax = $ARGV[0];
}

my @idx = (1..$idmax);
my $wgpriv;
my @wg;
my $wgpub;

foreach(@idx){
    $wgpriv = `wg genkey`;
    chomp($wgpriv);
    $wgpub  = `echo '$wgpriv' | wg pubkey`;
    chomp($wgpub);
    say("$_; 10.0.0.$_; $wgpriv; $wgpub;");
    $wg[$_] = {id => $_, wgip => "10.0.0.$_", wgpriv => $wgpriv, wgpub => $wgpub};
}

for my $key ( @wg ) 
{ for my $val ( keys %$key ) 
    { print "$val=$key->{$val} "; } 
    print "\n"; 
} 