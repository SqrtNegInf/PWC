#!/usr/bin/env raku

say "Perl Weekly Challenge".subst("e","E", :g);
say "Perl Weekly Challenge".comb("e").elems;
