#!/usr/bin/env raku

sub sum3( Int $T, *@L ) {
    @L.combinations(3).grep( $T == *.sum )
}

use Test;

is-deeply [sum3( 0, -25, -10, -7, -3, 2, 4, 8, 10 )], 
    [ $(-10, 2, 8), $(-7, -3, 10) ];
is-deeply [sum3( -2, -4, -1, 0, 3, 4 )],                [ $(-4, -1, 3) ];
is-deeply [sum3( -1, -6, -5, 0, 5 )],                   [ $(-6, 0, 5)  ];
is-deeply [sum3( 0, -6, -1, 0, 1, 2 )],                 [ $(-1, 0, 1)  ];
is-deeply [sum3( 2, -8, -5, -2, 3, 4, 5 )],             [ $(-5, 3, 4)  ];
is-deeply [sum3( -3, -7, -6, -5, 0, 5, 6, 8 )],         [ $(-6, -5, 8) ];
is-deeply [sum3( 0, -10, -9, -5, -4, -2, -1, 1, 5 )],   [ $(-4, -1, 5) ];
is-deeply [sum3( -4, -11, -7, -6, -5, 2, 3, 4, 5, 6, 9 )], 
    [ $(-11, 2, 5), $(-11, 3, 4), $(-7, -6, 9) ];
is-deeply [sum3( 1, -10, -5, -3, 0, 6, 7, 8, 9, 11 )], 
    [ $(-10, 0, 11), $(-5, -3, 9), $(-5, 0, 6) ];
