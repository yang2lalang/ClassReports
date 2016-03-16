function [ f ] = test_periodic( X )
%% This is used to test the motion to see if it is periodic
[t,z,Xn] = poincar(X);
f = Xn-X;
end

