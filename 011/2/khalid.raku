#!/usr/bin/env raku

sub identity-matrix($n) {
    my @id;
    for flat ^$n X ^$n -> $i, $j {    #0 0 , 0 1 , 0 2 , 0 3 , 0 4 etc..
        @id[$i][$j] = ($i == $j).Int; #the matrix element takes value of '1' if (i=j)
        #because the Identity matrix has ones on the main diagonal and zeros elsewhere.
    }
    @id; 
}
say  "Rows : " ,identity-matrix(5).raku;
say "Formated Matrix : ";
.say for identity-matrix(5).map:  "\t\t|" ~ * ~ '|'
