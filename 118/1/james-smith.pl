#!/usr/bin/env perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

my @TESTS = (
  [ 5, 1 ],
  [ 4, 0 ],
  [ 9, 1 ],
  [ 90, 0 ],
  [ 45, 1 ],
  [ 15, 1 ],
  [ 31, 1 ],
  [ 63, 1 ],
  [ 127, 1 ],
  [ 255, 1 ],
  [ 129, 1 ],
  [ 65, 1 ],
  [ 247, 0 ],
  [ 200,0],
  [ 500,0],
  [ 100,0],
  [ 400,0],
  [ 300,0],
);

is( is_binary_palindrome($_->[0]), $_->[1] ) foreach @TESTS;
is( is_binary_palindrome_string($_->[0]), $_->[1] ) foreach @TESTS;

done_testing();

sub is_binary_palindrome_string {
  ## This is the core perl solution convert to binary using sprintf
  ## [this is faster than unpack and doesn't have issue with leading 0s!]
  ## and compare with reverse...
  return ( ( $a = sprintf '%b', $_[0] ) eq reverse $a ) || 0;
}

sub is_binary_palindrome {
  ## Can we write an array based one which is faster! Answer NO!
  ## We work from both ends to see if the numbers are different
  ## if they are return 0
  ## o/w we get to the end and return 1
  my @n = split m{}, sprintf '%b', shift;
  (pop @n eq shift @n) || return 0 while @n > 1;
  return 1;
}
