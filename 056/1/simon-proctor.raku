#!/usr/bin/env raku

use v6;

#| Given a list of positive integers take the first a k and finds the indicies i,j in the list
#| where @N[i] - @N[j] == k
sub MAIN ( UInt $k=3, @Nin = (2, 7, 9)) {
    # Sort the list
    my @N = @Nin.sort( { $^a <=> $^b } );
    say "Given the list {@N} and target $k";
    LOOP:
    for @N.keys -> $i {
        for $i..(@N.end) -> $j {
            next if $i ~~ $j;
            given @N[$j] - @N[$i] {
                when $k {
                    say "$j, $i => {@N[$j]} - {@N[$i]} = $k";
                }
                when * > $k {
                    next LOOP;
                }
            }
        }
    }
}
