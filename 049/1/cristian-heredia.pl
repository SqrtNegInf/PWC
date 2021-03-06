#!/usr/bin/env perl
use strict;
use warnings;
no warnings 'recursion';

#Smallest Multiple
#Write a script to accept a positive number as command line argument and print the smallest multiple of the given number consists of digits 0 and 1.

#For example:

#For given number 55, the smallest multiple is 110 consisting of digits 0 and 1.
my $number = 55;
my $result;
my $multiple = 2;

smallestMultiple();

sub smallestMultiple {
    $result = $number * $multiple;
    checkValues();
}

sub checkValues {
   if ( $result =~ /^[01]+$/ ) {
		$number=~ s/^\s+|\s+$//g; 
		print "The smallest multiple is $result\n$number * $multiple = $result\n";
   }
   else {
       $multiple++;
       smallestMultiple();
   }
}
