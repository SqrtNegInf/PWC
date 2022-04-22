#!/usr/bin/env perl

use strict;
use warnings;

# Because this is *literally* the point of this code
no strict 'refs';


my $varname = 'foo';

# Set that variable
$$varname = 'boo';

# Print the variable
print "The variable is called $varname and it has the value $$varname\n";
