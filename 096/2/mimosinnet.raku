#!/usr/bin/env raku
# The solution follows the Wagner-Fisher algorithm,
# see: https://en.wikipedia.org/wiki/Wagner%E2%80%93Fischer_algorithm

#!/usr/bin/env raku
class Distance {

  has Str $.s1;
  has Str $.s2;

  method distance() {
    return $!s1.chars if $!s2.chars == 0;
    return $!s2.chars if $!s1.chars == 0;
    min (
      Distance.new( s1 => $!s1.chop, s2 => $!s2      ).distance + 1, # deletion
      Distance.new( s1 => $!s1     , s2 => $!s2.chop ).distance + 1, # insertion
      Distance.new( s1 => $!s1.chop, s2 => $!s2.chop ).distance + !($!s1.substr(*-1) eq $!s2.substr(*-1)).Num; # substitution cost
    );
  }
}

#multi sub MAIN( 'test' ) {
  use Test;

  is Distance.new( s1 => "kitten", s2 => "sitting").distance, 3;
  is Distance.new( s1 => "sunday", s2 => "monday" ).distance, 2;
#}
