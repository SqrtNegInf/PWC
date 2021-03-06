#!/usr/bin/env perl

use strict;
no strict 'refs';
use warnings;
use feature 'say';

sub _inc_filename {
    my $name = shift;
    return join( '/', split /(?:\'|::)/, $name ) . '.pm';
}

sub main {
    use lib '.';
    my $package = shift // 'Calc';

    # Import the package
    my $filename = _inc_filename($package);
    require $filename;

    # Get a list of methods
    say foreach grep { defined &{"${package}::$_"} } sort keys %{"${package}::"};
}

main(@ARGV);
