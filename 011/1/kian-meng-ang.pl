#!/usr/bin/env perl
# vi:et:sw=4 ts=4 ft=perl
#!/usr/bin/env perl

use v5.10;
use strict;
use warnings;
use utf8;

say grep { $_ == ($_ * 9 / 5) + 32 } (-100 .. 100);
