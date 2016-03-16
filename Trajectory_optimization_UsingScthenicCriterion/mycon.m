function [ cieq,ceq ] = mycon(x)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
global d Ry I2y R_Ratio I_Ratio qd1 qd2 taui1 taui2 

cieq = [d-0.2;
-Ry;
-I2y;
R_Ratio-0.7;
I_Ratio-0.7;
qd1-3;
qd2-3;
taui1-50;
taui2-50;];
ceq = [];


end

