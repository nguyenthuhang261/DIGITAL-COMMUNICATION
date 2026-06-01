clear;
clc;

xa = 0;
xb = 2;
f = @(x) cos(x) * exp(-x);
N = 50;

res = mid_point(f, xa, xb, N);
fprintf("Gia tri cua tich phan la: %.6f \n", res);

function res = mid_point(f, xa, xb, N)
  h = abs(xb - xa)/N;
  x = xa:h:xb;
  k = 1;
  res = 0;
  while k <= N
      res = res + f(x(k) + h/2) * h;
      k = k + 1;
  end
end
