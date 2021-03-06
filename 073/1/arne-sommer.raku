#!/usr/bin/env raku

unit sub MAIN (Int $S where * >= 1 = 3, @A= (1, 5, 0, 2, 9, 3, 7, 6, 4, 8), :v(:$verbose));

die "Integers only" unless all(@A) ~~ Int;

(0 .. @A.elems - $S).map({ say ": (" ~ @A[$_ .. $_ + $S -1].join(", ") ~ ") min -> " ~ @A[$_ .. $_ + $S -1].min }) if $verbose;

say "(", (0 .. @A.elems - $S).map({ @A[$_ .. $_ + $S -1].min }).join(", "), ")";
