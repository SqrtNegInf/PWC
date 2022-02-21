#!/usr/bin/env raku

#unit sub MAIN (Int $n where $n > 0);

my $lychrel := (10 .. *).grep({ is-lychrel($_) });

say $lychrel[^20].join(", ");

sub is-lychrel ($current is copy)
{
  my $i = 0;
  
  loop
  {
    $current = $current + $current.flip;

    return False if $current == $current.flip;

    return True if $i++ == 500 || $current >= 10_000_000;
  } 
}
