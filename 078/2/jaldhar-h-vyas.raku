#!/usr/bin/env raku

my @A = (10,20,30,40,50); my @B = (3,4);
@B.map({ @A.rotate($_).say; });
