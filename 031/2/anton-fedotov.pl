#!/usr/bin/env perl

use warnings;
use v5.10;

my $name = 'foo';
my $value = 'boo';
if (defined($value)) {$$name = $value}
else {$$name = 'I love Star Wars'}
say "Variable named $name have value: $$name";
