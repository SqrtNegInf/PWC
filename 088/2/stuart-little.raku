#!/usr/bin/env raku

# needed 'cached'

use experimental :cached;

sub peel(@a) is cached { |@a[0], |@a[1..*].map(*.[*-1]) }
sub core(@a) is cached { @a[1..*].map(*.[0..*-2]) }

sub spiral(@a) { 
    return peel(@a) if min(@a.elems,@a[0].elems) == 1;
    return |@a.&peel, |@a.&core.map(*.reverse).reverse.&spiral
}

my @a0=[
    [ 1, 2, 3 ],
    [ 4, 5, 6 ],
    [ 7, 8, 9 ],
];

my @a1=[
    [  1,  2,  3,  4 ],
    [  5,  6,  7,  8 ],
    [  9, 10, 11, 12 ],
    [ 13, 14, 15, 16 ],
];

my @a2=[
    [  1,  2,  3,  4 ],
    [  5,  6,  7,  8 ],
];

#for (@a0,@a1,@a2) {.&spiral.say}
say spiral(@a0);
say spiral(@a1);
say spiral(@a2);
