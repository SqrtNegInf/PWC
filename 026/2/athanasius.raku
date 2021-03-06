#!/usr/bin/env raku

################################################################################
=begin comment

Perl Weekly Challenge 026
=========================

Task #2
-------
Create a script that prints *mean angles* of the given list of angles in
degrees. Please read [ https://en.wikipedia.org/wiki/Mean_of_circular_quantities
|wiki page] that explains the formula in details with an example.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
multi sub MAIN(@angles = (180,270,360) )                  #= One or more angles (all in degrees)
#===============================================================================
{
    my Real:D @real-angles = @angles;

    @real-angles.elems > 0
        or X::Mean-Angles::No-Angles.new.throw;

    # Calculate and display the circular mean

    $*OUT.encoding('windows-1252');

    "The circular mean of the angle%s\n  (%s)\nis %.1f\n".printf:
        @angles.elems == 1 ?? '' !! 's',
        @angles.map( { "$_" } ).join(', '),
        find-circular-mean(@angles);

}

#-------------------------------------------------------------------------------
sub find-circular-mean(*@angles --> Real:D)
#-------------------------------------------------------------------------------
{
    # The circular mean (in radians) is given by the formula:
    #
    #     atan2( 1/n ∑ [j=1..n] sin α_j, 1/n ∑ [j=1..n] cos α_j )

    my Real $sum-of-sines   = 0;
    my Real $sum-of-cosines = 0;

    for @angles -> Real $degrees
    {
        my Real $radians = $degrees * (π / 180);
        $sum-of-sines   += $radians.sin;              # build ∑ [j=1..n] sin α_j
        $sum-of-cosines += $radians.cos;              # build ∑ [j=1..n] cos α_j
    }

    my UInt $n = @angles.elems;

    return ($sum-of-sines / $n).atan2($sum-of-cosines / $n) * (180 / π);
}

################################################################################
