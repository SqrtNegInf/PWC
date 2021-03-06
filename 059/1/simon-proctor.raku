#!/usr/bin/env raku

#| Given an inflaction point and a list of values put all the items less than the inflection point
#| at the start of the last and all those great or equal after. Retain ordering.
sub MAIN (
    Int $inflection =3, #= Inflection point
    @rest where .all ~~ Int = (1, 4, 3, 2, 5, 2)
) {
    my %c = @rest.classify( * >= $inflection );
    ( |%c{False}, |%c{True} ).say;
}
