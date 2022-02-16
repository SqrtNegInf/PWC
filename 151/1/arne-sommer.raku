#!/usr/bin/env raku

unit sub MAIN (Str $tree = "1 | 2 3 | 4 *  * 5 | * 6", :v(:$verbose));

class BinaryNode
{
  has Int        $.value;
  has BinaryNode $.left;
  has BinaryNode $.right;
}

my @btree = $tree.split("|")>>.words;

my @old-nodes;
my @new-nodes;

for @btree.reverse -> $row
{
  my @current = @$row;
  @old-nodes  = @new-nodes;
  @new-nodes  = ();
  
  for @current -> $value
  {
    if $value eq "*"
    {
      @new-nodes.push("*");
      next;
    }

    my $left  = @old-nodes.shift // "*"; $left  = Nil if $left  eq "*";
    my $right = @old-nodes.shift // "*"; $right = Nil if $right eq "*";

    @new-nodes.push(BinaryNode.new(value  => $value.Int,
                                   left   => $left  // Nil,
                                   right  => $right // Nil)); 
  }
}

my $btree = @new-nodes[0];

my @paths;

traverse2($btree, ());

sub traverse2 ($current, @path is copy)
{
  @path.push: $current.value;
  
  if ($current.left or $current.right)
  {
    traverse2($current.left,  @path) if $current.left;
    traverse2($current.right, @path) if $current.right;
  }
  else
  {
    say ": Path: [{ @path.join(", ") }] with length { @path.elems }"  if $verbose;
    @paths.push: @path;

    return;
  }
}

say @paths>>.elems.min;

