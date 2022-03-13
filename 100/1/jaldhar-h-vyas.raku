#!/usr/bin/env raku

my ($h,$m,$a) = '17:50'.match(/^\s*(2<[0..4]>||1\d||0*\d)\:(<[0..5]>*\d)\s*(<[ap]>m)?\s*/,:i).list;

($h==0)??($h=12 and $a=q{am})!!($h==12)??($a=($a)??$a!!q{pm})!!($h>12)??($h-=12 and $a=q{pm})!!($a&&$a~~m:i/pm/)??($h+=12 and $a=q{})!!($a=q{});

printf qq{%02d:%02d %s\n},$h,$m,$a;
