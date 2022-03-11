#!/usr/bin/env raku

sub MAIN(Str:D $f where *.IO.e = 'example.csv') {
    my @a = $f.IO.lines».split(',');
    for ^@a[0].elems -> $i {
        put @a.map(*[$i]).join(',');
    }
}
