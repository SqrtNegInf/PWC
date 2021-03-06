#!/usr/bin/env raku

sub thresh(@a,$idx) {
    min(@a.[0..^$idx].max,@a.[$idx^..*].max)
}

sub hist(@a) {
    (1..@a.max)
    .map( -> $val { @a.keys.map({
($val <= @a.[$_]) ?? ('#') !! ($val <= thresh(@a,$_)) ?? ('0') !! (' ') })
		  })
    .reverse
    .join("\n")
}

sub rain(@a) {
    @a.keys
    .map({ (@a.[$_]^..thresh(@a,$_)).elems })
}

my @ARGS = (2,1,4,1,2,5);

say hist(@ARGS.map(*.Int)),
"\n" ~ ('- ' x @ARGS) ~ "\n",
rain(@ARGS.map(*.Int)).sum;

# run as <script> <space-separated array entries>
# histogram displays "rain" as '0'
