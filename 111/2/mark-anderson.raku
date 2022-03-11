#!/usr/bin/env raku

# Using the reduction operator via the solutions from Feng Chang and
# Markus Holzer https://twitter.com/HrBollermann/status/1389169231644794880

# [Adelops alloquy beefily begorry billowy egilops]

say "words".IO.words

#.hyper(batch => 10_000, degree => $*KERNEL.cpu-cores)

.grep({ [le] .fc.comb }).classify({ .chars }).max.value;
