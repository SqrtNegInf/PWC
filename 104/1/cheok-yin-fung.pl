#!/usr/bin/env perl
# The Weekly Challenge 104
# FUSC Sequence

use strict;
use warnings;

my @a = (0,1);

for my $i (2..50) {   #fixed on 08:33 BST
    $a[$i] = $i % 2 == 0 ? $a[$i/2] : $a[($i-1)/2]+$a[($i+1)/2];
}

for my $i (0..50) {
    printf "%3d %2d\n", $i, $a[$i];
}

