#!/usr/bin/env raku
use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 109
=========================

TASK #1
-------
*Chowla Numbers*

Submitted by: Mohammad S Anwar

Write a script to generate first 20 Chowla Numbers, named after, *Sarvadaman D.
S. Chowla*, a London born Indian American mathematician. It is defined as:

[ C(n) = (sum of divisors of n) - 1 - n ]
  C(n) =  sum of divisors of n except 1 and n

NOTE: Updated the above definition as suggested by Abigail [2021/04/19 18:40].

Output:

 0, 0, 0, 2, 0, 5, 0, 6, 3, 7, 0, 15, 0, 9, 8, 14, 0, 20, 0, 21

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
Although the Task requires the first 20 Chowla Numbers, an option is provided
for the user to specify the number of Chowla Numbers to be generated and dis-
played.

Algorithm
---------
From OEIS "A048050. Chowla's function: sum of divisors of n except 1 and n." :-
"a(n) = 0 if and only if n is a noncomposite number (Cf. A008578). - Omar E.
 Pol, Jul 31 2012"

The algorithm employed is a straightforward calculation:
(1) If n = 1 or n is prime, a(n) = 0
(2) Else a(n) = sum of divisors of n except 1 and n

Implementation
--------------
Raku's built-in is-prime() method is used to screen out zero-valued Chowla
Numbers. Divisors are generated by searching the integer range 2 to (n - 1) for
numbers which divide n without remainder. Raku's reduction metaoperator [+] is
used to sum the divisors.

=end comment
#==============================================================================

my UInt constant $TARGET = 20;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    #"\nChallenge 109, Task #1: Chowla Numbers (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    #| How many Chowla numbers are to be generated?

    UInt:D $target where { $target > 0 } = $TARGET;
)
#==============================================================================
{
    "Input:  $target".put;
    'Output: %d'.printf: chowla( 1  );
    ', %d'.\     printf: chowla( $_ ) for 2 .. $target;
    ''.put;
}

#------------------------------------------------------------------------------
sub chowla( UInt:D $n where { $n > 0 } --> UInt:D )
#------------------------------------------------------------------------------
{
    return 0 if $n == 1 || $n.is-prime;

    my UInt @divisors;

    for 2 .. $n - 1 -> UInt $div
    {
        @divisors.push: $div if $n % $div == 0;
    }

    return [+] @divisors;
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
