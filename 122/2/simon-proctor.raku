#!/usr/bin/env raku

#| Given a number print all the possible ways to score that in basketball
sub MAIN (Int() $N = 4) {
    .say for (|(1 xx $N), |(2 xx ($N div 2)), |(3 xx ($N div 3)))
    .combinations(1..$N)
    .unique(:with(&[eqv]))
    .grep( -> @l { ([+] @l) ~~ $N } )
    .map( -> @l { @l.permutations.unique(:with(&[eqv])).Slip } )
    .map( *.join(",") )
}
