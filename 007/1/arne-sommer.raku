#!/usr/bin/env raku

.say if $_ %% $_.comb.sum for 0 .. 50;
