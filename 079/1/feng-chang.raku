#!/usr/bin/env raku

sub MAIN(UInt:D $N = 4) {
    my UInt $total = (1..$N).map({ $_.base(2).comb.sum }).sum;
    say "{ $total } % 1000000007 = { $total % 1000000007 }";
}
