#!/usr/bin/env perl

# Challenge 021
#
# Task #1
# Write a script to calculate the value of e, also known as Euler's number and
# Napier's constant. Please checkout wiki page for more information.

use Modern::Perl;

sub calc_e {
    my $e = 1;
    my($n, $prod, $prev) = (0, 1, 0);
    while ($prev != $e) {
        $prev = $e;
        $e += 1/($prod *= ++$n);
    }
    return $e;
}

say sprintf("%.14f", calc_e());
