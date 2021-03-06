#!/usr/bin/env raku

sub MAIN(Str :$S = 'ababcabd') {
    fnr-character($S).join(' => ').say;
}

#
#
# METHOD

sub fnr-character(Str $string) {

    my @fnr = ();
    for 0 .. $string.chars - 1 -> $i {
        my $s = $string.substr(0, $i + 1);
        if $s.chars == 1 {
            @fnr.push: $s;
        }
        else {
            my $found = False;
            my %count = ();
            $s.comb.map({ %count{$_}++ });
            for $s.flip.comb -> $char {
                if %count{$char} == 1 {
                    @fnr.push: $char;
                    $found = True;
                    last;
                }
            }
            @fnr.push: '#' unless $found;
        }
    }

    return @fnr.join('');
}
