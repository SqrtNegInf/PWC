#!/usr/bin/env raku

my @brilliants = ();

for (1,2) -> $i {
	my @a  = (2..1000).
		 grep(*.is-prime).
		 grep(*.Str.chars==$i);
		
	for (0 .. @a.elems-1) -> $i {
		for ($i .. @a.elems-1) -> $j {
			@brilliants.append(@a[$i]*@a[$j]);
		}
	} 
}
	
say @brilliants.sort.head(20);


