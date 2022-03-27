#!/usr/bin/env raku
# -*- Mode: Raku; indent-tabs-mode: nil; coding: utf-8 -*-
# vim: set et ts=4 sw=4:

# personal-blog: https://dev.to/jeongoon/weekly-challenge-083-task-2-raku-2cjm

#multi MAIN ($n where * > 0) { say 0 }

my @n = <12 7 4 5 6 9 20 12 7 4 5 6 9 20 9 4 2 1 13>;

# without race
#multi MAIN (*@n where { @n.all ~~ Int and @n.all > 0 }) {
if ($*VM ~~ /jvm/)  {
    my $s = @n.sum;
    @n.combinations( 1..^ @n ).
    map(
        -> \n {
            with $s - 2 * n.sum { # same as ( $s- n.sum ) - n.sum
                next if $_ < 0;
                $_ => n.elems
            }
        } ).
    min.
    value.
    say
}

# tested with: raku jeongoon/raku/ch-2.raku --r 12 7 4 5 6 9 20 12 7 4 5 6 9 20 9 4 2 1 13
# finished in under 4 seconds on my laptop
#multi MAIN ( Bool:D :$r, *@n where { @n.all ~~ Int and @n.all > 0 }) {
if ($*VM !~~ /jvm/)  {
    #$*ERR.say( "using race ..." );
    my $s = @n.sum;
    @n.combinations( 1..^ @n ).
    race( :8degree:500batch ).
    map(
        -> \n {
            with $s - 2 * n.sum { # same as ( $s- n.sum ) - n.sum
                next if $_ < 0;
                $_ => n.elems
            }
        } ).
    race( :8degree:500batch ).
    min.
    value.
    say
}
