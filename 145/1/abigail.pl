#!/usr/bin/env perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# We want the dot product. Math::Matrix gives us the dotproduct.
#

#
# Run as: perl ch-1.pl < input-file
#

use Math::Matrix;
say Math::Matrix:: -> new ([split ' ' => '1 2 3']) -> dot_product
   (Math::Matrix:: -> new ([split ' ' => '4 5 6']));
#say Math::Matrix:: -> new ([split ' ' => scalar <>]) -> dot_product
#   (Math::Matrix:: -> new ([split ' ' => scalar <>]));
