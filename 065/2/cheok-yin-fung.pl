#!/usr/bin/env perl
use strict;

#Usage: ch-2.pl STRING

sub is_pali {
    my $w = $_[0];           #word
    if (length $w == 1) {return 0;} #single not counted
    my $mid = (int (length $w) / 2) - 1 ;
    my @c = split //, $w;    #characters
    my @stack = map {$c[$_]} (0..$mid);
    my $pointer;
    if ( (length $w) % 2 == 1) {        
        $pointer = $mid+2;     #e.g.  length $w = 3, $mid = 0, $pointer = 2 
    }
    else {
        $pointer = $mid+1;     #e.g.  length $w = 6, $mid = 2, $pointer = 3
    }
    while ($c[$pointer] eq $stack[$#stack]) {
        pop @stack;
        $pointer++;
        last if @stack == ();
    }
    if (@stack == ()) {
        return 1;
    }
    else {
        return 0;
    }
}


my $S = "abaaba";   #default setting
$S = $ARGV[0] if $ARGV[0];


sub part_func {         #partitions, generated by binary strings 
    my $word = $_[0];
    my $bstring = sprintf "%b", $_[1];
    my @warray = split //, $word;
    my @b = split //, $bstring;
    my @ans = ();
    my $temp = "";
    for my $k (0..$#warray) {
        if ($b[$k] == 1) {
            $temp .= $warray[$k];
       } else {
            push @ans,$temp;
            $temp = $warray[$k];
        }
    }
    push @ans, $temp;
    return @ans;
}

my %hresult;
my %sizeresult;
my $n = length $S;

for my $seperator (2**($n-1)+1..2**$n) {
    my @p = grep {is_pali $_} part_func($S, $seperator);

      #from Perl Cookbook Extracting Unique Elements
    my %seen = ();                       
    my @p_uniq;
    foreach my $item (@p) {
        push @p_uniq, $item unless $seen{$item}++;
    }
    my $r = join ",", @p_uniq unless @p_uniq == ();
    $hresult{$r} = 1;
    $sizeresult{$r} = $#p_uniq + 1;
}


sub need_to_remove_subsequence {
    my @in = @_;
    my $bigbrother = shift @in;
    my $number_of_components = 0;
    for my $kid (@in) {
        if (index(",".$bigbrother."," , ",".$kid.",") != -1) {
            $number_of_components++;
        }
    }
    if (    #all components of $pierre is inside $peter
          $number_of_components == $#in+1 
               and 
            # '> instead of '>=' : ALLOW $peter permuted is $pierre
            $sizeresult{$bigbrother} > $#in+1 
        ) 
    {
       return 1; 
    }
    else {
        return 0;
    }
}


#remove_subsequence
for my $peter (keys %hresult) {
    for my $pierre (keys %hresult) {
        unless ( $peter eq $pierre or $peter eq $S) {
            if ( need_to_remove_subsequence( $peter, (split /,/, $pierre) )) {
                delete $hresult{$pierre};
            }
        }
    }
}


#print answer

print "string: ", $S,"\n";
print join "\n", sort keys %hresult;
print "\n";

#
# abaaba -> 
# aa
# baab
# aba
# abaaba
#
# aabaab -> #Example 1
# aabaa
# aa, baab
# aba
#
# abbaba -> #Example 2
# abba
# bb, aba
# bab
