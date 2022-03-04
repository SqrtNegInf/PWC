#!/usr/bin/env raku

subset HHMM where $_ ~~ /^(<[012]>)\d\:<[012345]>\d$/ && $0 <= 23;

unit sub MAIN (Str $trains = "11:20 11:50 | 14:30 15:00",
   :l(:$loquacious),
   :v(:$verbose) = $loquacious,
); 

class Platform
{
  has Str $.id;
  has Str @.in-use is rw;

  method add-if-vacant (HHMM $from, HHMM $to)
  {
    for @.in-use -> $interval
    {
      my ($start, $end) = $interval.split("-");
      next if $to  lt $start;
      next if $end lt $from;

      return False;
    }

    @.in-use.push: "$from-$to";
    return True;
  }

  method Str
  {
    return ": - Platform: $.id: " ~ @.in-use.sort.join(", ");
  }
}

class Station
{
  has Str      $.name;
  has Platform @.platforms is rw;

  method add-train (HHMM $from, HHMM $to)
  {
    for self.platforms -> $platform
    {
      return True if $platform.add-if-vacant($from, $to);
    }
      
    my $platform = Platform.new(id => (self.number-of-platforms + 1).Str);
    self.platforms.push: $platform;
    return $platform.add-if-vacant($from, $to);
  }

  method number-of-platforms
  {
    return @.platforms.elems;
  }

  method Str
  {
    return ": Station: $.name\n" ~ @.platforms>>.Str.join("\n");
  }
}

my $station = Station.new(name => 'Grand Central');

my @trains = $trains.split(/\s\|\s+/);

for @trains.sort -> $from-to
{
  my (HHMM $from, HHMM $to) = $from-to.words;

  die "Train departs ($from) before it arrives ($to)" if $from gt $to;

  say ": Visiting train $from -> $to" if $verbose;

  $station.add-train($from, $to);
}

say $station.Str if $loquacious;

say $station.number-of-platforms;
