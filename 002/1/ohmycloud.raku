#!/usr/bin/env raku
for <00040 03.5 00.002 .02 .3 0.03> -> $n {
    say ($n ~~ /^ 0* %% <?> /).postmatch;
}
