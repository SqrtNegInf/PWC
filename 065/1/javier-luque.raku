#!/usr/bin/env raku

multi MAIN() { MAIN(2, 10); }

multi MAIN(Int $N, Int $S) {
    # Store the answers
    my @answers;

    # Calculate start and end
    my $start = 10 ** ($N - 1);
    my $end   = (10 ** $N) - 1;

    # Process each number
    for ($start .. $end) -> $i {
    	my @numbers = $i.comb;
    	@answers.push($i)
    		if (@numbers.sum == $S);
    }

    # Display answers
    say @answers.join(", ");
}
