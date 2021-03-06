#!/usr/bin/env perl
use warnings;
use strict;

# Write a script to print 11x11 multiplication table, only the top half triangle.

# Default table to 11x11, will work to 32x32 then formatting breaks down.
my $d = shift || 11;
usage() if ($d > 32 or $d < 1);

head_print($d);
body_print($d);

sub head_print {
	my $d = shift;
	print "  x|";
	print sprintf "%4s", $_ foreach (1 .. $d);
	print "\n---+",  "----" x $d, "\n";	
}

sub body_print {
	my $d = shift;
	my $seen = {};
	foreach my $r (1 .. $d) {
		foreach my $c (1 .. $d) {
			print sprintf "%4s", "$r|" if ($c == 1);
			if ($seen->{$c}{$r}) {
				print sprintf "%4s", " ";
			} else {
				$seen->{$r}{$c}++;
				print sprintf "%4s", $r*$c;
			}
		}
		print "\n";
	}
}

sub usage {
        print <<EOU;
Usage:
Print multiplication table from 1x1 to 32x32
$0 n 
$0 32 
EOU
        exit;
}

__END__

./ch-2.pl 100
Usage:
Print multiplicatiion table from 1x1 to 32x32
./ch-2.pl n 
./ch-2.pl 32 


./ch-2.pl 
  x|   1   2   3   4   5   6   7   8   9  10  11
---+--------------------------------------------
  1|   1   2   3   4   5   6   7   8   9  10  11
  2|       4   6   8  10  12  14  16  18  20  22
  3|           9  12  15  18  21  24  27  30  33
  4|              16  20  24  28  32  36  40  44
  5|                  25  30  35  40  45  50  55
  6|                      36  42  48  54  60  66
  7|                          49  56  63  70  77
  8|                              64  72  80  88
  9|                                  81  90  99
 10|                                     100 110
 11|                                         121

./ch-2.pl 32
  x|   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32
---+--------------------------------------------------------------------------------------------------------------------------------
  1|   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32
  2|       4   6   8  10  12  14  16  18  20  22  24  26  28  30  32  34  36  38  40  42  44  46  48  50  52  54  56  58  60  62  64
  3|           9  12  15  18  21  24  27  30  33  36  39  42  45  48  51  54  57  60  63  66  69  72  75  78  81  84  87  90  93  96
  4|              16  20  24  28  32  36  40  44  48  52  56  60  64  68  72  76  80  84  88  92  96 100 104 108 112 116 120 124 128
  5|                  25  30  35  40  45  50  55  60  65  70  75  80  85  90  95 100 105 110 115 120 125 130 135 140 145 150 155 160
  6|                      36  42  48  54  60  66  72  78  84  90  96 102 108 114 120 126 132 138 144 150 156 162 168 174 180 186 192
  7|                          49  56  63  70  77  84  91  98 105 112 119 126 133 140 147 154 161 168 175 182 189 196 203 210 217 224
  8|                              64  72  80  88  96 104 112 120 128 136 144 152 160 168 176 184 192 200 208 216 224 232 240 248 256
  9|                                  81  90  99 108 117 126 135 144 153 162 171 180 189 198 207 216 225 234 243 252 261 270 279 288
 10|                                     100 110 120 130 140 150 160 170 180 190 200 210 220 230 240 250 260 270 280 290 300 310 320
 11|                                         121 132 143 154 165 176 187 198 209 220 231 242 253 264 275 286 297 308 319 330 341 352
 12|                                             144 156 168 180 192 204 216 228 240 252 264 276 288 300 312 324 336 348 360 372 384
 13|                                                 169 182 195 208 221 234 247 260 273 286 299 312 325 338 351 364 377 390 403 416
 14|                                                     196 210 224 238 252 266 280 294 308 322 336 350 364 378 392 406 420 434 448
 15|                                                         225 240 255 270 285 300 315 330 345 360 375 390 405 420 435 450 465 480
 16|                                                             256 272 288 304 320 336 352 368 384 400 416 432 448 464 480 496 512
 17|                                                                 289 306 323 340 357 374 391 408 425 442 459 476 493 510 527 544
 18|                                                                     324 342 360 378 396 414 432 450 468 486 504 522 540 558 576
 19|                                                                         361 380 399 418 437 456 475 494 513 532 551 570 589 608
 20|                                                                             400 420 440 460 480 500 520 540 560 580 600 620 640
 21|                                                                                 441 462 483 504 525 546 567 588 609 630 651 672
 22|                                                                                     484 506 528 550 572 594 616 638 660 682 704
 23|                                                                                         529 552 575 598 621 644 667 690 713 736
 24|                                                                                             576 600 624 648 672 696 720 744 768
 25|                                                                                                 625 650 675 700 725 750 775 800
 26|                                                                                                     676 702 728 754 780 806 832
 27|                                                                                                         729 756 783 810 837 864
 28|                                                                                                             784 812 840 868 896
 29|                                                                                                                 841 870 899 928
 30|                                                                                                                     900 930 960
 31|                                                                                                                         961 992
 32|                                                                                                                            1024
