#!/usr/bin/env raku

sub number_of_1 (Int $in) {
    my $count = [+] $in.base(2).comb;
}

my $input = @*ARGS[0] // 12;
my $target = number_of_1 $input.Int;
for $input ^.. Inf -> $candidate {
    next unless $candidate.Int.&number_of_1 == $target;
    say $candidate;
    last;
}
