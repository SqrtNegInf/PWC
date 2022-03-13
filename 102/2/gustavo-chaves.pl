#!/usr/bin/env perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-102/
# TASK #2 › Hash-counting String

use 5.030;
use warnings;

my $N = 120;

my $string = '#';

while ($N > 1) {
    $string = "$N$string";
    $N -= 1 + length "$N";
    $string = "#$string" if $N > 0;
}

say $string;
