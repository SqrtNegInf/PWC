#!/usr/bin/env raku
#
#
#       .raku
#
#
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ( $request = 30 ) ;

say ((1..*).grep({.base(2)
                  .comb
                  .sum
                  .is-prime}))[^$request];
