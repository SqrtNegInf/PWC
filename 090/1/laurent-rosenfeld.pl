#!/usr/bin/env perl
use strict;
use warnings;
use feature "say";

my $dna = 'GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG';
# count
my %histogram;
$histogram{$_}++ for split '', $dna;
say "$_: $histogram{$_}" for sort keys %histogram;

# Complementary sequence
say for "Complement:", $dna =~ tr/TAGC/ATCG/r;
