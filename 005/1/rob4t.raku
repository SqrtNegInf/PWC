#!/usr/bin/env raku

sub MAIN(Str $word = 'animal', Str $file where *.IO.r = 'words') {
    my $word_bag = $word.lc.comb.Bag;

    my @found_words = $file.IO.lines.grep: {
        # not the same word
        .lc ne $word.lc
        and
        # look for words AND phrases
        .lc.words.map({.comb}).flat.Bag eqv $word_bag
    };

    .say for @found_words;
}
