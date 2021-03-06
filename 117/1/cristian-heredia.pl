#!/usr/bin/env perl

use strict;
use warnings;
#use Data::Dumper;

my @values;
my @allNumbers = (1 .. 15);

my %numinwrd = (
  1 => 'Line One', 2 => 'Line Two', 3 => 'Line Three', 4 => 'Line Four', 5 => 'Line Five', 
  6 => 'Line Six', 7 => 'Line Seven', 8 => 'Line Eight', 9 => 'Line Nine', 10 => 'Line Ten',
  11 => 'Line Eleven', 12 => 'Line Twelve', 13 => 'Line Thirteen', 14 => 'Line Fourteen', 15 => 'Line Fifteen'
);


readFile('example.txt');  #(checkFile());

sub checkFile{
    my $number_args = $#ARGV + 1;  
    if ($number_args != 1) {  
        print "Please enter the name of the file in the command line.\n";  
        exit;  
    } 
    # if  command line argument received,  
    return $ARGV[0];  
}

sub readFile {
    
    my $file = shift;
    open(FILE, $file) or die "Could not read from $file\n";
    
    while (<FILE>) {
        push(@values, split(", "));
    }
    for (my $i = 0; $i<@allNumbers;$i++){
        unless ( grep( /^$allNumbers[$i]$/, @values ) ) {
            print "The line missing is:\n";
            print "$allNumbers[$i], $numinwrd{$allNumbers[$i]}\n";
            next;
        }    
    }
}









