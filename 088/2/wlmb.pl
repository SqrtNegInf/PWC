#!/usr/bin/env perl5.32.1
# Perl Weekly Challenge 88 task 2 Spiral Matrix
# Print elements of matrix along spiral
use warnings;
use strict;
use feature qw(say);

use PDL;
use PDL::NiceSlice;

say join " ", "Example 1:", spiral_matrix([1,2,3],[4,5,6],[7,8,9]);
say join " ", "Example 2:", spiral_matrix([1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16]);

sub spiral_matrix {
    my $input =pdl(@_); #input piddle (PDL 2D array)
    my @output;
    return if $input->dim(1)==0; # 0 rows no elements
    while($input->dim(0) > 0){ #until no more columns
	push @output, $input->(:,(0))->list; # walk through row
	last if $input->dim(1)==1; # no more rows
	$input=$input->(-1:0,1:-1) #reflect rows, remove one row
	    ->transpose; # rotate
    }
    return @output
}
