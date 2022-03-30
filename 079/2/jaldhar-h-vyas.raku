#!/usr/bin/env raku

sub histogram(@N) {
    for @N.max ... 1 -> $y {
        say "$y ",
            (0 ..^ @N.elems).map({ @N[$_] < $y ?? q{ } !! q{#}; }).join(q{});
    }
    say '-' x @N.elems + 2;
    say q{  }, @N.join(q{});
}

sub MAIN(
    @N  =  (2,1,4,1,2,5)
) {
    my $rainwater = 0;
    my $tallest = @N[0];

    for 0 ..^ @N.elems -> $i {
        
        if (@N[$i] < $tallest) {
            $rainwater += ($tallest - @N[$i]);
        } else {
            $tallest = @N[$i];
        }
    }

    histogram(@N);
    say $rainwater;
}
