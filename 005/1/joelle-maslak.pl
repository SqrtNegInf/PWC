#!/usr/bin/env perl
use v5.26;
use strict;
use warnings;

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

use autodie;

# To call this application:
#
# perl ch-1.pl; <letters> <filename>
#
# If you want to use words as the word list, you can
# omit the filename.
#
# Example:
#
#   perl ch-1.pl binary
#
# which is equivilent to:
#
#   perl ch-1.pl binary words
#
# With my Unix dictionary (English), it returns binary and brainy
#
# Yes, this is a VERY tiny modification of Week 4 problem 2 but not
# quite as tiny as the modification is in the P6 version!
#

my $match = 'animal';
my %dedupe;

my $filename = $ARGV[1] // 'words';
open my $fh, '<', $filename;
while (my $word = <$fh>) {
    chomp($word);
    $word = fc($word);

    my $wordmatch = join '', sort split('', $word);

    if (fullmatch($match, $wordmatch)) {
        next if exists $dedupe{$word};
        $dedupe{$word} = 1;
        say $word;
    }
}
close $fh;

sub fullmatch($chars, $word) {
    $chars = join '', sort split '', $chars;
    $word  = join '', sort split '', $word;

    return ($chars eq $word);
}

