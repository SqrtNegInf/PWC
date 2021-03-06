#!/usr/bin/env raku

unit sub MAIN (@list where @list.elems >= 4 && all(@list) ~~ Numeric = [ 2, 5, -1, 3 ],
               :$verbose);

my $maximum = 0;
my @max_array;

for 0 .. @list.end - 1 -> $left
{
  for $left + 1 .. @list.end -> $right
  {
    my @current = @list[$left .. $right];
    my $product = [*] @current;
    
    say ": (L:$left R:$right) -> @current[] ---> $product" if $verbose;

    if $product == $maximum
    {
      @max_array.push: @current;
    }
    elsif $product > $maximum
    {
      $maximum   = $product;
      @max_array = @current,;
    }
  }
}

say @max_array;
