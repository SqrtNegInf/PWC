#!/usr/bin/env perl
# Perl weekly challenge 131
# Task 1:  Consecutive arrays
#
# See https://wlmb.github.io/2021/09/21/PWC131/#task-1-consecutive-arrays
use v5.12;
use warnings;
my @A = (1, 2, 3, 6, 7, 8, 9);

say "Input: (", join(", ", @A),")\nOutput: ([",
    join("], [",
    (map {join ", ", @$_}
         consecutives(sort {$a<=>$b} @A))), "])";

sub consecutives { # Return array of arrays of consecutive integers
    my @in=@_; # assume they are integers.
    my @out;
    while(@in){
	my $c=shift @in;
	my @seq=($c);
	push @seq, shift @in while(@in && $in[0]==++$c);
	push @out, [@seq];
    }
    return @out;
}
