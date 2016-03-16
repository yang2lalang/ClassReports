% parameters 
global l m S g theta
l = 0.8;
m = 2;
S = 0.5;
g = 9.81;
theta = 0;
global d Ry I2y R_Ratio I_Ratio qdi1 qdi2 taui1 taui2
global q_final1 q_final2 q_dfinal1 q_dfinal2 T
x = [q_final1, q_final2, q_dfinal1, q_dfinal2 , T]'
fmincon(@resol,[0;0;1;1;0.9],[],[],[],[],[-pi;-3;-3;0.1;0.1],[pi;3;3;10;0.9],@mycon)







