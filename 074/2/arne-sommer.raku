#!/usr/bin/env raku

unit sub MAIN ($S = 'ababcabd', :v(:$verbose));

my $length = $S.chars;

my $result;

for 1 .. $length -> $pass
{
  my $substring = $S.substr(0, $pass);

  my %count;
  my @characters;

  for $substring.comb.reverse -> $character
  {
    @characters.push($character) unless %count{$character};
    %count{$character}++;
  }

  my $found = '#';
  
  for @characters -> $character
  {
    if %count{$character} == 1
    {
      $found = $character;
      last;
    }
  }

  $result ~= $found;

  say ": Pass $pass: \"$substring\" FNR: $found" if $verbose;
}

say $result;

