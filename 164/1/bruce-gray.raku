#!/usr/bin/env raku
put grep { $_ eq .flip and .is-prime }, ^1_000;
