#!/usr/bin/env raku

sub MAIN (Int $count where $count > 0 = 3)
{
  my $numbers := gather
  {
    for 2..Inf
    {
      # say ":: $_ ::";
      take $_ if is-perfect($_);
    }
  }

  say "The first $count perfect numbers: " ~ $numbers[0 .. $count -1].join(', ') ~ ".";
  
}

multi proper-divisors (2) { return (1); }

multi proper-divisors (Int $number where $number > 2)
{
  return (1) if $number.is-prime;
  
  my @divisors = (1);
  for 2 .. ($number -1) -> $candidate
  {
    @divisors.push: $candidate if $number %% $candidate;
  }
  return @divisors;
}

sub is-perfect ($number)
{
  return $number == proper-divisors($number).sum;
}
