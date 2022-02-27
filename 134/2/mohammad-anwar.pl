#!/usr/bin/env perl

use strict;
use warnings;

=head1

Week 134:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-134

Task #2: Distinct Terms Count

    You are given 2 positive numbers, $m and $n.

    Write a script to generate multiplcation table and display count
    of distinct terms.

=cut

my ($table, $distinct_terms, $count_terms) = create_table( (5, 5) );

print sprintf("%s\n\n", join("\n", @$table));
print sprintf("Distinct Terms: %s\n", join(", ", @$distinct_terms));
print sprintf("Count: %d\n", $count_terms);

sub create_table {
    my ($m, $n) = @_;

    die "ERROR: Missing 'm'\n." unless defined $m;
    die "ERROR: Missing 'n'\n." unless defined $n;

    die "ERROR: Invalid $m\n."  if ($m <= 0);
    die "ERROR: Invalid $n\n."  if ($n <= 0);

    my $table  = [];
    my $length = length($m * $n) + 1;

    my $col = 'x | 1';
    $col .= sprintf("%${length}d", $_) for (2 .. $n);
    push @$table, $col;

    my $line = '--+';
    $line .= '-' for (4 .. length($col));
    push @$table, $line;

    my %terms = ();
    $terms{$_} = 1 for (1 .. $m);

    foreach my $i (1 .. $m) {
        my $row = "$i | $i";
        foreach my $j (2 .. $n) {
            my $k = $i * $j;
            $terms{$k} = 1;
            $row .= sprintf("%${length}d", $k);
        }
        push @$table, $row;
    }

    my $distinct_terms = [ sort { $a <=> $b } keys %terms ];
    my $count_terms    = @$distinct_terms;

    return ($table, $distinct_terms, $count_terms);
}
