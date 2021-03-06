#!/usr/bin/env perl
# Perl Weekly Challenge #054 Task 2

# Normal Usage: ch-2.pl [TARGET]
# It returns the Collatz sequence beginning with the target number.

# For the display of the sequence length from 1 to 1000000: 
# Usage: ch-2.pl
# it creates a file "ch-2_logfile" saving the seqence length.

# For the extra credit (the 20 numbers which have the largest seq length):
# I wanna write a selection algorithm (trying a binary heap) for getting 
# the extra credit seq length), but I have no time, ooops

use strict;
use integer;

my $MAX_U = 333334;  
# Laurent's codes and explanations on blog teach me that
# this cutting value should be fine-tuned rather 
# than making it as large as the systems allow.
# (my 40-hrs attempt use $MAX_U = 2^27; in addition, 
# those codes did not follow "YAGNI" rule - ambitious but "unoptimized",
# hence my laptop suffered for 40 hrs)

my $TARGET_BEGIN = 1;
my $TARGET_END = 10000;  


#space allocation
my @seqlength; 
my %SeqlengthLargeInt = {1 =>1};

$seqlength[1] = 1;

foreach (1..27) {
    $seqlength[2**$_] = 1+$_; 
    $SeqlengthLargeInt{2**$_} = 1+$_;
}


sub traceSmallint {
    my @route = reverse @_;

    my $h = shift @route;
    my $ref;
    foreach $ref (@route) {
        $seqlength[$ref] = 1 + $seqlength[$h];
        $h = $ref;
    }
    $SeqlengthLargeInt{$route[0]} = $seqlength[$route[0]];
}



   ###########################

    my $mazed = 23;
    print $mazed, " ";
    while ($mazed != 1) {
            if ($mazed % 2 == 1) {
                $mazed = $mazed*3+1;
            } else {
                $mazed = $mazed/2;
            }
            print $mazed, " ";
    }

