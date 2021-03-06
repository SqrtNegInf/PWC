#!/usr/bin/env raku

unit sub MAIN (Int $A where $A >= 1 = 50, Int $B where $B >= $A && $B <= 10 ** 15=100, :$calculator, :$v, :$verbose = $v);

my %strobo = $calculator
  ?? ( 0 => 0, 1 => 1, 2 => 5, 5 => 2, 6 => 9, 8 => 8, 9 => 6 )
  !! ( 0 => 0, 1 => 1, 6 => 9, 8 => 8, 9 => 6 );

sub is-strobogrammatic (Int $number)
{
  return False unless all($number.comb) eq any(%strobo.keys);

  my $strobo = $number.flip.comb.map({ %strobo{$_} }).join;
      
  say ": $number -> $strobo" if $verbose;
  
  return $strobo eq $number; 
}

($A .. $B).grep( *.&is-strobogrammatic ).join(", ").say;
