#!/usr/bin/env perl
use 5.020;
use warnings;
use English qw/ -no_match_vars /;
use Getopt::Std;

sub usage {

    print<<"-USAGE-";
Usage:
  $PROGRAM_NAME [-A=<" ... ">] [-B=<" ... ">]
  
    -A=<" ... ">    A string consisting of integers separated by spaces.
    -B=<" ... ">    A string consisting of integers separated by spaces.
-USAGE-

    exit 0;
}

sub rotate {
    my ($n, $arr) = @_;
    my @arr = @{$arr};

    for (1 .. $n) {
        push @arr, shift @arr;
    }

    return @arr;
}

my @A = (10,20,30,40,50); my @B = (3,4);

map { say q{[}, (join q{ }, rotate($_, \@A)), q{]}; } @B;
