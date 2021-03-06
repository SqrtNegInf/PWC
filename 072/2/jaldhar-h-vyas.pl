#!/usr/bin/env perl
use 5.020;
use warnings;
use English qw/ -no_match_vars /;

sub usage {
    print<<"-USAGE-";
Usage:
  $PROGRAM_NAME <A> <B> <file>
  
    <A>       start line
    <B>       end line
    <file>    file name
-USAGE-
    exit 0;
}

my ($A, $B, $file) = (3, 6, 'input.txt');
my $linenumber = 0;

open my $fn, '<', $file or die "$OS_ERROR\n";
while (my $line = <$fn>) {
    $linenumber++;
    if ($linenumber > $B) {
        last;
    }
    if ($linenumber < $A) {
        next;
    }
    print $line;

}
close $fn;
