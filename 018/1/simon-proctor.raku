#!/usr/bin/env raku

sub MAIN ( 
    @words  is copy = <zabc xabcy abcd>
) {
    my @word-subs = @words.map( &all-substrings );
    .say for ([(&)] @word-subs).keys.sort( { $^b.codes <=> $^a.codes } ).grep( { state $len = $_.codes; $_.codes == $len });
}

sub all-substrings( Str $word ) {
    my $len = $word.codes;
    my @subs;

    for (1..$len) -> $sub-len {
        for (0..$len-$sub-len) -> $start {
            @subs.push( $word.substr($start,$sub-len) );
        }
    }
    return set( @subs );
}
