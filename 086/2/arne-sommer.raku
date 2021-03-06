#!/usr/bin/env raku

subset LegalChar   where /^<[1..9_]>$/;
subset SudokuDigit where /^<[1..9]>$/;

unit sub MAIN ($sudoku where $sudoku.IO.f && $sudoku.IO.r = 'sample-sudoku.txt',
               :vv(:$very-verbose),
	       :v(:$verbose) = $very-verbose);

my @sudoku = $sudoku.IO.lines.map( *.words.grep(LegalChar) )>>.Array;

die "Must be 9 rows"    unless @sudoku.elems    == 9;
die "Must be 9 columns" unless @sudoku[0].elems == 9;
die "Must be 9 columns" unless [==] @(@sudoku)>>.elems;
die "0-9_ only"         unless all( @sudoku>>.List.flat ) ~~ LegalChar;

my $unknown = count-unknowns;

say ": Unknown values: $unknown" if $verbose;

sub count-unknowns
{
  @sudoku>>.List.flat.grep( { $_ eq "_" } ).elems;
}

sub get-row ($row, $col)
{
  return @sudoku[$row];
}

sub get-col ($row, $col)
{
  return (0..8).map({ @sudoku[$_][$col] });
}

sub get-box ($row, $col)
{
  my $row-actual = $row div 3 * 3;
  my $col-actual = $col div 3 * 3;
  
  return |@sudoku[$row-actual  ][$col-actual .. $col-actual+2],
         |@sudoku[$row-actual+1][$col-actual .. $col-actual+2],
	 |@sudoku[$row-actual+2][$col-actual .. $col-actual+2];
}

my $pass = 1;
my $unknown-prev = Inf;

{ say ":: { @$_ }" for @sudoku } if $very-verbose;

LOOP: loop
{
  if $unknown-prev == $unknown
  {
    say "Unsolvable Sudoku (by this program)";
    exit;
  }

  $unknown-prev = $unknown;
 
  say ": Pass: { $pass++ } with $unknown unknowns" if $verbose;

  for 0 .. 8 -> $row
  {
    for 0 .. 8 -> $col 
    {
      last LOOP if $unknown == 0;
      next unless @sudoku[$row][$col] eq "_";

      my @row = get-row($row, $col).grep(SudokuDigit);
      my @col = get-col($row, $col).grep(SudokuDigit);
      my @box = get-box($row, $col).grep(SudokuDigit);
      
      if $very-verbose
      {
        say ":: [$row,$col] Row: { @row.sort.join(", ") }"; 
        say ":: [$row,$col] Col: { @col.sort.join(", ") }";
        say ":: [$row,$col] Box: { @box.sort.join(", ") }";
      }
      
      my @all = ( @row (|) @col (|) @box ).keys>>.Int.sort.unique; 
      my @missing = ( (1..9) (-) @all>>.Int ).keys.sort;

      say ":: all: @all[]" if $very-verbose;
      say ": Pos[$row, $col] - missing: @missing[]" if $verbose;

      if @missing.elems == 1
      {
        $unknown--;
	say ":: [$row,$col] => @missing[0] (replacing unknown { $unknown })" if $very-verbose;
        @sudoku[$row][$col] = @missing[0];
        { say ":: { @$_ }" for @sudoku } if $very-verbose;
      }
    }
  }
}

say @$_ for @sudoku;
