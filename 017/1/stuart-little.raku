#!/usr/bin/env raku

multi sub A(0,Int $n) { $n + 1 }
multi sub A(1,Int $n) { $n + 2 }
multi sub A(2,Int $n) { 2*$n + 3 }
multi sub A(3,Int $n) { 2 ** ($n + 3) -3 }
multi sub A(Int $m,0) { A($m-1,1) }
multi sub A(Int $m,Int $n) { A($m-1,A($m,$n-1)) }

say A(|(1,2).map(*.Int))
