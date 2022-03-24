#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);

# TASK #1 › Array of Product
# Submitted by: Mohammad S Anwar
#
# You are given an array of positive integers @N.
#
# Write a script to return an array @M where $M[i] is the product of
# all elements of @N except the index $N[i].

my @n = <5 2 1 4 3>;
my @m = (1) x @n;

for my $i (0..$#n) {
    for my $j (0..$#n) {
        $m[$j] *= $n[$i] unless $i == $j;
    }
}

say "@m";
