#!/usr/bin/env perl
my $s=5;
my @r;
for(my $i=0; $i<$s; $i++){
	$r[$i]= [(0) x $s];
	${$r[$i]}[$i]=1;
	print join(' ', @{$r[$i]})."\n";
}

