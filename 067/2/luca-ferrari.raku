#!/usr/bin/env raku


sub MAIN( Str $S = '249') {
    my %letters =
    1 => [ '_', ',', '@' ]
    , 2 => [ 'A', 'B', 'C' ]
    , 3 => [ 'D', 'E', 'F' ]
    , 4 => [ 'G', 'H', 'I' ]
    , 5 => [ 'J', 'K', 'L' ]
    , 6 => [ 'M', 'N', 'O' ]
    , 7 => [ 'P', 'Q', 'R', 'S' ]
    , 8 => [ 'T', 'U', 'V' ]
    , 9 => [ 'W', 'X', 'Y', 'Z' ];

    my @combinations;
    for $S.comb  -> $current {
        @combinations.push( %letters{ $current } ) if %letters{ $current }:exists;
    }

    ( [X] @combinations ).join( "\n" ).lc.say;
}
