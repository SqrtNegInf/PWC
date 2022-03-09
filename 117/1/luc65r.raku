#!/usr/bin/env raku

sub MAIN(Str:D $file = 'example.txt') {
    my @ns = $file.IO.lines».match(/\d+/)».UInt;
    .key.say for (@ns.min .. @ns.max) ∖ @ns;
}
