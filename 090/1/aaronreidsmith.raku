#!/usr/bin/env raku

subset ValidDna of Str where { $_ ~~ /^^[A|T|G|C]+$$/ }

# Since DNA is generally read from 5' to 3', I included the option to find the
# reverse compliment in addition to the complement
sub MAIN($dna where $dna ~~ ValidDna = 'GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG', Bool :rc(:$reverse-complement) = True) {
    say "Input stats:\n{$dna.comb.Bag.Hash}\n";

    say "Complement:";
    my $translated = $dna.trans('ATGC' => 'TACG');
    if $reverse-complement {
        say "5'-{$translated.flip}-3'";
    } else {
        say "3'-$translated-5'"
    }
}
