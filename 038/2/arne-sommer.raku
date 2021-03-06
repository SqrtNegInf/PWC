#!/usr/bin/env raku

unit sub MAIN (:$length = 7,
               :$verbose = True,
               :$dictionary where $dictionary.IO.r = "words");

my %value =
(
  A =>  1, G =>  1, I => 1, S => 1, U => 1, X => 1, Z => 1,
  E =>  2, J =>  2, L => 2, R => 2, V => 2, Y => 2,
  F =>  3, D =>  3, P => 3, W => 3,
  B =>  4, N =>  4,
  T =>  5, O =>  5, H => 5, M => 5, C => 5,
  K => 10, Q => 10
);

my %count =
(
  A => 8, G => 3, I => 5, S => 7, U => 5, X => 2, Z => 5,
  E => 9, J => 3, L => 3, R => 3, V => 3, Y => 5, F => 3,
  D => 3, P => 5, W => 5, B => 5, N => 4, T => 5, O => 3,
  H => 3, M => 4, C => 4, K => 2, Q => 2
);

sub get-dictionary ($file where $file.IO.r)
{
  return $file.IO.lines.grep(* !~~ /\W/)>>.uc.Set;
}

my %dict = get-dictionary($dictionary);

my @letters = 'PALKMEN'.comb;
#my @letters = %value.keys.map({ $_ xx %count{$_} }).sort.flat;

say "- Letters: " ~ @letters.join if $verbose;

my @legal-words = @letters.combinations(1 .. $length)>>.join.unique.grep({ %dict{$_} });

say "- Legal words: @legal-words[]" if $verbose;

my %candidates;

for @legal-words -> $word
{
  %candidates{$word} = $word.comb.map({ %value{$_} }).sum;
}

my $max-val = %candidates.values.max;

say "Most valuable word(s) at $max-val points:";
say %candidates.keys.grep({ %candidates{$_} == $max-val }).sort.join(", "), ".";
