#!/usr/bin/env perl
use warnings;
use strict;

{   package MyInterval;

    use enum 'BITMASK:' => qw( LEFT RIGHT SINGLE );

    sub new { bless {}, shift }

    sub insert {
        my ($self, $from, $to) = @_;
        $self->{$from} |= SINGLE, return if $from == $to;
        $self->{$from} |= LEFT;
        $self->{$_} = LEFT | RIGHT for $from + 1 .. $to - 1;
        $self->{$to} |= RIGHT;
    }

    sub out {
        my ($self) = @_;
        my @r;
        for my $k (sort { $a <=> $b } keys %$self) {
            if (($self->{$k} & (LEFT | RIGHT)) == LEFT) {
                push @r, [$k];
            } elsif (($self->{$k} & (LEFT | RIGHT)) == RIGHT) {
                push @{ $r[-1] }, $k
            } elsif ((! @r || 1 != @{ $r[-1] }) && ($self->{$k} == SINGLE)) {
                push @r, [$k, $k];
            }
        }
        return \@r
    }
}

use Test::More;

sub test {
    my ($init, $expected) = @_;
    my $i = 'MyInterval'->new;
    $i->insert(@$_) for @{ $init };
    is_deeply $i->out, $expected,
        join ', ', map do {local $" = ':'; "@$_"}, @$init;
}

test([[1,2]], [[1,2]]);
test([[1,2],[3,4]], [[1,2],[3,4]]);
test([[3,4],[1,2]], [[1,2],[3,4]]);
#                                 1 2 3 4 5 6
#                                   |-----|
test([[2,5],[1,2]], [[1,5]]);  #  |-|
test([[2,5],[1,3]], [[1,5]]);  #  |---|
test([[2,5],[1,5]], [[1,5]]);  #  |-------|
test([[2,5],[1,6]], [[1,6]]);  #  |---------|
test([[2,5],[2,3]], [[2,5]]);  #    |-|
test([[2,5],[2,5]], [[2,5]]);  #    |-----|
test([[2,5],[2,6]], [[2,6]]);  #    |------|
test([[2,5],[3,4]], [[2,5]]);  #      |-|
test([[2,5],[3,5]], [[2,5]]);  #      |---|
test([[2,5],[3,6]], [[2,6]]);  #      |-----|
test([[2,5],[5,6]], [[2,6]]);  #          |-|

test([[1,3],[5,7],[-1,0]], [[-1,0],[1,3],[5,7]]);
test([[1,3],[5,7],[-1,1]], [[-1,3],[5,7]]);
test([[1,3],[5,7],[-1,2]], [[-1,3],[5,7]]);
test([[1,3],[5,7],[-1,3]], [[-1,3],[5,7]]);
test([[1,3],[5,7],[-1,4]], [[-1,4],[5,7]]);
test([[1,3],[5,7],[-1,5]], [[-1,7]]);
test([[1,3],[5,7],[-1,6]], [[-1,7]]);
test([[1,3],[5,7],[-1,7]], [[-1,7]]);
test([[1,3],[5,7],[-1,8]], [[-1,8]]);

test([[1,3],[5,7],[1,2]], [[1,3],[5,7]]);
test([[1,3],[5,7],[1,3]], [[1,3],[5,7]]);
test([[1,3],[5,7],[1,4]], [[1,4],[5,7]]);
test([[1,3],[5,7],[1,5]], [[1,7]]);
test([[1,3],[5,7],[1,6]], [[1,7]]);
test([[1,3],[5,7],[1,7]], [[1,7]]);
test([[1,3],[5,7],[1,8]], [[1,8]]);

test([[1,3],[5,7],[2,2]], [[1,3],[5,7]]);
test([[1,3],[5,7],[2,3]], [[1,3],[5,7]]);
test([[1,3],[5,7],[2,4]], [[1,4],[5,7]]);
test([[1,3],[5,7],[2,5]], [[1,7]]);
test([[1,3],[5,7],[2,6]], [[1,7]]);
test([[1,3],[5,7],[2,7]], [[1,7]]);
test([[1,3],[5,7],[2,8]], [[1,8]]);

test([[1,3],[5,7],[3,3]], [[1,3],[5,7]]);
test([[1,3],[5,7],[3,4]], [[1,4],[5,7]]);
test([[1,3],[5,7],[3,5]], [[1,7]]);
test([[1,3],[5,7],[3,6]], [[1,7]]);
test([[1,3],[5,7],[3,7]], [[1,7]]);
test([[1,3],[5,7],[3,8]], [[1,8]]);

test([[1,3],[5,7],[4,4]], [[1,3],[4,4],[5,7]]);
test([[1,3],[5,7],[4,5]], [[1,3],[4,7]]);
test([[1,3],[5,7],[4,6]], [[1,3],[4,7]]);
test([[1,3],[5,7],[4,7]], [[1,3],[4,7]]);
test([[1,3],[5,7],[4,8]], [[1,3],[4,8]]);

test([[1,3],[5,7],[5,5]], [[1,3],[5,7]]);
test([[1,3],[5,7],[5,6]], [[1,3],[5,7]]);
test([[1,3],[5,7],[5,7]], [[1,3],[5,7]]);
test([[1,3],[5,7],[5,8]], [[1,3],[5,8]]);

test([[1,3],[5,7],[6,6]], [[1,3],[5,7]]);
test([[1,3],[5,7],[6,7]], [[1,3],[5,7]]);
test([[1,3],[5,7],[6,8]], [[1,3],[5,8]]);

test([[1,3],[5,7],[7,7]], [[1,3],[5,7]]);
test([[1,3],[5,7],[7,8]], [[1,3],[5,8]]);

test([[1,3],[5,7],[8,8]], [[1,3],[5,7],[8,8]]);


test([[1,2],[5,6],[3,4]], [[1,2],[3,4],[5,6]]);
test([[1,2],[5,6],[2,5]], [[1,6]]);
test([[1,1],[2,2],[3,3]], [[1,1],[2,2],[3,3]]);

test([[0,6],[7,8],[12,19],[3,8]],[[0,8],[12,19]]);
test([[12, 14], [15, 19], [7, 8], [1, 12]],
     [[1,14],[15,19]]);
test([[12, 17], [18, 18], [9, 9], [5, 17]],
     [[5,17],[18,18]]);

test([[2, 7], [3, 9], [10, 12], [15, 19], [18, 22]],
     [[2, 9], [10, 12], [15, 22]]);

done_testing();