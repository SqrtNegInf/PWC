#!/usr/bin/env raku

sub MAIN (Int $max = 20) {       # 20: default input value
    my $fibo = set(0, 1, * + * ...^  * > 1000);
    my $count = 0;
    my @numbers = gather {
        for 0 .. Inf -> $num {
            if $num.comb.sum (elem) $fibo {
                take $num;
                $count++;
                last if $count >= $max;
            }
        }
    }
    say my $result = "{@numbers}";
    use Test;
    is $result, '0 1 2 3 5 8 10 11 12 14 17 20 21 23 26 30 32 35 41 44';
}
