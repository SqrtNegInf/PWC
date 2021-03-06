#!/usr/bin/env raku

# Hmmm...I wonder exactly what is meant by the phrase "positive numbers".
# For example, is --10 a positive number?

# Some example numbers that might be considered positive:
#     INPUT    I ASSUME THIS IS THE DESIRED OUTPUT
#     0        0
#     +0       +0
#     +4       +4
#     +4.4     +4.4
#     +04.4    +4.4
#     +--4     +--4
#     +--4.4   +--4.4
#     10       10

# Test input.
my @input = <<0 +0 +4 +4.4 +04.4 +--4 +--4.4 10>>;

# Print a heading.
print q:to/END/;
INPUT     OUTPUT
------    ------
END

for (@input)
{
    my $input = $_;
    s/^^$<prezero>=(<[+-]>*)0+$<postzero>=(\d+)/$<prezero>$<postzero>/;
    "%-6s    %s\n".printf($input, $_);
}
