#!/usr/bin/env perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-027/
# Task #1
# Write a script to find the intersection of two straight lines.
# The co-ordinates of the two lines should be provided as command line parameter. For example:
# The two ends of Line 1 are represented as co-ordinates (a,b) and (c,d).
# The two ends of Line 2 are represented as co-ordinates (p,q) and (r,s).
# The script should print the co-ordinates of point of  intersection of the above two lines.

use strict;
use warnings;

my @foo = ('1,1', '5,1', '2,0', '2,6');

my ($x1,$y1) = split /,/, shift @foo;
my ($x2,$y2) = split /,/, shift @foo;
my ($x3,$y3) = split /,/, shift @foo;
my ($x4,$y4) = split /,/, shift @foo;

my $d = ($x1-$x2) * ($y3-$y4) - ($y1-$y2) * ($x3-$x4);
die "Segments are parallels" unless $d;

my $t = ( ($x1-$x3) * ($y3-$y4) - ($y1-$y3) * ($x3-$x4) ) / $d;
die "Intersection point out of first segment" if ($t>1 || $t<0) ;

my $u = -1 * ( ($x1-$x2) * ($y1-$y3) - ($y1-$y2) * ($x1-$x3) ) / $d;
die "Intersection point out of second segment" if ($u>1 || $u<0) ;

my $px = $x1 + $t * ($x2-$x1);
my $py = $y1 + $t * ($y2-$y1);

printf "Intersection point (%.2f,%.2f)",$px,$py;
