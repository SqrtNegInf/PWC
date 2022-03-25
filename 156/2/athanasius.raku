#!/usr/bin/env raku

###############################################################################
=begin comment

Perl Weekly Challenge 156
=========================

TASK #2
-------
*Weird Number*

Submitted by: Mohammad S Anwar

You are given number, $n > 0.

Write a script to find out if the given number is a Weird Number.

According to [ https://en.wikipedia.org/wiki/Weird_number |Wikipedia], it is
defined as:

    The sum of the proper divisors (divisors including 1 but not itself) of the
    number is greater than the number, but no subset of those divisors sums to
    the number itself.

Example 1:

  Input: $n = 12
  Output: 0

  Since the proper divisors of 12 are 1, 2, 3, 4, and 6, which sum to 16; but
  2 + 4 + 6 = 12.

Example 2:

  Input: $n = 70
  Output: 1

  As the proper divisors of 70 are 1, 2, 5, 7, 10, 14, and 35; these sum to 74,
  but no subset of these sums to 70.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
If the constant $VERBOSE is set to True, (the default), the output is followed
by an explanation of why the given n is or is not a weird number.

Table
-----
The first 100 Weird Numbers [1], [2]:
   70,   836,  4030,  5830,  7192,  7912,  9272, 10430, 10570, 10792,
10990, 11410, 11690, 12110, 12530, 12670, 13370, 13510, 13790, 13930,
14770, 15610, 15890, 16030, 16310, 16730, 16870, 17272, 17570, 17990,
18410, 18830, 18970, 19390, 19670, 19810, 20510, 21490, 21770, 21910,
22190, 23170, 23590, 24290, 24430, 24710, 25130, 25690, 26110, 26530,
26810, 27230, 27790, 28070, 28630, 29330, 29470, 30170, 30310, 30730,
31010, 31430, 31990, 32270, 32410, 32690, 33530, 34090, 34370, 34930,
35210, 35630, 36470, 36610, 37870, 38290, 38990, 39410, 39830, 39970,
40390, 41090, 41510, 41930, 42070, 42490, 42910, 43190, 43330, 44170,
44870, 45010, 45290, 45356, 45710, 46130, 46270, 47110, 47390, 47810

Algorithm
---------
1. To determine whether n is an abundant number, its proper factors are first
   generated by filtering integers in the range 1 to ⌊$n / 2⌋ using Raku's
   built-in divisibility operator, "%%".

2. To determine whether n is a semiperfect number, subsets of n's proper
   factors are summed and the results compared with n. Subsets are generated by
   Raku's built-in combinations() method. The argument k to this method
   specifies the number of elements in the required subsets.

   Let the set of proper factors be F. We note that the required values of k
   begin at 3 and end at |F| - 1, because:
   - for any proper divisor d of n, d < n, so if k = 1, sum = d, which is < n;
   - the largest possible proper divisor d0 of n is n/2, and the next largest,
     d1, is < d0, so for k = 2 any sum = (d0 + d1) must be less than n;
   - n is already known to be abundant, so if k = |F| then the sum > n.
   
References
----------
[1] "A006037  Weird numbers: abundant (A005101) but not pseudoperfect
    (A005835).", The On-Line Encyclopedia of Integer Sequences,
     https://oeis.org/A006037
[2]  Amiram Eldar, "Table of n, a(n) for n = 1..10000",
     https://oeis.org/A006037/b006037.txt
[3] "Weird number", Wikipedia, https://en.wikipedia.org/wiki/Weird_number

=end comment
#==============================================================================

my Bool constant $VERBOSE = True;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    #"\nChallenge 156, Task #2: Weird Number (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    UInt:D $n where * > 0  = 70
)
#==============================================================================
{
    "Input:  \$n = $n".put;

    my UInt @divisors = proper-divisors( $n );
    my UInt $sum      = [+] @divisors;

    if $sum <= $n                   # n is not an abundant number
    {
        'Output: 0'.put;
         explain-failure-deficient( $n, @divisors, $sum )          if $VERBOSE;
    }
    else                            # n is an abundant number
    {
        my $subset = find-subset(  $n, @divisors);

        if +$subset > 0             # n is a semiperfect number
        {
            'Output: 0'.put;
             explain-failure-semi(  $n, @divisors, $sum, $subset ) if $VERBOSE;
        }
        else                        # n is not a semiperfect number
        {
            'Output: 1'.put;
             explain-success(       $n, @divisors, $sum )          if $VERBOSE;
        }
    }
}

