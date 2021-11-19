#!/usr/bin/perl

use strict;
use warnings;

use FindBin qw(
	$Bin
	$Script
	$RealBin
	$RealScript
);

print "\$Bin: $Bin\n"; # path to bin directory from where script was invoked
print "\$Script: $Script\n"; # basename of script from which perl was invoked
print "\$RealBin: $RealBin\n"; # $Bin with all links resolved 
print "\$RealScript: $RealScript\n"; # $Script with all links resolved

