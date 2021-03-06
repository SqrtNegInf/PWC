#!/usr/bin/env raku
#my %*SUB-MAIN-OPTS = :named-anywhere;

sub MAIN( @files = [<example.txt>])
{
    my $csv =False; my $graph = True; my $sort-by-label = False; 
    CATCH { return .message.say }    

    my @words   = @files 
                  ?? @files.map( |*.IO.lines )
                  !! |$*ARGFILES.lines;

    my $weights = Bag.new( @words );
    my $lngst   = max $weights.keys.map( *.chars );

    my $format  = $csv   ?? "%s, %s"           !! 
                  $graph ?? "%{$lngst}s | %s " !!
                  "%-{$lngst}s %s "             ;
 
    my &sorter  = $sort-by-label 
                  ?? { $^a.key   cmp $^b.key   } 
                  !! { $^b.value <=> $^a.value };

    .say for $weights
        .sort( &sorter )
        .map({ .key => $graph ?? "#" x .value !! .value })
        .map({ sprintf $format, .key, .value });
}
