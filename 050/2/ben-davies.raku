#!/usr/bin/env raku

unit sub MAIN() {
    # Two or more Noble Integers can exist in a list if they're equal 😉:
    # my Int:D @L = (2, 2, 6, 1, 3);
    my Int:D @L = 19,11,9,7,20,3,17,16,2,14,1;
    # Grep for all integers in @L where the list of integers in @L greater than
    # said integer is equal in length to said integer:
    say '<== ', @L;
    say '==> ', @L.grep({ @L.grep(* > $_) == $_ });
}
