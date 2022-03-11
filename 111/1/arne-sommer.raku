#!/usr/bin/env raku

unit sub MAIN (Int $input = 35, Str $matrix = "1 2 3 5 7 | 9 11 15 19 20 | 23 24 25 29 31 | 32 33 39 40 42 | 45 47 48 49 50"); 

my @m = $matrix.split("|")>>.words>>.List;

say + (so any(@m.List.flat) == $input);
