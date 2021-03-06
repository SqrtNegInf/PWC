#!/usr/bin/env raku

multi sub MAIN (
    Str $numberlist where /^ [ \d+ \,? ]+ $/ = '1,2,3,4,9,10,14,15,16'
) {
    my @numbers = $numberlist.split(',').sort({ $^a <=> $^b });
    my $lastelem = @numbers.elems - 1;
    my @ranges;
    my $start;
    my $current = 0;

    while ($current <= $lastelem) {
        $start = $current;

        while ($current < $lastelem &&
        @numbers[$current] + 1 == @numbers[$current + 1]) {
            $current++;
        }

        @ranges.push(do given (@numbers[$start], @numbers[$current]) {
            when $_[1] == $_[0]     { $_[0]; }
            when $_[1] == $_[0] + 1 { ($_[0], $_[1]); }
            default                 { "$_[0]-$_[1]"; }
        });

        $current++;
    }

    @ranges.join(',').say;
}
