#!/usr/bin/env raku

subset IntTwo of Int where * >= 2;

unit sub MAIN (IntTwo $N = 95, :a(:$all), :l(:$loquacious), :v(:$verbose) = $loquacious || $all, :u(:$upto), :f(:$first));

$upto
  ?? (2..$N).map({ primal-decomposition($_) })
  !! primal-decomposition($N);

my $input;
my $shortest;
my @result;

sub primal-decomposition ($N)
{
  $input = $N;
  
  my @primes = (2 .. $input).grep( *.is-prime ).reverse;

  say ": Primes (reverse): { @primes.join(", ") }" if $verbose;

  @result   = ();
  $shortest = Inf;

  recurse(0, (), @primes, $input);

  if $verbose
  {
    for @result -> @array
    {
      say ": Result: [{ @array.join(", ") }]";
    }
  }
  say $upto
    ?? "$N -> { @result[0].elems }"
    !! @result[0].elems;
}

sub recurse ($value is copy, @values is copy, @primes is copy, $input)
{
  return if @values.elems > $shortest && ! $all;

  return if @values.elems == $shortest && $first;

  if $value < $input
  {  
    while @primes
    {
      my $add = @primes[0];
      
      if $value + $add <= $input
      {  
        my $value2  = $value + $add;
	my @values2 = @values.clone.push: $add;
        recurse($value2, @values2, @primes, $input);
      }
      @primes.shift;
    }
  }

  elsif $value == $input
  {
    if @values.elems < $shortest
    {
      $shortest = @values.elems;
      @result   = ();
      say ":: New Solution: [{ @values.join(", ") }]" if $loquacious;
    }
    else
    {
      say ":: Added Solution: [{ @values.join(", ") }]" if $loquacious;
    }

    @result.push: @values;
  }
}
