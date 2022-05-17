#!/usr/bin/env raku

use Test;
constant TEST = False;

if TEST {
    my $happy-file = $?FILE.IO.parent(1).add("happy.txt");
    my @given = map { .words[1] => .words[0] }, $happy-file.lines;
    my $max = @given[*-1].key;

    my $last = $max;        # Test 1 to $last
#$last = 10000;        # Test 1 to $last

    die 'Last test value beyond table of expectations' if $last -1 > $max;
    my %expect = @given;

    plan $last;
    for 1 .. $last -> $n {
        my $exp = %expect{$n}:exists ?? $n !! 0;
        is is-happy( $n), $exp, "is-happy( $n) s/b $exp";
    }
    done-testing;
    exit;
}

sub MAIN ( Int $results = 8 ) {
    my $count = 1;
    my @result;
    my $candidate;
    while @result.elems <  $results {
        if so $candidate = is-happy( $count++ ) {
            @result.push( $candidate );
        }
    }
    @result.say;
}

# return 0 for unhappy else the Int
sub is-happy( Int $arg where $arg > 0 --> Int ) {
    state %happy = 1 => True;
    my %undecided;
    my $i = $arg;

    $i ~~ s:g/0//;

    return $arg if %happy{$i}:exists;

    while $i ≠ 1 {
        return 0 if %undecided{$i};
        %undecided{$i} = True;
        $i = [+] map *² , $i.split('', :skip-empty);
        next;
    }
    %happy ,= %undecided;
    $arg;
}
