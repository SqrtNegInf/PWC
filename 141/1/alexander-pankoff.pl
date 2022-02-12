#!/usr/bin/env perl

use strict;
use warnings;
use feature qw'say signatures';
no warnings 'experimental::signatures';

use constant DEBUG => $ENV{DEBUG} // 0;

run() unless caller();

sub run() {
    say join( ' ', find_k_lowest_integers_with_exactly_n_divisors( 10, 8 ) );
}

sub find_k_lowest_integers_with_exactly_n_divisors ( $k, $n ) {
    my @out;

    for ( my $i = 1 ; @out < $k ; $i++ ) {
        my @divisors = find_divisors($i);
        if ( @divisors == $n ) {
            push @out, $i;
            explain( $i, scalar @out, @divisors ) if DEBUG;
        }
    }
    return @out;
}

sub find_divisors($x) {
    return 1 if $x == 1;
    my @out;
    my $max = $x;
    for ( my $i = 1 ; $i < $max ; $i++ ) {
        if ( $x % $i == 0 ) {
            $max = $x / $i;
            push @out, $i;
            push @out, $max if $i != $max;
        }
    }

    return @out;
}

sub explain ( $x, $count, @divisors ) {
    say "$x is the "
      . to_ordinal($count)
      . " such number having exactly "
      . scalar @divisors
      . " divisors.";
    say join( ", ", sort { $a <=> $b } @divisors );

}

sub to_ordinal($x) {
    my %map = (
        1  => 'first',
        2  => 'second',
        3  => 'third',
        4  => 'fourth',
        5  => 'fifth',
        6  => 'sixth',
        7  => 'seventh',
        8  => 'eigth',
        9  => 'nineth',
        10 => 'tenth',
    );

    return $map{$x} // $x . 'th';
}
