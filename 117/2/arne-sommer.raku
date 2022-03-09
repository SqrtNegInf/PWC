#!/usr/bin/env raku

unit sub MAIN (Int $N where $N >= 1 = 3, :v(:$verbose));

my @result;
my @todo = ( [0, 0,"", $N], );

while @todo
{
  my $current = @todo.shift;
  my ($row, $col, $path, $size) = @($current);

  if $row == $col == $size
  {
    @result.push($path);
  }
  else
  {
    @todo.push( [$row,    $col +1, $path ~ "H", $size] ) if $col < $row;
    @todo.push( [$row +1, $col +1, $path ~ "R", $size] ) if $col < $size;
    @todo.push( [$row +1, $col,    $path ~ "L", $size] ) if $row < $size;
  }
}

say @result.join(", ");

say ": Number of paths: { @result.elems }" if $verbose;
