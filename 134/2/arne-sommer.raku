#!/usr/bin/env raku

unit sub MAIN (Int $m where $m > 0 = 5, Int $n where $n > 0 = 5, :v($verbose));

my $width   = ($m * $n).chars;
my $r-width = ($m).chars;

say ":Max width number: $width"   if $verbose;
say ":Max width row ID: $r-width" if $verbose;

say "x".fmt("%{$width-1}s"), " |", (1..$n).map({ $_.fmt("%{$width}d") }).join(" ");

say "-" x $r-width, "-+", "-" x ($n * ($width +1) -1);

for 1 .. $m -> $row
{
  say "{ $row.fmt("%{$r-width}d") } |", (1..$n).map({ ($row * $_).fmt("%{$width}d") }).join(" ");
}

my @values;

for 1 .. $m -> $row
{
  for 1 .. $n -> $col
  {
    @values.push: $row * $col;
  }
}

my @distinct = @values.sort.squish;

say "";
say "Distinct Terms: { @distinct.join(", ") }";
say "Count: { @distinct.elems }";
