#!/usr/bin/env raku

sub decode( @message ) {
    my @chars;
    my $decoded;

    # covnert every line of the message into single chars
    # and push them as an array for every position within the
    # string. It produces something like:
    # [[P 1 5 P 2 <] [+ e - x e !] [2 8 r w 3 r]
    # [l 0 ] l 5 ^] [! R + b R (] [a $ a 3 8 )]
    # [t 4 > k y k] [o u / \ u 0]]
    for @message -> $single-line {
        for $single-line.split( '', :skip-empty ) {
            next if ! $_.trim;
            @chars[ $++ ].push: $_;
        }
    }

    # now for every inner list, gets the chars that are
    # present multiple times
    for @chars -> @line {
        for @line -> $searching_for {
            if @line.grep( { $_ eq $searching_for} ).elems > 1 {
                $decoded ~= $searching_for;
                last;
            }
        }
    }

    return $decoded;
}

sub MAIN {
    my @hello-msg =  "H x l 4 !"
    , "c e - l o"
    , "z e 6 l g"
    , "H W l v R"
    , 'q 9 m # o';


    my @secret-message = 'P + 2 l ! a t o'
    ,'1 e 8 0 R $ 4 u'
    ,'5 - r ] + a > /'
    ,'P x w l b 3 k \ '
    ,'2 e 3 5 R 8 y u'
    ,'< ! r ^ ( ) k 0';


    for [@hello-msg, @secret-message ] {
        say "The encoded message was ";
        $_.join( "\n" ).say;
        say "resulted into the plain message ";
        say decode( $_ );
    }

    say "\nDone!";
}
