#!/usr/bin/env raku

unit sub MAIN(Int $n = 10);
say (2, 3, * × * + 1 ... *).head: $n