#------------------------------------------------------------------------------
sub find-subset
(
            UInt:D  $n where * > 0,          #= A natural number
    Array:D[UInt:D] $divisors                #= The proper divisors of n
--> Array:D[UInt:D]                          #= A subset (if any) of the proper
                                             #=   divisors that sums to n
)
#------------------------------------------------------------------------------
{
    my UInt @subset;

    # start = 3: max proper divisor of n is n/2, next lower is < n/2, so sum of
    #            any 2 divisors must be < n
    # end:       sum of all divisors is known to be > n, so end is |n| - 1

    L-OUTER:
    for 3 ..^ +$divisors -> UInt $k
    {
        for $divisors.combinations: $k -> List $comb
        {
            my UInt $sum = [+] $comb;

            if $sum == $n
            {
                @subset = @$comb;
                last L-OUTER;
            }
        }
    }

    return @subset;
}

#------------------------------------------------------------------------------
sub proper-divisors
(
    UInt:D $n where * > 0                    #= A natural number
--> List:D[UInt:D]                           #= The proper divisors of n
)
#------------------------------------------------------------------------------
{
    my UInt @divisors;

    for 1 .. ($n / 2).floor -> UInt $d
    {
        @divisors.push: $d if $n %% $d;
    }

    return @divisors;
}

#------------------------------------------------------------------------------
sub explain-failure-deficient             # Not weird because not abundant
(
            UInt:D  $n where * > 0,          #= A natural number
    Array:D[UInt:D] $divisors,               #= The proper divisors of n
            UInt:D  $sum                     #= The sum of the proper divisors
)
#------------------------------------------------------------------------------
{
    ("\nExplanation:\nThe proper divisors of %d (%s) sum to %d," ~
     "\ntherefore %d is not weird because it is not abundant\n").printf:
      $n, $divisors.join( ', ' ), $sum, $n;
}

#------------------------------------------------------------------------------
sub explain-failure-semi                  # Not weird: abundant but semiperfect
(
            UInt:D  $n where * > 0,          #= A natural number
    Array:D[UInt:D] $divisors,               #= The proper divisors of n
            UInt:D  $sum,                    #= The sum of the proper divisors
    Array:D[UInt:D] $subset                  #= A subset of the proper divisors
                                             #=   that sums to n
)
#------------------------------------------------------------------------------
{
    ("\nExplanation:\nThe proper divisors of %d (%s) sum to %d,"  ~
     "\nbut the subset (%s) of these proper divisors sums to %d," ~
     "\ntherefore %d is not weird because, although abundant, "   ~
     "it is also semiperfect\n").printf:
      $n, $divisors.join( ', ' ), $sum, $subset.join( ', ' ), $n, $n;
}

#------------------------------------------------------------------------------
sub explain-success                       # Weird: abundant and not semiperfect
(
            UInt:D  $n where * > 0,          #= A natural number
    Array:D[UInt:D] $divisors,               #= The proper divisors of n
            UInt:D  $sum,                    #= The sum of the proper divisors
)
#------------------------------------------------------------------------------
{
    ("\nExplanation:\nThe proper divisors of %d (%s) sum to %d," ~
     "\nand no subset of these proper divisors sums to %d,"      ~
     "\ntherefore %d is weird because it is abundant but not "   ~
     "semiperfect\n").printf: $n, $divisors.join( ', ' ), $sum, $n, $n;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

##############################################################################
