#!/usr/bin/env raku

unit sub MAIN ($separator = "/", @paths is copy = </a/b/c/d /a/b/cd /a/b/cc /a/b/c/d/e>);

loop
{
  @paths = remove-last-part(@paths);

  unless @paths.elems
  {
    say "No common Directory Path.";
    last;
  }

  if all(@paths) eq @paths[0]
  {
    @paths[0] eq $separator
      ?? say "Common Directory Path: $separator"
      !! say "Common Directory Path: " ~ @paths[0].substr(0, @paths[0].chars - $separator.chars);
    last;
  }
}

sub remove-last-part(@paths)
{
  my @new;
  for @paths
  {
    return () unless /$separator/;
    /(.*$separator)/;
    push @new: $0.Str;
  }
  
  my $min = @new>>.chars.min;

  my @return; for @new { @return.push($_.substr(0, $min)); }
  return @return;
}
