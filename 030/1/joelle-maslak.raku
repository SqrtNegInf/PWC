#!/usr/bin/env raku

sub MAIN(:$start = 2019, :$end = 2100) {
    my $christmasses = ($start..$end).map({ DateTime.new(:25day, :12month, :year($_)) });

    my $on-sunday = $christmasses.grep: *.day-of-week == 7;

    say $on-sunday».yyyy-mm-dd.join("\n");
}

