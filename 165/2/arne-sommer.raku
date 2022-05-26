#!/usr/bin/env raku
# dup of ch#1 code

#unit sub MAIN ($file where $file.IO.f && $file.IO.r, :l(:$lsm));
my $file = 'example2.txt';
my $lsm = True;

my @lines;
my @points;
my $height = 0;
my $width  = 0;

for $file.IO.lines.words -> $element
{
  my (@elems) = $element.split(",");

  if (@elems.elems == 4)
  {
    @lines.push: @elems;

    $height = max($height, @elems[1], @elems[3].Numeric); 
    $width  = max($width,  @elems[0], @elems[2].Numeric);
  }
  elsif (@elems.elems == 2)
  {
    @points.push: @elems;

    $height = max($height, @elems[1].Numeric);
    $width  = max($width,  @elems[0].Numeric);
  }
  else
  {
    die "Wrong number of values; use 2 or 4 only";
  }
}

if $lsm
{
  die "'Line of Best Fit' cannot be used with a dataset with lines" if @lines.elems;

  my $x  = 0;
  my $y  = 0;
  my $xx = 0;
  my $xy = 0;

  my $N = @points.elems;

  my $min-x = Inf;
  my $max-x = 0;

  for @points -> @point
  {
    my ($X, $Y) = @point;

    $min-x = min($min-x, $X.Numeric);
    $max-x = max($max-x, $X.Numeric);

    $x  += $X;
    $y  += $Y;
    $xx += $X ** 2;
    $xy += $X * $Y;
  }

  my $m = ($N * $xy - $x * $y) / ($N * $xx - $x ** 2);
  my $b = ($y - $m * $x) / $N;

  @lines.push(($min-x, ($m * $min-x) + $b, $max-x, ($m * $max-x) + $b));
}

say '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">
<svg height="' ~ $height +3 ~ '" width="' ~ $width +3 ~'" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">';

if @points
{
  say '<g fill="#f73" id="points">';
  
  for @points -> @point
  {
    say ' <circle cx="' ~ @point[0] ~ '" cy="' ~ @point[1] ~ '" r="3" />';
  }

  say '</g>';
}

if @lines
{
  say '<g id="lines" stroke="#369" stroke-width="4">';

  for @lines -> @line
  {
    say ' <line x1="' ~ @line[0] ~ '" x2="' ~ @line[2] ~ '" y1="' ~ @line[1] ~ '" y2="' ~ @line[3] ~ '" />'
  }
  
  say '</g>';
}

say '</svg>';
