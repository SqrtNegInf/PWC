#!/usr/bin/env raku

sub MAIN (Int $m is copy = 11, $n is copy where $n != 0 = 3) {
    my $neg = ($m <0 && $n >0 or $m > 0 && $n < 0) ?? True !! False;
    $_ = .abs for $m, $n;
    my $quotient = 0;
    while $m > $n {
        $m -= $n;
        $quotient++;
    }
    $quotient = -$quotient if $neg;
    say $quotient;
}
