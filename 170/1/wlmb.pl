#!/usr/bin/env perl5.32.1

use v5.12;
use warnings;
use PDL;
use PDL::NiceSlice;

my $N=10;
my $M=$N>6?1+$N*(log($N)+log(log($N))):14; #upper bound on N-th prime
my $sieve=ones($M); # large enough Eratosthenes sieve
$sieve(0:1).=0; # 0 and 1 are not primes
$sieve($_**2:-1:$_).=0 for(2..sqrt($M)); # all non-trivial multiples are not primes
my $primes=sequence($M)->where($sieve); # primes correspond to non-zeroed positions in sieve
say "P($_)=", $_==0?1:$primes(0:$_-1)->prodover # multiply first primes to obtain primorials
    foreach(0..$N-1);
