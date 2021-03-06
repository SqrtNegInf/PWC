#!/usr/bin/env raku

subset UCASE of Str where * ~~ /^<[A .. Z]>+$/;

unit sub MAIN (UCASE $uppercase-string = 'LXFOPVEFRNHR', UCASE $key = 'LEMON', :$decrypt = True);
#unit sub MAIN (UCASE $uppercase-string = 'ATTACKATDAWN', UCASE $key = 'LEMON', :$decrypt = False);

my $base = "A".ord;
my $key-length = $key.chars;

my @string = $uppercase-string.comb.map({ $_.ord - $base });
my @key    = $key.comb.map({ $_.ord - $base });

for ^@string.elems -> $p
{
  my $k = $p mod $key-length;

  $decrypt
    ?? print ($base + (@string[$p] - @key[$k] + 26) mod 26).chr
    !! print ($base + (@string[$p] + @key[$k]) mod 26).chr;
}

print "\n";
