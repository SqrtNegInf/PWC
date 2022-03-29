#!/usr/bin/env raku

my %c;
for 'input.txt'.IO.lines() {
  .chomp;
  my $s=$_;
  $s ~~ s :g /(\-\-|\'s)/ /;
  $s ~~ s :g /<[.\"\(\),]>+/ /;
  map {%c{$_}++}, grep /./, split ' ',$s;
}

my %f;
for sort keys %c -> $w {
  push %f{%c{$w}},$w;
}

for sort keys %f -> $n {
  say join(' ',$n,%f{$n});
  say '';
}
