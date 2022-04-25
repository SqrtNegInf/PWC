#!/usr/bin/env perl
use warnings;
use strict;
use 5.010;
use constant CHARACTER_GAP => '000';
use constant WORD_GAP => '000000';

my %from_morse = (
    '10111'               => 'A',
    '111010101'           => 'B',
    '11101011101'         => 'C',
    '1110101'             => 'D',
    '1'                   => 'E',
    '101011101'           => 'F',
    '111011101'           => 'G',
    '1010101'             => 'H',
    '101'                 => 'I',
    '1011101110111'       => 'J',
    '111010111'           => 'K',
    '101110101'           => 'L',
    '1110111'             => 'M',
    '11101'               => 'N',
    '11101110111'         => 'O',
    '10111011101'         => 'P',
    '1110111010111'       => 'Q',
    '1011101'             => 'R',
    '10101'               => 'S',
    '111'                 => 'T',
    '1010111'             => 'U',
    '101010111'           => 'V',
    '101110111'           => 'W',
    '11101010111'         => 'X',
    '1110101110111'       => 'Y',
    '11101110101'         => 'Z',
    '10111011101110111'   => '1',
    '101011101110111'     => '2',
    '1010101110111'       => '3',
    '10101010111'         => '4',
    '101010101'           => '5',
    '11101010101'         => '6',
    '1110111010101'       => '7',
    '111011101110101'     => '8',
    '11101110111011101'   => '9',
    '1110111011101110111' => '0',
);

sub morse_decode {
    my ($message) = @_;


    my @words = split WORD_GAP, $message;

    for my $word (@words) {
        my @chars = split CHARACTER_GAP, $word;
        for my $c (@chars) {
            if (exists $from_morse{$c}) {
                $c = $from_morse{$c};
            }
        }
        $word = join q{}, @chars;
    }

    return join q{ }, @words;
}

say morse_decode('101010001110111011100010101');