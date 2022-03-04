#!/usr/bin/env raku

unit sub MAIN (Str $matrix = "1 0 0 0 1 0 | 1 1 0 0 0 1 | 1 0 0 0 0 0", :v(:$verbose)); 

my @m = $matrix.split("|")>>.words>>.Numeric; ## .List;

die "Illegal characters" unless all($matrix.words) eq any(0,1,'|');

die "No zeros" unless any($matrix.words) eq '0';
die "Uneven row length" unless all(@m>>.elems) == @m[0].elems && @m[0].elems > 0;

my $number-of-rows = @m.elems;     my $last-row = $number-of-rows -1;
my $number-of-cols = @m[0].elems;  my $last-col = $number-of-cols -1;

say ": Rows: $number-of-rows, cols: $number-of-cols" if $verbose;

my $largest-size = 0;
my $largest-rows = 0;
my $largest-cols = 0;

for 0 .. $last-col -> $from-col
{
  for $last-col ... $from-col -> $to-col
  {
    for 0 .. $last-row -> $from-row
    {
      for $last-row ... $from-row -> $to-row
      {
        my $size = ($to-row - $from-row +1) * ($to-col - $from-col +1); 
        next if $size <= $largest-size;

	my @rect = get-rectangle(@m, $from-row, $from-col, $to-row, $to-col);
	my $zero = zero-rectangle(@rect);
	
        say ": Checking rectangle [UL: $from-row, $from-col][LR: $to-row, $to-col]: ",
	  "{ @rect.raku }  ---> $zero" if $verbose;

        if $zero
	{
	  my $rows = 1 + $to-row - $from-row;
	  my $cols = 1 + $to-col - $from-col;
          my $size = $rows * $cols ;

          if $size > $largest-size
	  {
	    say ": - Largest so far $size ($rows x $cols)" if $verbose;
            $largest-size = $size;
            $largest-rows = $rows;
            $largest-cols = $cols;
          }
        }
      }
    }
  }
}

if $largest-size
{
  say ": Largest with size $largest-size ($largest-rows x $largest-cols)" if $verbose;
  say "[ { '0' xx $largest-cols } ]" for ^$largest-rows;
}
else
{
  say "[]";
}

sub get-rectangle(@matrix, $x1, $y1, $x2, $y2)
{
  return (($x1 .. $x2).map({ @m[$_][$y1 .. $y2] }));
}

sub zero-rectangle (@matrix)
{
  return so all(@matrix.List.flat) eq "0";
}
