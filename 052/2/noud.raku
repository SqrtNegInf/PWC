#!/usr/bin/env raku

use experimental :cached;

# Compute the max amount of money a player can get when both players play
# optimal. Note that this algorithm only computes the amount the player will
# win if both the player and computer play optimal. This game is a min-max
# game. Your optimize your gain by simultaneously minimizing the gain of your
# opponent.
sub max-amount(@coins) is cached {
    if (@coins.elems < 2) {
        return @coins.sum();
    }

    return @coins.sum() - min(max-amount(@coins[1..*-1]),
                              max-amount(@coins[0..*-2]));
}


# Convert coins on the table to cents
my @coins = [100, 50, 1, 10, 5, 20, 200, 2];

# Player wins
my $player-win = max-amount(@coins);

# Computer wins
my $computer-win = @coins.sum() - $player-win;

say 'Player wins: ', $player-win, ' cents.';
say 'Computer wins: ', $computer-win, ' cents.';
if ($player-win > $computer-win) {
    say 'Player wins!';
} elsif ($player-win < $computer-win) {
    say 'Computer wins!';
} else {
    say 'Remise, neither player or computer wins.';
}
