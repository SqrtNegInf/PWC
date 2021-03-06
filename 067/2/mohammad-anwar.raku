#!/usr/bin/env raku

sub MAIN(Str :$digits where { $digits ~~ /^ <[0..9\*\#]>+ $/ } = '249') {
    say sprintf("[ %s ]", phone-letters($digits).join(", "));
}

sub phone-letters(Str $digits where { $digits ~~ /^ <[0..9\*\#]>+ $/ }) {

    # letter phone
    my %letter-of = (
        '1' => '_,@',
        '2' => 'abc',
        '3' => 'def',
        '4' => 'ghi',
        '5' => 'jlk',
        '6' => 'mno',
        '7' => 'pqrs',
        '8' => 'tuv',
        '9' => 'wxyz',
        '0' => '0',
        '#' => '#',
        '*' => chr(9251),
    );

    # prepare data set
    my @data = $digits.comb.map({ [ %letter-of{$_}.comb ] });

    # generate all possible combinations
    return map {qq{'$_'}}, ([X~] @data);
}
