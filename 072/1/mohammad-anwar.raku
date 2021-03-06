#!/usr/bin/env raku

sub MAIN(Int :$N where { $N <= 10 } = 10 ) {
    my ($factorial, $zero-count) = find-trailing-zeroes($N);

    say sprintf("%d => %d", $factorial, $zero-count);
}

sub find-trailing-zeroes(Int $N is copy where $N <= 10) {

    # generate factorial
    $N *= $_ for 1..$N-1;

    # match trailing zeroes
    my $trailing-zeroes = $N ~~ m/ <[1..9]>?(<[0]>+)$ /;

    return
    ($trailing-zeroes)
    ??
    ($N, $trailing-zeroes[0].codes)
    !!
    ($N, 0);
}
