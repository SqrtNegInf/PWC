#!/usr/bin/env raku

subset PositiveInt of Int where * >= 1;

unit sub MAIN (PositiveInt $N = 377, :v(:$verbose), :u(:$upto));

my $label;
my $found;


$upto
  ?? (1..$N).map({ fibonal-decomposition($_) })
  !! fibonal-decomposition($N);

sub fibonal-decomposition($target)
{
  $found = False;
  $label = 'a';
  
  my @fibs;
  my $fibonacci := (1, 1, * + * ... Inf);

  for $fibonacci -> $fib { last if $fib > $target; @fibs.unshift: $fib; }
  @fibs.pop;

  if $verbose
  {
    say ": Target: $target" if $upto;
    say ": Fibonacci (reverse): { @fibs.join(", ") }";
  }

  recurse(0, (), @fibs, $target);

  say "0" unless $found;
  say "" if $upto;
}

sub recurse ($value is copy, @values is copy, @fibonacci is copy, $input)
{
  if $value < $input
  {  
    while @fibonacci
    {
      my $add = @fibonacci.shift;
      
      if $value + $add <= $input
      {  
        my $value2  = $value + $add;
	my @values2 = @values.clone.push: $add;
        recurse($value2, @values2, @fibonacci, $input);
      } 
    }
  }

  elsif $value == $input
  {
    say "{ $label++ }) { @values.join(' + ') } = $input";
    $found = True;
  }
}
