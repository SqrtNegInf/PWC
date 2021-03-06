#!/usr/bin/env raku

# Playing with command-line validation.
# Lines are ints, end_line is greater than begin_line,
# all input files are readable- OK to skip that, CatHandle would complain.
sub MAIN(Int $line_to_start is copy=3 ,    #= First line to print
         Int $end_line                  #= Last line to print
            where { $_ >= $line_to_start
                or die "end_line cannot be less than line_to_start" }=6 ,

         $input_file       #= File(s) to read from. Also reads STDIN.
            where { .all.IO.f
                or die "Not a file path:\n  { .grep({! .IO.f}).join: "\n  " } "} = 'input.txt'
    ) {
    .say if --$line_to_start < 1
        for IO::CatHandle.new($input_file, $*IN).lines($end_line)
    # Alternative would be to use .lines.kv to get line num with line
}
