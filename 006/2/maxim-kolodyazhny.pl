#!/usr/bin/env perl

# not decimal

use v5.028.1;
use bigrat qw(bexp PI);

say bexp( PI * sqrt(163), 80 );
