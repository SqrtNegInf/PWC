#!/usr/bin/env raku

sub MAIN( Str $T is copy  = '03:10' ) {
  my ( $hours, $minutes ) = $T.split( /':'/ ) ;
  my $hourposition = 360 / 12 * (+$hours % 12 ) + 30 / 60 * $minutes ;
  my $minutesposition =  360 / 60 * $minutes ;
  say ( max( $hourposition, $minutesposition ) - min( $hourposition ,
        $minutesposition ) ) ~ " degrees" ;
}
