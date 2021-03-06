#!/usr/bin/env raku

sub MAIN(UInt:D $count? where * > 0 = 10) {
    my @primes = (^∞).grep( *.is-prime ).cache;
    
    my @strong = lazy gather {
        for 1..∞ -> $i {
            take @primes[$i] if @primes[$i] > @primes[$i-1,$i+1].sum / 2
        };
    }

    my @weak = lazy gather {
        for 1..∞ -> $i {
            take @primes[$i] if @primes[$i] < @primes[$i-1,$i+1].sum / 2
        };
    }

    say "Strong: " ~ @strong[^$count].join(",");
    say "Weak:   " ~ @weak[^$count].join(",");
}


