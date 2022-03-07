#!/usr/bin/env raku

multi MAIN (Int $N, :v(:$verbose))
{
  my $matrix = (^$N).map({ (^$N).pick(*).join(" ") }).join(" | ");

  say ": Matrix: $matrix";

  MAIN($matrix, :$verbose);
}

multi MAIN (Str $matrix = "0 5 2 7 | 5 0 5 3 | 3  1  0  6 | 4  5  4  0", :v(:$verbose))
{
  my @NN = $matrix.split("|")>>.words>>.list;

  my $size = @NN.elems;

  die "All the rows and coluns must have the same length" unless all(@NN>>.elems) == $size;

  if $verbose
  {
    for ^$size -> $from
    {
      for ^$size -> $to
      {
        next if $from == $to;
        say ": Distance from city #$from to #$to: @NN[$from][$to]";
      }
    }
  }

  say "" if $verbose;

  my %solutions;
  my %seen;

PERM:
  for (^$size).permutations -> @path is copy
  {
    my $candidate = @path.join(" ");

    my @p = @path.clone;

    for ^$size
    {
      @p.push: @p.shift;
      
      next PERM if %seen{ @p.join(" ") };
    }

    %seen{$candidate} = True;
    
    @path.push: @path[0];
    my @path2 = @path.clone;

    my $from   = @path.shift;
    my $length = 0;
  
    while @path
    {
      my $to = @path.shift;
      $length += @NN[$from][$to];
      say ": { @path2.join(" ") } | $from -> $to = @NN[$from][$to] (sum $length)" if $verbose;
      $from = $to;
    }
    say "" if $verbose;
  
    %solutions{$length}.push: @path2;
  }

  if $verbose
  {
    for %solutions.keys.sort -> $length
    {
      for @(%solutions{$length}) -> @path
      {
        say ": $length - [ { @path.join(" ") } ]";
      }
    }
  }

  my $length = %solutions.keys.sort.first;

  say "length = $length";
  say "tour = ({ %solutions{$length}[0].join(" ") })";
}
