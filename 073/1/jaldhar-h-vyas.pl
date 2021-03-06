#!/usr/bin/env perl
use 5.020;
use warnings;
use English qw/ -no_match_vars /;

sub usage {

    print<<"-USAGE-";
Usage:
  $PROGRAM_NAME <S> [<A> ...]

    <S>          size of sliding window
    [<A> ...]    list of integers
-USAGE-

    exit 0;
}

sub min {
    my @A = @{ $_[0] };
    my $least = $A[0];

    for my $i (1 .. scalar @A - 1) {
        if ($A[$i] < $least) {
            $least = $A[$i];
        }
    }

    return $least;
}

my $S = shift // 3;
my @A =  (1, 5, 0, 2, 9, 3, 7, 6, 4, 8);

if (!scalar @A) {
    usage();
}

my @output;

for my $i (0 .. scalar @A - $S) {
    push @output, min([ @A[$i .. $i + $S - 1] ]);
}

say join q{ }, @output;
