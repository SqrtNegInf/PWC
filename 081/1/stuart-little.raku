#!/usr/bin/env raku

sub comm_base(Str $a, Str $b) {
    (1..min($a.chars,$b.chars))
    .grep({ $a.chars %% $_ && $b.chars %% $_ })
    .map({ $a.substr(0,$_) })
    .grep({ $a eq ($_ x ($a.chars)/($_.chars)) && $b eq ($_ x ($b.chars)/($_.chars)) })
}

my @ARGS = <abcdabcd abcdabcdabcdabcd>;
say comm_base(|@ARGS[0,1]);

# run as <script> string1 string2
