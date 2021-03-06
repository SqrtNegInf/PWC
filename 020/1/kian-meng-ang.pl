#!/usr/bin/env perl
# vi:et:sw=4 ts=4 ft=perl

use strict;
use warnings;
use utf8;
use feature qw(say);

my $str = 'bookkeeper';
my ($groups, $i, $prev) = ([], 0, substr$str, 0, 1);
foreach my $char (split //, $str) {
    $i++ if ($char ne $prev);
    $groups->[$i] .= $char;
    $prev = $char;
}

say join q|,|, ( map { sprintf '"%s"', $_ } @{$groups} );

