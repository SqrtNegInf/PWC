#!/usr/bin/env perl
#===============================================================================
#
#         FILE: 8801.pl
#
#        USAGE: ./8801.pl N N [ ... ]
#
#  DESCRIPTION: Output an array of the products of all but the value at
#               that index.
#
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 23/11/20
#===============================================================================

use strict;
use warnings;
use integer;

my @in = <5 2 1 4 3>;

my $prod = 1;
$prod *= $_ for @in;

my @out;
push @out, $prod/$_ for @in;
print "@out\n";
