#!/usr/bin/env raku

sub MAIN(Str $S = 'RAKU ROCKS', Int $N = 13 ) {
   my $fn = -> $x { ((($x.ord +'A'.ord -($N)) %26) +'A'.ord).chr };
   $S.words.map({ $_.comb().map( {$fn($_)}).join("") }).join(" ").say
}
