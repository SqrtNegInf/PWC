#!/usr/bin/env raku

sub MAIN(Int $n where * > 0 = 5) {
    my @a = [0 xx $n] xx $n;
    @a[$_][$_] = 1 for 0 .. $n - 1;

    @a.say;
}
