#!/usr/bin/env raku

sub MAIN(
    Str $S = 'ababcabd'
) {
    my @output;

    for (1 .. $S.chars) -> $i {
        my $slice = $S.substr(0, $i);
        my $fnr = '#';

        for $slice.comb -> $c {
            if ($slice ~~ m:g/ $c / == 1) {
                $fnr = $c;
            }
        }

        @output.push($fnr);
    }

    @output.join(q{}).say;
}
