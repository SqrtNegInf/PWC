#!/usr/bin/env raku

my @a = 0, 1, 2;
for 3..10 -> $n {
    @a[$n] = $n * @a[$n -1] - ($n - 1) * @a[$n - 2];
}
say @a[1..10];
