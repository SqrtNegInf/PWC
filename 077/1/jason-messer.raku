#!/usr/bin/env raku

# slight cheat in fib sequence to naturally exclude 0 and repeated 1
sub fibs-sum( Int $n where * > 0) {
    my $a := { 1, 2, * + * ... * + * > $n };
    gather for $a($n).combinations.grep( { .sum == $n }) -> $solution {
	take "{$solution.join: ' + '} = $n";
    }
}

.say for fibs-sum(6);
say '--';
.say for fibs-sum(377);
#.say for fibs-sum(100);
