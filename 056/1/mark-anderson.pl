#!/usr/bin/env perl
use Modern::Perl;
use Algorithm::Combinatorics 'combinations';
use List::Util 'all';

# Usage:   perl ch-1.pl @N $k
# Example: perl ch-1.pl 2 7 9 2
# Output:  2,1

my @ARGV = (2, 7, 9, 2);

my $k = pop @ARGV;

my $combo = combinations([keys @ARGV], 2);

while (my $indices = $combo->next) {
    my ($i, $j) = $indices->@*;
    say "$j,$i" if $ARGV[$j] - $ARGV[$i] == $k;
}
