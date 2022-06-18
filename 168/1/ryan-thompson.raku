#!/usr/bin/env raku

sub MAIN(Int $max = 13) {
    .say for perrin($max);
}

sub perrin(Int $max) {
    my ($n2, $n1, $n0) = (3, 0, 2);
    my @r = (2);

    while (@r.elems < $max) {
        @r.push($n0) if $n0 > @r.tail and $n0.is-prime;
        ($n2, $n1, $n0) = ($n1, $n0, $n2 + $n1);
    }

    @r;
}
