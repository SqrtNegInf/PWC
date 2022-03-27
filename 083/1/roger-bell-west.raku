#!/usr/bin/env raku

use Test;

plan 3;

is(wl('The Weekly Challenge'),6,'example 1');
is(wl('The purpose of our lives is to be happy'),23,'example 2');
is(wl('Markmið lífs okkar er að vera hamingjusöm'),17,'example 3');

sub wl($so) {
  my $s=$so;
  $s ~~ s/^\S+\s+(.*?)\s+\S+$/$0/;
  $s ~~ s:g/\s+//;
  return $s.chars;
}
