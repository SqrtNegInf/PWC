#!/usr/bin/env raku

sub compute_area ( @rect) {
    my $area = (@rect[1][0] - @rect[0][0]) * (@rect[1][1] - @rect[0][1]);
}
for ( ( ( (-1,0) , (2,2)), ( ( 0,-1), (4,4) ) ),
      ( ( (-3,-1), (1,3)), ( (-1,-3), (2,2) ) )
    ) -> $test {
        my @overlap_rect =
            ( max($test[0][0][0], $test[1][0][0]),   # x 1st point
              max($test[0][0][1], $test[1][0][1]) ), # y 1st point
            ( min($test[0][1][0], $test[1][1][0]),   # x 2nd point
              min($test[0][1][1], $test[1][1][1]) ); # y 2nd point
        my $overlap_area = compute_area @overlap_rect;
        my $area = compute_area($test[0]) + compute_area($test[1]) - $overlap_area;
        my $display = "[ ($test[0][0]) ($test[0][1]) ] " ~
            "[ ($test[1][0]) ($test[1][1]) ]";
        say "Area of $display is: $area";
}
