#!/usr/bin/env raku

#sub MAIN(UInt:D $m where 0 ≤ * ≤ 255, UInt:D $n where 1 ≤ * ≤ 8) {
my ($m, $n)  =  12, 3;
    put $m +^ (1 +< ($n - 1));
#}
