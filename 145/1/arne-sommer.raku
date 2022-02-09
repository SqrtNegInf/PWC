#!/usr/bin/env raku

unit sub MAIN ($a = '1 2 3', $b = '4 5 6');

my @a = $a.words;
my @b = $b.words;

die '@a and @b must have the same size' unless @a.elems == @b.elems;

say (@a Z* @b).sum;
