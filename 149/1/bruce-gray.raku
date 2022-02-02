#!/usr/bin/env raku 

multi sub is-fibonacci (       0 --> True ) { }
multi sub is-fibonacci ( UInt $n --> Bool ) {
    constant φ = ( 1 + 5.sqrt ) / 2;
    constant @fib = 0, 1, { $^a + $^b } … Inf;

    # my $k = ( ($n * 5.sqrt).log / φ.log ).round;    #  20% Faster
    my $k = @fib.first: :k, * >= $n;              # 100% Clearer

    return @fib[$k] == $n;
}

constant @s = grep *.comb.sum.&is-fibonacci, ^Inf;

sub MAIN ( UInt $count = 20 ) {
    say my $result = @s.head($count).join(", ");
    use Test;
    is $result, '0, 1, 2, 3, 5, 8, 10, 11, 12, 14, 17, 20, 21, 23, 26, 30, 32, 35, 41, 44';
}

# Exactly reproduce https://oeis.org/A028840/b028840.txt
# say "{.key + 1} {.value}" for @s.head(10_000).pairs;
# say '' for ^63;
