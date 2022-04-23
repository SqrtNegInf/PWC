#!/usr/bin/env perl

use strict;
use warnings;

use FFI::Raw;

my $cpf=FFI::Raw->new('libc.dylib','printf',
                      FFI::Raw::int,
                      FFI::Raw::str,
                      FFI::Raw::str,
                        );

$cpf->call("%s\n",'a string passed from perl5');
