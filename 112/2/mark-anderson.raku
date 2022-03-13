#!/usr/bin/env raku

multi MAIN
{
    use Test;
    plan 6;

    is stairs(3).elems,   3;

    is stairs(4).elems,   5;

    is stairs(10).elems, 89;

    is-deeply stairs(3),  ((1, 1, 1), 
                           (1, 2), 
                           (2, 1))>>.Seq;

    is-deeply stairs(4),  ((1, 1, 1, 1), 
                           (1, 1, 2), 
                           (1, 2, 1), 
                           (2, 1, 1), 
                           (2, 2))>>.Seq;

    is-deeply stairs(10), ((1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
                           (1, 1, 1, 1, 1, 1, 1, 1, 2),
                           (1, 1, 1, 1, 1, 1, 1, 2, 1),
                           (1, 1, 1, 1, 1, 1, 2, 1, 1),
                           (1, 1, 1, 1, 1, 1, 2, 2),
                           (1, 1, 1, 1, 1, 2, 1, 1, 1),
                           (1, 1, 1, 1, 1, 2, 1, 2),
                           (1, 1, 1, 1, 1, 2, 2, 1),
                           (1, 1, 1, 1, 2, 1, 1, 1, 1),
                           (1, 1, 1, 1, 2, 1, 1, 2),
                           (1, 1, 1, 1, 2, 1, 2, 1),
                           (1, 1, 1, 1, 2, 2, 1, 1),
                           (1, 1, 1, 1, 2, 2, 2),
                           (1, 1, 1, 2, 1, 1, 1, 1, 1),
                           (1, 1, 1, 2, 1, 1, 1, 2),
                           (1, 1, 1, 2, 1, 1, 2, 1),
                           (1, 1, 1, 2, 1, 2, 1, 1),
                           (1, 1, 1, 2, 1, 2, 2),
                           (1, 1, 1, 2, 2, 1, 1, 1),
                           (1, 1, 1, 2, 2, 1, 2),
                           (1, 1, 1, 2, 2, 2, 1),
                           (1, 1, 2, 1, 1, 1, 1, 1, 1),
                           (1, 1, 2, 1, 1, 1, 1, 2),
                           (1, 1, 2, 1, 1, 1, 2, 1),
                           (1, 1, 2, 1, 1, 2, 1, 1),
                           (1, 1, 2, 1, 1, 2, 2),
                           (1, 1, 2, 1, 2, 1, 1, 1),
                           (1, 1, 2, 1, 2, 1, 2),
                           (1, 1, 2, 1, 2, 2, 1),
                           (1, 1, 2, 2, 1, 1, 1, 1),
                           (1, 1, 2, 2, 1, 1, 2),
                           (1, 1, 2, 2, 1, 2, 1),
                           (1, 1, 2, 2, 2, 1, 1),
                           (1, 1, 2, 2, 2, 2),
                           (1, 2, 1, 1, 1, 1, 1, 1, 1),
                           (1, 2, 1, 1, 1, 1, 1, 2),
                           (1, 2, 1, 1, 1, 1, 2, 1),
                           (1, 2, 1, 1, 1, 2, 1, 1),
                           (1, 2, 1, 1, 1, 2, 2),
                           (1, 2, 1, 1, 2, 1, 1, 1),
                           (1, 2, 1, 1, 2, 1, 2),
                           (1, 2, 1, 1, 2, 2, 1),
                           (1, 2, 1, 2, 1, 1, 1, 1),
                           (1, 2, 1, 2, 1, 1, 2),
                           (1, 2, 1, 2, 1, 2, 1),
                           (1, 2, 1, 2, 2, 1, 1),
                           (1, 2, 1, 2, 2, 2),
                           (1, 2, 2, 1, 1, 1, 1, 1),
                           (1, 2, 2, 1, 1, 1, 2),
                           (1, 2, 2, 1, 1, 2, 1),
                           (1, 2, 2, 1, 2, 1, 1),
                           (1, 2, 2, 1, 2, 2),
                           (1, 2, 2, 2, 1, 1, 1),
                           (1, 2, 2, 2, 1, 2),
                           (1, 2, 2, 2, 2, 1),
                           (2, 1, 1, 1, 1, 1, 1, 1, 1),
                           (2, 1, 1, 1, 1, 1, 1, 2),
                           (2, 1, 1, 1, 1, 1, 2, 1),
                           (2, 1, 1, 1, 1, 2, 1, 1),
                           (2, 1, 1, 1, 1, 2, 2),
                           (2, 1, 1, 1, 2, 1, 1, 1),
                           (2, 1, 1, 1, 2, 1, 2),
                           (2, 1, 1, 1, 2, 2, 1),
                           (2, 1, 1, 2, 1, 1, 1, 1),
                           (2, 1, 1, 2, 1, 1, 2),
                           (2, 1, 1, 2, 1, 2, 1),
                           (2, 1, 1, 2, 2, 1, 1),
                           (2, 1, 1, 2, 2, 2),
                           (2, 1, 2, 1, 1, 1, 1, 1),
                           (2, 1, 2, 1, 1, 1, 2),
                           (2, 1, 2, 1, 1, 2, 1),
                           (2, 1, 2, 1, 2, 1, 1),
                           (2, 1, 2, 1, 2, 2),
                           (2, 1, 2, 2, 1, 1, 1),
                           (2, 1, 2, 2, 1, 2),
                           (2, 1, 2, 2, 2, 1),
                           (2, 2, 1, 1, 1, 1, 1, 1),
                           (2, 2, 1, 1, 1, 1, 2),
                           (2, 2, 1, 1, 1, 2, 1),
                           (2, 2, 1, 1, 2, 1, 1),
                           (2, 2, 1, 1, 2, 2),
                           (2, 2, 1, 2, 1, 1, 1),
                           (2, 2, 1, 2, 1, 2),
                           (2, 2, 1, 2, 2, 1),
                           (2, 2, 2, 1, 1, 1, 1),
                           (2, 2, 2, 1, 1, 2),
                           (2, 2, 2, 1, 2, 1),
                           (2, 2, 2, 2, 1, 1),
                           (2, 2, 2, 2, 2))>>.Seq;
}

multi MAIN(UInt $u)
{
    my $seq := stairs($u);

    say $seq.elems;

    .say for $seq;
}    

sub stairs(UInt $u) 
{
    my $head = ('100' x $u).substr(0, $u).parse-base(2);
    my $tail = ('110' x $u).substr(0, $u).parse-base(2); 

    ($head..$tail).map({
        my $b = .base(2);

        unless $b ~~ /000||111/
        {
            $b.comb(/(.)$0?/).map(*.chars)
        }
    }).sort
}