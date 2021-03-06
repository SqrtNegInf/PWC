#!/usr/bin/env raku

sub MAIN (Str $string1 = 'zabc' , Str $string2  = 'xabcy' ) {

    my @string1     = $string1.comb;
    my @string2     = $string2.comb;
    my ($l1, $l2)   = (@string1.elems, @string2.elems);
    my ($x,$z)      = (0,0);                                # $x is lcs-index into @string1, $z is length of lcs

    for 0..$l1-1 -> $i {
        for 0..$l2-1 -> $j {
            my $k=0; 
            $k++ while ($i+$k < $l1) && ($j+$k < $l2) && (@string1[$i+$k] eq @string2[$j+$k]);
            if $k > $z { ($x, $z) = ($i, $k) };
        }
    }
    say "LCS  = { $string1.substr($x, $z) }";
}
