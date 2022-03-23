#!/usr/bin/env raku

unit sub MAIN(UInt $n where * mod 2 = 3); #= a positive odd integer

.say for odd-magic-square($n);

sub odd-magic-square($n) {
    my @matrix = [0 xx $n] xx $n;
    my $r = 1;
    my $c = ($n / 2).floor - 1; 

    for 1..($n**2) -> $num {
        $r = ($r - 1) mod $n;
        $c = ($c + 1) mod $n;

        if @matrix[$r][$c] {
            $r = ($r + 1) mod $n + 1;
            $c = ($c - 1) mod $n;
        }
 
        @matrix[$r][$c] = $num;
    }

    @matrix.map(*.fmt( "%{ ($n**2).chars }d" ).Array);
}
