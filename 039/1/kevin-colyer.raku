#!/usr/bin/env raku

use Test;

# this seems obvious - 9.10-11:00 there was continuous presence in the house...
# but here's a script anyway

my $housemates=q:to/timings/;
Alex    IN: 09:10 OUT: 09:45
Arnold  IN: 09:15 OUT: 09:33
Bob     IN: 09:22 OUT: 09:55
Charlie IN: 09:25 OUT: 10:05
Steve   IN: 09:33 OUT: 10:01
Roger   IN: 09:44 OUT: 10:12
David   IN: 09:57 OUT: 10:23
Neil    IN: 10:01 OUT: 10:19
Chris   IN: 10:10 OUT: 11:00
timings

# make set of all entry and exit times and  populate with the interval minutes
# need SetHash because I want to add members one at a time - otherwise a Set is immutable
my %minutes is SetHash;

for $housemates.lines -> $l {
        # parse list to get times
        $l ~~ / (\d\d) \: (\d\d) .+ (\d\d) \: (\d\d) /;
        my ($ih,$im,$oh,$om) = |$/;

        # add the time range to the set
        %minutes{$_}++ for ($ih*60+$im)..($oh*60+$om-1);
}
# count the elements
say %minutes.elems ~ " minutes the lights were on";

