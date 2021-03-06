#!/usr/bin/env raku

subset PositiveIntZero of Int where * >= 0;

#sub MAIN(PositiveIntZero \m, PositiveIntZero \n) { say A(m, n); }

multi A(PositiveIntZero \m where m == 0, PositiveIntZero \n)
{
  return n + 1;
}

multi A(PositiveIntZero \m where m > 0, PositiveIntZero \n where n == 0)
{
  return A(m - 1, 1);
}

multi A(PositiveIntZero \m where m > 0, PositiveIntZero \n where n > 0)
{
  return  A(m - 1, A(m, n - 1));
}

say A(0,0);
say A(1,0);
say A(1,1);
say A(1,2);
