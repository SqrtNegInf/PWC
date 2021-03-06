#!/usr/bin/env raku

srand 1;

use Test;

sub match-brackets(Str $t) {
    # can never match condition
    return False if $t.chars < 2;

    # loop counting +1 for open -1 for close.

    # zero sum is matching
    # positive sum is non matching
    # negative is always non matching (and quick exit)
    my $open=0;
    for ^$t.chars -> $i {
        $open++ if $t.substr($i,1) eq '(';
        $open-- if $t.substr($i,1) eq ')';
        return False if $open < 0;
    }
    return $open == 0 ?? True !! False ;
}

#multi MAIN("test") {
    is match-brackets("()")      ,True ,"test matching";
    is match-brackets(")(")      ,False,"test never matching";
    is match-brackets("()(")     ,False,"test odd open not matching";
    is match-brackets("())")     ,False,"test odd close not matching";
    is match-brackets("((())())"),True ,"test nested matching";
    is match-brackets("((())))") ,False,"test nested not matching";
    is match-brackets("(a(b(c)d)e(f)g)h"),True ,"test nested matching with alternate chars";
    done-testing;
#}

=finish
multi MAIN() {
    for ^20 -> $i {
        my Str $c;
        my $j=1+(^5).roll;
        $c~= ('(',')').pick for ^2*$j;
        say (match-brackets($c) ?? "    Matching: " !! "Not-Matching: ") ~ $c;
    }
}
