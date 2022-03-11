#!/usr/bin/env raku

# ch-2.raku - Transpose a CSV file
#
# Ryan Thompson <rjt@cpan.org>

sub MAIN( Str $file = 'example.csv') {
    ([Z] $file.IO.lines.map(*.split(','))).map(*.join(','))».say;
}
