function [ J ] = resol( x )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
global l m s g theta
global d Ry I2y R_Ratio I_Ratio qd1 qd2 taui1 taui2 T
q_final1 = x(1);
q_final2 = x(2);
q_dfinal1 = x(3);
q_dfinal2 = x(4);
T = x(5);
theta = 0;
Tau1 = zeros(50,2);
I1 = eye(4);
J = 0;
I = [I2y * I_Ratio; I2y];
xd = -l*cos(q_final1)*q_dfinal1;
yd = -l*sin(q_final1)*q_dfinal1;

X_dinitial = [xd; yd; q_dfinal1; q_dfinal2];

% compute the trajectory
Jr = [ -l*cos(q_final1 + q_final2), -l*cos(q_final1 + q_final2), 1, 0;
    -l*sin(q_final1 + q_final2), -l*sin(q_final1 + q_final2), 0, 1];

A1 =[                 2*m*s^2 + 2*I(1),         m*s^2 + I(2), -m*s*(cos(q_final1 + q_final2) - cos(q_final1)), -m*s*(sin(q_final1 + q_final2) - sin(q_final1));
                     m*s^2 + I(2),         m*s^2 + I(1),             -m*s*cos(q_final1 + q_final2),             -m*s*sin(q_final1 + q_final2);
 -m*s*(cos(q_final1 + q_final2) - cos(q_final1)), -m*s*cos(q_final1 + q_final2),                           2*m,                             0;
 -m*s*(sin(q_final1 + q_final2) - sin(q_final1)), -m*s*sin(q_final1 + q_final2),                             0,                           2*m];


X_dfinal = (I1 - inv(A1)*Jr'*(inv(Jr*inv(A1)*Jr')*Jr))*X_dinitial;

q_dfinal1 = X_dfinal(3);
q_dfinal2 = X_dfinal(4);

q_10 = q_final1 + q_final2 -pi;
q_20 = -q_final2;
q_d10 = q_dfinal2;
q_d20 = q_dfinal1;
q_int1 = 0;
q_int2 = -pi;

q_1 = [q_10 q_d10 q_int1 q_dfinal1 q_final1]';
q_2 = [q_20 q_d20 q_int2 q_dfinal2 q_final2]';
  
A2 = [1 0 0 0 0; 
      0 1 0 0 0;
      1 T/2 (T/2)^2 (T/2)^3 (T/2)^4;
      0 1 2*T 3*T^2 4*T^3;
      1 T T^2 T^3 T^4];
a1 = inv(A2)*q_1;
a2 = inv(A2)*q_2;

for k = 1:50
    t = T/50*k;
    
    q1 = a1(1) + a1(2)*t + a1(3)*t^2 + a1(4)*t^3 +a1(5)*t^4;
    q2 = a2(1) + a2(2)*t + a2(3)*t^2 + a2(4)*t^3 +a2(5)*t^4;
    
    qd1 = a1(1) + 2*a1(2)*t + 3*a1(3)*t^2 +4*a1(4)*t^3;
    qd2 = a2(1) + 2*a2(2)*t + 3*a2(3)*t^2 +4*a2(4)*t^3;
% compute the torque required at each point of the trajectory
    A = [ 2*I(1) + 2*l^2*m + 2*m*s^2 - 2*l*m*s + 2*l*m*s*cos(q2), m*s^2 + l*m*cos(q2)*s + I(2);
                         m*s^2 + l*m*cos(q2)*s + I(2),                 m*s^2 + I(1)];
                     
    H = [ - l*m*s*sin(q2)*qd2^2 - 2*l*m*qd1*s*sin(q2)*qd2 - g*m*(s*sin(q1 + q2 - theta) + 2*l*sin(q1 - theta) - s*sin(q1 - theta));
                                                                         l*m*s*sin(q2)*qd1^2 - g*m*s*sin(q1 + q2 - theta)];
                                                                     
    Q = [ -g*m*(s*sin(q1 + q2 - theta) + 2*l*sin(q1 - theta) - s*sin(q1 - theta));
                                             -g*m*s*sin(q1 + q2 - theta)];
                                         
    
    Tau1(k,:) = inv(eye(2))*(A*[qd1, qd2]' + H + Q);
    taui1 = Tau1(k,1);
    taui2 = Tau1(k,2);
    
end
% compute the criterion
Tauc = Tau1*Tau1';

for j = 1:50
    J = J + 1/d*Tauc(j)*T/50;
end

end

