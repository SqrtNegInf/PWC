#!/usr/bin/env perl

use strict;
use warnings;

die 'not ok - disabled'; # no .pm?
##
# Write a script to implement a four function infix calculator.     
##
#use TWCCalculator;
use constant ADD => "10 + 8";
use constant SUBTRACT => "18 - 66";
use constant ADD_SUBTRACT => "10 + 20 - 5";  
use constant MULTIPLY => "10 * 8";
use constant DIVIDE => "52 / 2";
use constant CALCULATE => "(10 + 20 - 5) * 2"; 

MAIN:{
    my $parser = new TWCCalculator();
    $parser->parse(ADD); 
    $parser->parse(SUBTRACT); 
    $parser->parse(ADD_SUBTRACT); 
    $parser->parse(MULTIPLY); 
    $parser->parse(DIVIDE);
    $parser->parse(CALCULATE);
}   
