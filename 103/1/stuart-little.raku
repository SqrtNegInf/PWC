#!/usr/bin/env raku

sub animal(@animals,$year,$base) {
    @animals[($year - $base) % @animals.elems]
}

sub elt(@elts,$year,$base) {
    @elts[(($year - $base) % (2*@elts.elems)) div 2]
}

my @animals=<Rat Ox Tiger Rabbit Dragon Snake Horse Goat Monkey Rooster Dog Pig>;
my @elts=<Wood Fire Earth Metal Water>;
my $year=2022;

say qq|{elt(@elts,$year,1924)} {animal(@animals,$year,1924)}|;
