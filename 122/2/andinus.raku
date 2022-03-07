#!/usr/bin/env raku

#| scoring basketball points
unit sub MAIN(Int $score = 4);

.put for gather for [X] ((0,1, 2, 3) xx $score) -> @scores {
    take @scores if ([+] @scores) == $score;
}.map(*.grep(* !== 0).join).unique.map(*.comb);
