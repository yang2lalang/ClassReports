function [ X , F ] = dicho( a, b,eps,n)
%DICHO Summary of this function goes here
%   Detailed explanation goes here

 L = b - a;
 counter = 0;
 while (L > 2*eps) && (counter < n)
    x1 = a + (L - eps)/2;
    x2 = a + (L + eps)/2;
    if  f(x1) < f(x2) 
        b = x2;
    else
        a = x1;     
    end
    L = b - a;
    counter = counter + 1;
    plot(f(x1),f(x2)); 
 end
X = (x1 + x2)/2
F = f(X)
end

