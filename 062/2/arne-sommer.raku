#!/usr/bin/env raku

#use lib "lib";
#use QueenCube;

constant ansi-blue  = "\e[44m";
constant ansi-green = "\e[42m";
constant ansi-red   = "\e[101m";
constant ansi-stop  = "\e[0m ";

constant html-blue  = '<span class="text-light bg-primary">';
constant html-green = '<span class="text-light bg-success">';
constant html-red   = '<span class="text-light bg-danger">';
constant html-stop  = '</span> ';


class QueenCube {


has Int $.size;
has @.elems is rw;
has $.blank is rw;


method init ($init)
{
  self.blank = $init;

  for 1 .. $!size -> $x
  {
    for 1 .. $!size -> $y
    {
      for 1 .. $!size -> $z
      {
        @.elems[$x; $y; $z] = $init;
      }
    }
  }
}


multi method queen ($id, $x, $y, $z)
{
  die "Blacked out position $x, $y, $z " if @.elems[$x; $y; $z] ne self.blank;
    
  @.elems[$x; $y; $z] = $id;

  my $min      = 1;
  my $max      = self.size;
  my $blackout = $id.lc;
    
  for -1, 0, 1 -> $xx
  {
    for -1, 0, 1 -> $yy
    {
      for -1, 0, 1 -> $zz
      {
        next if $xx == $yy == $zz == 0; # The Queen is here
	
        for (1 .. $max) -> $h
	{
          my $xxx = $x + $xx * $h;
          my $yyy = $y + $yy * $h;
          my $zzz = $z + $zz * $h;
	  next if any($xxx, $yyy, $zzz) < $min;
          next if any($xxx, $yyy, $zzz) > $max;
          @.elems[    $xxx; $yyy; $zzz] = $blackout;
        }
      }
    }
  }
}


multi method queen ($id, $xyz)
{
  my ($x, $y, $z) = $xyz.split(";");
    
  die "Queen position out of range (1 .. { self.size })" if any($x, $y, $z) < 1;
  die "Queen position out of range (1 .. { self.size })" if any($x, $y, $z) > self.size;

  self.queen($id, $x, $y, $z);
}


method display ($colour, $layer-from = 1, $layer-to = self.size)
{
  for 1 .. self.size -> $y
  {
    for $layer-from .. $layer-to -> $x
    {
      for 1 .. self.size -> $z
      {
        if $colour && $colour eq "html"
        {
          given @.elems[$x; $y; $z]
          {
            when self.blank { print html-red   ~ $_ ~ html-stop; }
            when /<[A..Z]>/ { print html-blue  ~ $_ ~ html-stop; }
            when /<[a..z]>/ { print html-green ~ $_ ~ html-stop; }
	  }
	}
        elsif $colour
	{
          given @.elems[$x; $y; $z]
   	  {
	     when self.blank { print ansi-red   ~ $_ ~ ansi-stop; }
	     when /<[A..Z]>/ { print ansi-blue  ~ $_ ~ ansi-stop; }
	     when /<[a..z]>/ { print ansi-green ~ $_ ~ ansi-stop; }
	  }
        }
	else
	{
          print @.elems[$x; $y; $z], " ";
        }
      }
      print "   ";
    }
    say "":
  }
}


method display-with-newlines($colour, $break-after)
{
  my $size  = self.size;
  my $start = 1;
  my $stop  = min($size, $break-after);

  loop
  {
    self.display($colour, $start, $stop);
    $start += $break-after;
    $stop  += $break-after;

    last if $start > $size;
    $stop = min($stop, $size);
    print "\n\n";
  }
}


method number-of-queens
{
  return @!elems[*;*;*].grep({ $_.defined }).grep( * ~~ /<[A..Z]>/ ).elems;
}


method get-empty-cell
{
  for 1 .. self.size -> $x
  {
    for 1 .. self.size -> $y
    {
      for 1 ..self.size -> $z
      { 
        return "$x;$y;$z" if @.elems[$x;$y;$z] eq self.blank;
      }
    }
  }
  return;
}


method get-empty-cell-random
{
  for self.get-all-cells.flat.pick(*) -> $elem
  {
    my ($x, $y, $z) = $elem.split(";");
    return "$x;$y;$z" if @.elems[$x;$y;$z] eq self.blank;
  }
  return;
}


method get-all-cells
{
  my @all;
  for 1 .. self.size -> $x
  {
    for 1 .. self.size -> $y
    {
      for 1 ..self.size -> $z
      {
        @all.push("$x;$y;$z");
      }
    }
  }
  return @all;
}


method cell-is-free ($cell)
{
  my ($x, $y, $z) = $cell.split(";");
  return self.elems[$x;$y;$z] eq self.blank;
}

}

sub MAIN
(
  $size     = 8,
  :$id       = 'Q',
  :$empty    =".",
  :$queen,
  :$colour,
  :$newlines,
  :$fill = True,
  :$random,
  :$silent,
  :$get-the-best,
  :$verbose
) {

if $get-the-best
{
  get-the-best;
}
elsif $silent ~~ Int
{
  get-many-solutions;
}
else
{
  get-one-solution;
}

sub get-one-solution
{
  my $c = QueenCube.new(size => $size);

  $c.init($empty);

  if $queen
  {
    $c.queen($id, $_) for $queen.words;
  }

  if $fill || $random
  {
    loop
    {
      my $pos = $random ?? $c.get-empty-cell-random !! $c.get-empty-cell;
      last unless defined $pos;
      say ": Queen at $pos" if $verbose;
      my ($x, $y, $z) = $pos.split(";");
      $c.queen($id, $x, $y, $z);
    }
  }

  unless $silent
  {
    $newlines
      ?? $c.display-with-newlines($colour, $newlines)
      !! $c.display($colour);
  }

  my $count = $c.number-of-queens;
  say "Number of Queens: ", $count if $count > 1;

  return $count;
}


sub get-many-solutions
{
  my @result;

  @result.push(get-one-solution) for ^$silent;

  my %result;

  %result{$_}++ for @result;

  say "$_ (%result{$_})" for %result.keys.sort;
}


sub get-the-best
{
  my Int $best-count = 0;
  my $best-cube;
  
  my $c = QueenCube.new(size => $size);
  $c.init($empty);

  iterate($c);

  sub iterate ($cube)
  {
    for $cube.get-all-cells -> $cell
    {
      next unless $c.cell-is-free($cell);

      my $copy = $cube.clone;
      $copy.queen($id, $cell);

      iterate($copy);
    }
    
    my $q = $cube.number-of-queens;
    if $q > $best-count
    {
      say ": New best cube with $q Queens (old had $best-count)" if $verbose;
      $best-count = $q;
      $best-cube  = $cube
    }
    elsif $verbose
    {
      say ": Considering cube with $q Queens";
    }
  }
  
  $newlines
      ?? $c.display-with-newlines($colour, $newlines)
      !! $c.display($colour);

  say "Number of Queens: ", $best-count;
}

}
