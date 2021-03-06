#!/usr/bin/env raku

sub MAIN(Str :$string where { $string ~~ m:i/^s\d+$/ } = 'S7') {
    string_0_1($string).say;
}

sub string_0_1($string) {

    my $limit = .Int for $string ~~ m/(\d+)/;
    die "ERROR: Invalid string [$string]. S30 is the limit.\n"
        if $limit > 30;

    my $string_0_1 = '';
    for 1 .. $limit {
        my $_string_0_1 =  $string_0_1.flip;
        $_string_0_1    ~~ tr/[01]/[10]/;
        $_string_0_1    =  '0' ~ $_string_0_1;
        $string_0_1     =  $string_0_1 ~ $_string_0_1;
    }

    return $string_0_1;
}
