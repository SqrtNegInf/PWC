#!/usr/bin/env raku

my @tests = " 0044 1148820341 42 ", "  +44 1148820342 abc",
            " 44-11-4882-0343 ", " (44) 1148820344  ", " 00 1148820345";

my $ten-dgts = rx/\d ** 10/;
for @tests -> $str {
    say ~$0 if $str ~~ / ( [ \d ** 4 || '+' \d\d || \( \d\d \) ] \s+ <$ten-dgts> ) /;
}
