#!/usr/bin/env raku

my $string= '1,2,3,4,9,10,14,15,16';
my $a=$string.split(",",:skip-empty)>>.trim.grep({!/^$/})>>.Int.Bag;
my @r1=$a.keys.sort;
my @diff=@r1.rotate >>-<< @r1;
my @p=(0,|map {|($^k,$k+1) if abs($^v) > 1}, @diff.kv);

@p.pop;
say join ",", map {@r1[$^a]==@r1[$^b]??@r1[$^a]!!"@r1[$^a]-@r1[$^b]"}, @p;


