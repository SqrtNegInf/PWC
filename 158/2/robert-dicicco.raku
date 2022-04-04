#!/usr/bin/env raku

my $TARGET = 1000;
my $i = 1;
my @outarr;

sub makeCuban ( $num ) {
  my $cuban = 3 * ($num**2) + (3 * $num) + 1;
  return($cuban) if (is-prime($cuban));
  return(-1);
}

while $i < $TARGET  {
  my $retval = makeCuban($i);
  last if ($retval > $TARGET);

  if $retval > 0 {
    push(@outarr, $retval);
  }

  $i++;
}

say @outarr;
