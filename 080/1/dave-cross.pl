#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

my @in = grep { /-?\d+/ } (5, 2, -2, 0);

die "You must give me a list of integers\n" unless @in;

my %ints = map { $_ => 1 } @in;

my $i = 1;

while (1) {
  last if ! exists $ints{$i};
  $i++;
}

say $i;
