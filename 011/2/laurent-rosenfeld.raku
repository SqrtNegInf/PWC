#!/usr/bin/env raku

sub pretty-print (@matrix) {
    for @matrix -> @rows {
        say join " ", @rows;
    }
}

#sub MAIN (Int $size is copy = 5) {
    my $size = 5;
    my @matrix;
    $size--;
    for 0..$size -> $i {
        for 0..$size -> $j {
            @matrix[$i][$j] = $i == $j ?? 1 !! 0;
        }
    }
    pretty-print @matrix;
#}
