#!/usr/bin/env raku

unit sub MAIN (@files = ['input-list.txt'], :$verbose, :$u);

say ": Files: @files[]" if $verbose;

my @input = @files.elems
  ?? IO::CatHandle.new(@files).lines
  !! lines;

say ": Content: @input[]" if $verbose;

my %sort;
my %seen;
my @output;

for @input -> $current
{
  my ($mailbox, $domain) = $current.split('@');

  say ": Candidate: $mailbox @ { $domain.lc }" if $verbose;

  if $u
  {
    my $candidate = $mailbox ~ '@' ~  $domain.lc;
    next if %seen{$candidate};
    %seen{$candidate} = True;
  }

  %sort{$current} = "{ $domain.lc } $mailbox";
  @output.push: $current;
}

.say for @output.sort({ %sort{$^a} cmp %sort{$^b} });
