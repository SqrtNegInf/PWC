#!/usr/bin/env raku

map {say "$_"}, grep {Date.new($_,12,25).day-of-week==7}, (2019..2100);
