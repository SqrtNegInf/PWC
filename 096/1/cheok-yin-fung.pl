#!/usr/bin/env perl
# The Weekly Challenge 096
# Usage:
# $ perl ch-1.pl "the weekly challenge"
# challenge weekly the
# fixed after review (22th Feb 2021)


$_ = 'The Weekly Challenge';
s/\s+/ /g ; 
s/^\s+//g;
s/\s+$//g;
@a = reverse split / /, $_; 
print "'";
print join " ", @a;
print "'" ;
print "\n";
