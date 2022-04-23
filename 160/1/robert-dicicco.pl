#!/usr/bin/env perl

use strict;
use warnings;
use feature qw/say/;

my %num_name = (
                '1' => 'One',
                '2' => 'Two',
                '3' => 'Three',
                '4' => 'Four',
                '5' => 'Five',
                '6' => 'Six',
                '7' => 'Seven',
                '8' => 'Eight',
                '9' => 'Nine',
              );

my $n = 9;

die "Value must be an integer 1-9\n" if (($n < 1) || ($n > 9));

print "Input: \$n = $n\n";

while( $n != 4 ) {
  my $len = length($num_name{$n});
  print "$num_name{$n} is $num_name{$len}, ";

  $n = $len;
}

print "Four is magic.\n";
