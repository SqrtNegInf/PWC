#!/usr/bin/env raku

multi sub MAIN(@ARGS  = ^4) {
    my @numbers = @ARGS.sort;
    my @wave;

    my $mid = @numbers.elems div 2;
    my $end = @numbers.elems - 1;

    for 0 ..^ $mid -> $i {
        @wave.push(@numbers[$end--]);
        @wave.push(@numbers[$i]);
    }
    if @numbers.elems % 2 {
        @wave.push(@numbers[$mid]);
    }

    say join q{,}, @wave;
}
