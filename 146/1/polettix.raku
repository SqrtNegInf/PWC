#!/usr/bin/env raku

sub MAIN (Int:D $n where * > 0 = 10001) {
   ((1 .. *).grep: *.is-prime)[$n - 1].put
}
