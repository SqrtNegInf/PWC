#!/usr/bin/env raku


# % raku ch-1.p6 3 1 5 0 2 9 3 7 6 4 8
# 0,0,0,2,3,3,4,4
sub MAIN( Int $S =3,
          @A =  (1, 5, 0, 2, 9, 3, 7, 6, 4, 8)) {

    my @mins;
    for 0 .. ( @A.elems - $S ) {
        @mins.push: [min] @A[ $_ ..^ ( $_ + $S ) ];
    }

    @mins.join( ',' ).say;
}
