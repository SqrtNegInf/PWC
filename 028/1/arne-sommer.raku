#!/usr/bin/env raku

die 'not ok - disabled: the module could not be installed';

#`{{
use Data::TextOrBinary;

sub MAIN ($file, :$test-bytes = 4096)
{
  if $file.IO.d
  {
    say "Directory.";
  }
  elsif $file.IO.e
  {
    say is-text($file.IO, :$test-bytes)
      ?? "Text file."
      !! "Binary file.";
  }
  else
  {
    say "File doesn't exist.";
  }
}
}}
