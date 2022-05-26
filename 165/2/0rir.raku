#!/usr/bin/env raku

#use lib $?FILE.IO.parent(1).add("lib");
#use SVGize;

my constant $stroke-width = 1;
my constant $min-radius = 1;

sub SVGize( @ary is copy --> Str) is export {

    my @dot = '<circle cx="', '" cy="',
                qq{" r="$min-radius" stroke="orange"/>\n};
    my @line  = '<line x1="', '" y1="', '" x2="', '" y2="',
                qq{" stroke="lightgreen" stroke-width="1"/>\n};

    return _prefix()
           ~ @ary.map( {  2 == $_.elems
                ?? roundrobin( @dot,  @$_).flat.join
                !! roundrobin( @line, @$_).flat.join;
             }).join()
           ~ _suffix();
}

sub _prefix( --> Str ) {
    qq{<?xml version="1.0" standalone="no"?>\n}
  ~ qq{<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" \n}
  ~ qq{"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">\n}
  ~ qq{<svg width="100%" height="100%" version="1.1"\n}
  ~ qq{xmlns="http://www.w3.org/2000/svg">\n}
}

sub _suffix( --> Str ) {
    q{</svg>}
}

my $in =
    qq{ 333,129  39,189 140,156 292,134 393,52  160,166 362,122  13,193
    341,104 320,113 109,177 203,152 343,100 225,110  23,186 282,102
    284,98  205,133 297,114 292,126 339,112 327,79  253,136  61,169
    128,176 346,72  316,103 124,162  65,181 159,137 212,116 337,86
    215,136 153,137 390,104 100,180  76,188  77,181  69,195  92,186
    275,96  250,147  34,174 213,134 186,129 189,154 361,82  363,89 }
;

sub MAIN() {
    my @input = _munge( get-input( $in));
    my @point = @input.append: [ least-squares-regression( @input) ].flat;

    # Shift & flip for presentation XXX eliminate above .flat
    my $margin = 1.1;
    my $y-offset = @point.map( {$_[1] } ).max;
    $y-offset = $y-offset > 0 ??  -$y-offset !! $y-offset;
    @point = @point.map( { [ $_[0], -$margin*$y-offset - $_[1]]});

    {       # Undo .flat.  Or: convert dots back to best fit line.
        my @line = @point[*-2..*-1].flat[*;*];
        @point = @point[0..*-3];
        @point.push: @line; 
    }
    say SVGize( @point);
}

sub get-input( $a ) {
    $a.split( / \s+ /, :skip-empty);
}

sub _munge( @a ) {
    @a.map: { [ +« $_.split( ',', :skip-empty)]};
}

sub least-squares-regression( @point is copy --> Array) {
    my $xΑ = (@point.map: *[0]).min;
    my $xΩ = (@point.map: *[0]).max;

    my $ct = @point.elems;
    my $Σx  = [+] @point.map: *[0];
    my $Σy  = [+] @point.map: *[1];
    my $Σxy = [+] @point.map: { $_[0] × $_[1] };
    my $Σxx = [+] @point.map: { $_[0] × $_[0] };

    my $slope = ($ct × $Σxy  - $Σx × $Σy) ÷ ($ct × $Σxx - $Σx²);
    my $zero-y = ($Σy - $slope × $Σx) ÷ $ct;
    my $yΑ = $slope × $xΑ + $zero-y;
    my $yΩ = $slope × $xΩ + $zero-y;

    return [[$xΑ, $yΑ], [$xΩ, $yΩ]];
}

