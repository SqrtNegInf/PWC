#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

my @in = grep { /\d+/ } (1, 4, 3, 2);

die "You must give me a list of positive integers\n" unless @in;

my $sweets = @in;

for (0 .. $#in) {
  if ($_ > 0 and $in[$_] > $in[$_ - 1]) {
    $sweets++;
  }
  if ($_ < $#in and $in[$_] > $in[$_ + 1]) {
    $sweets++;
  }
}

say $sweets;
