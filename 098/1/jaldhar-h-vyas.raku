#!/usr/bin/env raku

sub readN(Str $filename, Int $number) {
    state IO::Handle $fn = Nil;

    try {
        unless $fn {
            $fn = $filename.IO.open(:r);
        }

        return $fn.readchars($number);
    }

    die $!;
}

sub MAIN() {
    say readN('input.txt', 3);
    say readN('input.txt', 3);
    say readN('input.txt', 3);
}
