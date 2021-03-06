#!/usr/bin/env raku

sub max1flip(Str $s where * ~~ /^(0|1)*$/) {
    ((^$s.chars) X (^$s.chars)).grep({ $_[0] <= $_[1] }).classify({ $s.substr($_[0]..$_[1]).comb.grep(0).elems - $s.substr($_[0]..$_[1]).comb.grep(1).elems }).max(*.key).value
}

say '010'.&max1flip

# run as <script> <binary string> 
