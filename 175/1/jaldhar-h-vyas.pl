#!/usr/bin/env perl
use 5.030;
use warnings;
use DateTime;

my ($year) = 2022;

for my $month  (1..12 ) {
    my $lastDate = DateTime->last_day_of_month(year => $year, month => $month);
    $lastDate ->subtract(days => $lastDate->dow % 7);
    say $lastDate->ymd;
}
