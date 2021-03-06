#!/usr/bin/env raku

#subset BinaryDigit where /^<[01]>$/;

#unit sub MAIN ($rectangle where $rectangle.IO.f && $rectangle.IO.r = 'sample1.txt',
my ($verbose,$show,$html) = 0,0,0;

#my @rectangle = $rectangle.IO.lines.map( *.words.grep(BinaryDigit) )>>.Array;

my @rectangle  = 
        < 0 0 0 1 0 0 >,
        < 1 1 1 0 0 0 >,
        < 0 0 1 0 0 1 >,
        < 1 1 1 1 1 0 >,
        < 1 1 1 1 1 0 >;

my $rows = @rectangle.elems;
my $cols = @rectangle[0].elems;

die "All rows must have the same length" unless [==] @(@rectangle)>>.elems;

my $col-blue  = "\e[44m";
my $col-green = "\e[42m";
my $col-red   = "\e[101m";
my $col-stop  = "\e[0m";

if ($html)
{
  $col-blue  = '<span class="text-light bg-primary">';
  $col-green = '<span class="text-light bg-success">';
  $col-red   = '<span class="text-light bg-danger">';
  $col-stop  = '</span>';
}

my @partials;

class partial
{
  has $.start-row;
  has $.start-col;
  has $.stop-row;
  has $.stop-col;

  method size
  {
    return (self.stop-row - self.start-row + 1) * (self.stop-col - self.start-col + 1);
  }

  method all-one
  {
    for self.start-row .. self.stop-row -> $row
    {
      for self.start-col .. self.stop-col -> $col
      {
        return False if @rectangle[$row][$col] == 0;
      }
    }
    return True;
  }

  method debug-output
  {
    return ": [{ self.start-row },{ self.start-col } -> { self.stop-row },{ self.stop-col }] -> { self.size } -> { self.all-one }";
  }

  method show
  {
    for self.start-row .. self.stop-row -> $row
    {
      print "[ ";
      for self.start-col .. self.stop-col -> $col
      {
        print @rectangle[$row][$col] ~ " ";
      }
      say "]";
    }
  }
}

for 0 .. $rows -1 -> $start-row
{
  for 0 .. $cols -1 -> $start-col 
  {
    if @rectangle[$start-row][$start-col] == 0
    {
      say ": [$start-row,$start-col] skipped (is 0)" if $verbose;
      next;
    }

    for $start-row +1 .. $rows -1 -> $stop-row
    {
      for $start-col +1 .. $cols -1 -> $stop-col
      {
        my $partial = partial.new(:$start-row, :$stop-row, :$start-col, :$stop-col);
	$partial.debug-output.say if $verbose; 
	@partials.push: $partial if $partial.all-one;
      }
    }
  }
}

say "" if $verbose;

my @sorted = @partials.sort({ $^b.size <=> $^a.size });

if @sorted
{
  @sorted>>.debug-output>>.say if $verbose; 

  my $candidate = @sorted[0];
  
  coloured-matrix($candidate.start-row, $candidate.start-col, $candidate.stop-row, $candidate.stop-col) if $show;
  say "" if $verbose || $show;
  $candidate.show;
  exit;
}

sub coloured-matrix ($start-row, $start-col, $stop-row, $stop-col)
{
  for ^$rows -> $row
  {
    print "[ ";
    for ^$cols -> $col
    {
      print $start-row <= $row <= $stop-row && $start-col <= $col <= $stop-col
       ?? ( $col-green ~ @rectangle[$row][$col] ~ $col-stop ~ " " )
       !! ( @rectangle[$row][$col] ~ " " );

    }
    say "]";
  }
}

say 0;
