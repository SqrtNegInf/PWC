#!/usr/bin/env perl5.32.1

use PDL;
use PDL::NiceSlice;
use PDL::AutoLoader;

my $test=random(925089);
print &fivenum($test),"\n";

sub fivenum {
	my ($data) = pdl @_;
	
	my $len = $data -> dim(0);
	
	my ($min, $quartile_1, $median, $quartile_3, $max);

	my $indx = qsorti($data);
	
	#-- Quartiles
	#-- If len divisible by 4, I take the midpoint of 
	#-- the two observations that embrace the quartile.
	#-- (Recommended better practice is linear interpolation, 
	#-- but the calculation here is also theoretically okay)
	
	if ( ($len % 4) == 0 ) {
		$quartile_1 =
			0.5*($data($indx($len/4))+$data($indx($len/4+1)));
		$quartile_3 =
			0.5*($data($indx(3*$len/4))+$data($indx(3*$len/4+1)));
	} else {
		$quartile_1 = $data($indx(int($len/4)+1));
		$quartile_3 = $data($indx(int(3*$len/4)+1));
	}
	
	return pdl([$data->min, $quartile_1, $data->median, $quartile_3, $data->max]);
}
