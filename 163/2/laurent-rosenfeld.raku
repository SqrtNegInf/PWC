#!/usr/bin/env raku
sub summations (@in) {
    my @result = @in;
    for 1..@result.end {
        @result = [\+] @result[1..*-1];
        return @result[0] if @result.elems == 1;
    }
}

for <1 2 3 4 5>, <1 3 5 7 9>, <1 5 4 3 2 6 7> -> @test {
    say @test, " -> ", summations @test;
}
