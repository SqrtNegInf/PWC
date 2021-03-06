#!/usr/bin/env raku

sub noble-int(@L) {
    return @L.grep(-> $n { @L.grep({ $_ > $n }).elems == $n }).unique;
}

my @L1 = (19,11,9,7,20,3,17,16,2,14,1);
say @L1;
say noble-int(@L1);

#my @L2 = (50.rand.Int for 1..100);
#say @L2;
#say noble-int(@L2);

# An interesting question is whether or not there can be multiple Noble
# Integers in a list.
#
# Answer: Depends on your definition of multiple. For example, the list
#
#   [2, 2, 6, 1, 3]
#
# contains two Noble integers, 2 and 2. If you exclude non-unique examples I
# think there are no multiple Noble integers. Suppose there would be a list
# with multiple (unique) Noble integers. Let N be the smallest Noble integer in
# the list. I.e. there are N integers larger than N in the list. Let M be
# another Noble integer in the list. I.e. there are M integers larger than M in
# the list. All integers larger than M are also larger than N, so the number
# of integers larger than M is less than N. Hence M < N. But that contradicts
# the assumption than N was the smallest Noble integer, i.e. we just found a
# smaller Noble integer than N. Therefore, by contraction, there can only be
# one (unique) Noble integer in the list.
