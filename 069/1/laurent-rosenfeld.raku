#!/usr/bin/env raku

#sub MAIN (Int $i, Int $j where 1 <= $i <= $j <= 1e15) {
    my ($i,$j) = 0, 200;
    for $i..$j -> $k {
        next if $k ~~ / <-[0689]> /;
        say $k if $k eq $k.flip.map({TR/69/96/});
    }
#}
