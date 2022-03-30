#!/usr/bin/env raku

subset PositiveInt of Int where * > 0;

#sub MAIN(*@N where @N.elems > 1 && all(@N) ~~ PositiveInt) {
my @N = (1, 4, 3, 2);
    say "Total candies: " ~ count-candies(@N);
#}

#
#
# SUBROUTINE

sub count-candies(@rankings
                  where @rankings.elems > 1 &&
                  all(@rankings) ~~ PositiveInt --> Int) {

    my @l2r = Empty;
    my @r2l = Empty;

    @l2r.push: 1 for @rankings;
    @r2l.push: 1 for @rankings;

    my Int $i = 1;
    while $i < @rankings.elems {
        @l2r[$i] = @l2r[$i - 1] + 1
               if @rankings[$i] > @rankings[$i - 1];
        $i++;
    }

    my Int $j = @rankings.elems - 2;
    while $j >= 0 {
        @r2l[$j] = @r2l[$j + 1] + 1
            if @rankings[$j] > @rankings[$j + 1];
        $j--;
    }

    my Int $count = 0;
    $count += (@l2r[$_], @r2l[$_]).max for 0 .. @rankings.elems - 1;

    return $count;
}
