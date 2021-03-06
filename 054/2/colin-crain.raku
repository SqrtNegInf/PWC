#!/usr/bin/env raku

#
#       call_me_collatz.raku
#
#         TASK #2
#         Collatz Conjecture
#             It is thought that the following sequence will always reach 1:
#
#                 $n = $n / 2 when $n is even
#                 $n = 3*$n + 1 when $n is odd
#
#             For example, if we start at 23, we get the following sequence:
#
#                 23 → 70 → 35 → 106 → 53 → 160 → 80 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
#
#             Write a function that finds the Collatz sequence for any positive
#             integer. Notice how the sequence itself may go far above the
#             original starting number.
#
#         Extra Credit
#             Have your script calculate the sequence length for all starting
#             numbers up to 1000000 (1e6), and output the starting number and
#             sequence length for the longest 20 sequences.
#
#
#         method: since the conjecture is that _all_ such sequences converge, it
#             seems safe to say that the it's been checked for a lot of numbers.
#             So we'll make a loop that finds the next number, and finishes when
#             that number reaches 1. It may run a while, but it should always
#             eventually finish, right? Certainly for n<1,000,000.
#
#             For the sake of clarity, I've removed the logic of the conjecture
#             into its own separate routine.
#
#             For the metaanalysis (hey look, two 'a's in a row, see 53-2),
#             keeping all the sequences for a million numbers gets big quickly,
#             so for that task we throw out the numbers and only keep a total
#             count of the length indexed on the starting number.
#
#             To ensure reproducability, we will slightly modify the challenge
#             to find the lowest numbers of the 20 longest sequences. The
#             request wasn't for the numbers to create sequences of the longest
#             twenty lengths, so we need a qualifier to determine which numbers
#             to include if multiple sequences of equal length are completing
#             for the last places in the list. By sorting first to find the
#             highet values and secondarily to find the lowest number running
#             the script on different systems running different hashing
#             algorithms.
#
#             Since we were in there looking at a couple of million numbers, it
#             seemed reasonable to wonder what the largest number we found along
#             the way actually was. So I added a little ratcheting variable that
#             updates the high number and the number of the sequence that
#             spawned it whenever the previous value is exceeded. It's
#             56,991,483,520, in the sequence for the number 704,511. Huh.
#
#             To enable the metaanalysis, pass any positive second argument on
#             the command line.
#
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

sub MAIN (Int:D $start where {$start > 0} = 23, $do_meta = 0) {

    say join ', ', make_collatz_sequence($start);

    exit unless $do_meta;
    my %sequences;
    my %data = (  highest_number => 0,
                  highest_value  => 0   );

    get_collatz_metadata(%data, %sequences);

    ## display length totals
    my $count;
    my @sorted =  (keys %sequences).sort({ %sequences{$^b} <=> %sequences{$^a} || $^a <=> $^b });

    say '-' x 35;
    say ' count   number   sequence length';
    say '-------+--------+------------------';

    for ^20 -> $idx {
        printf "  %2d   %6d      %-6d\n", $idx+1, @sorted[$idx], %sequences{@sorted[$idx]} ;
    }

    ## display max number found
    say '-' x 35;
    say "largest value found was ", %data<highest_value>;
    say "for number ", %data<highest_number>;

}

sub make_collatz_sequence ( $start ) {
    my $current = $start;
    my @seq = ($current);
    my $next;

    while ($current != 1) {
        $next = next_collatz($current);
        @seq.push: $next;
        $current = $next;
    }

    return @seq;
}

sub next_collatz (Int:D  $n ) {
## this confuses the compiler so we need to explicitly recast n/2 as an Int rather than a Rat
## which, by the way, is fine, because it always will remain an integer as n is even
    $n %% 2  ??   ($n / 2).Int
             !!   3 * $n + 1;
}


sub get_collatz_metadata ( %data, %sequences ) {
## run metaanalysis on the first 1,000,000 Collatz sequences
    my $then = now;
    for (1..1000000) -> $number {
        my $prev = $number;
        my $len  = 1;
        my $next;

        while ($prev != 1) {
            $next = $prev % 2 == 0  ??   $prev / 2
                                    !!   3 * $prev + 1;
            $prev = $next;
            if ($next > %data<highest_value>) {
                %data<highest_number> = $number;
                %data<highest_value>  = $next;
            }
            $len++;
        }
        %sequences{$number} = $len;
    }
    say "time: ", now - $then;
}
