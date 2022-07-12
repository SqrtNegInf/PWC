#!/usr/bin/env raku

srand 1;

use Statistics;

my @test=();
for (1..925_089) {
	push @test, rand;
}

say fivenum(@test); #-- built-in

#(1.9337635626115457e-06 0.2505242942758381 0.5005684431380041
# 0.7503169554857986 0.9999993436204229)

