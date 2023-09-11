function [val] = fib(n)
assert(n > 0)
if (n == 1) || (n == 2)
    val = 1;
else
    val = fib(n - 1) + fib(n - 2);
end
