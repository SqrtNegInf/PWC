#!/usr/bin/env raku

my @long-words;
my $max-length = 0;

for 'words'.IO.lines -> $word {
    next unless [le] $word.comb;
    my $length = $word.chars;
    if  $length > $max-length {
        @long-words = $word,;
        $max-length = $length;
    } elsif $length == $max-length {
        push @long-words, $word;
    }
}
say @long-words.join(", ");
