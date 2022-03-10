#!/usr/bin/env raku

#unit sub MAIN (*@S where @S.elems > 0);

my @S = (4, 1, 7, 6);

my %elems;
my $id = 0;

for @S -> $elem
{
  %elems{++$id} = $elem;
  say "$id: $elem";
}

for 1 .. $id -> $first
{
  for 1 .. $id -> $second
  {
    next if $second eq $first;

    if %elems{$second}.substr(*-1,1) eq %elems{$first}.substr(0,1)
    {
      say "$second>$first {%elems{$first}.substr(0,1)}";
    }
  }
}
