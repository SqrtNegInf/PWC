#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Perl Weekly Challenge 079 Task #2 > Trapped Rain Water
#=============================================================================
# You are given an array of positive numbers @N.
# Write a script to represent it as Histogram Chart and find out how much
# water it can trap.
# Example 1: Input: (2, 1, 4, 1, 2, 5)
# As historgram:   5           #
#                  4     #     #
#                  3     #     #
#                  2 #   #   # #
#                  1 # # # # # #
#                  _ _ _ _ _ _ _
#                    2 1 4 1 2 5
# Concave units that can trap water:
#                  5           |
#                  4     | O O |
#                  3     | O O |
#                  2 | O | O _ |
#                  1 | _ | _ | |
#                  _ _ _ _ _ _ _
#                    2 1 4 1 2 5
# Answer: 6

use strict;
use warnings;
use v5.30;

use feature qw/ signatures /;
no warnings qw/ experimental::signatures /;

use Getopt::Long;

use lib ".";
use TrappedRainWater;

#sub Usage { "Usage: $0 list-of-int-gt-0" };

my $Verbose = 0;
GetOptions('verbose' => \$Verbose);

my $list = "(2,1,4,1,2,5)";

die Usage() unless $list;

$list =~ s/[(),]/ /g;
my @list = split(" ", $list);

die Usage() unless grep /\d+/, @list;

my $task = TrappedRainWater->new(\@list);
$task->show() if $Verbose;

my $result = $task->run();
$task->show() if $Verbose;
say "-----\n", $result;
