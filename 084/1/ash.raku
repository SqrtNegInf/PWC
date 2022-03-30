#!/usr/bin/env raku
#
# Task 1 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-084/
#
# $ raku ch-1.raku 1234
# 4321
#
# $ raku ch-1.raku -4321
# -1234
#
# $ raku ch-1.raku 2147483647
# 0
#
# $ raku ch-1.raku 2147483641
# 1463847412
#
# $ raku ch-1.raku -2147483641
# -1463847412
#
# $ raku ch-1.raku -2147483647
# 0

.&flippy for <
1234
-1234
1231230512
7463847412
8463847412
9463847412
-7463847412
-8463847412
-9463847412
1293813258147503849520438967203896091459181238574563459102384573463457360972346
-293813258147503849520438967203896091459181238574563459102384573463457360972346
>;

sub flippy($n) {
my $r = $n.sign * $n.abs.flip;
say -2147483648 <= $r <= 2147483647 ?? $r !! 0;
}