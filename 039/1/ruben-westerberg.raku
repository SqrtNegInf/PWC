#!/usr/bin/env raku

my @times=DATA().map({ |(for (m:g/(\d**2)\:(\d**2)/) {$_[0]*60+$_[1]*1 });});
put sprintf "Lights on for %d minutes", @times.max-@times.min;


sub DATA () {
	my $d=q:to/END/,
1) Alex    IN: 09:10 OUT: 09:45
2) Arnold  IN: 09:15 OUT: 09:33
3) Bob     IN: 09:22 OUT: 09:55
4) Charlie IN: 09:25 OUT: 10:05
5) Steve   IN: 09:33 OUT: 10:01
6) Roger   IN: 09:44 OUT: 10:12
7) David   IN: 09:57 OUT: 10:23
8) Neil    IN: 10:01 OUT: 10:19
9) Chris   IN: 10:10 OUT: 11:00
END
	return $d.lines;
}
