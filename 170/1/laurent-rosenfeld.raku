#!/usr/bin/env raku
say [\*] (1..Inf).grep({.is-prime})[0..9];
