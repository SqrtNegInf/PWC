#!/usr/bin/env raku

unit sub MAIN (Str :$sort where $sort eq any("", "values", "labels") = "labels");

my $data = { apple => 3, cherry => 2, banana => 1 };

generate_bar_graph($data, $sort);

sub generate_bar_graph ($data, $sort)
{
  my $max = %($data).keys>>.chars.max;

  my @keys = %($data).keys;

  if $sort eq "values"
  {
    @keys = @keys.sort({ %($data){$^b} cmp %($data){$^a} });
  }
  elsif $sort eq "labels"
  {
    @keys = @keys.sort;
  }

  for  @keys -> $label
  {
    say "{ " " x ($max - $label.chars) }$label | { "#" x 4 * %($data){$label} }"; 
  }
}
