% Robot and slope characteristics
clc
clear all 
close all
global l m I s theta g
l = 0.8;
m = 2;
I = 0.1;
s = 0.5;
g = 9.81;
theta = 3*pi/180;

%% joints values from the inital state
q1 = 0.1860;
q2 = 2.7696;
qd1 = -1.4281;
qd2 = 0.3377;
z = [q1 q2 qd1 qd2]';
%% We solve the differential equation
options = odeset('Events',@PEvents);
z0 = z;
[t,z,te,ze] = ode45(@SS_passif,[0:0.02:10],z0,options);

simulation(t,z)
%% Impact model 
xd = -l*cos(ze(1))*ze(3);
yd = -l*sin(ze(1))*ze(3);

X_dinitial = [ze(3); ze(4);xd; yd ];

Jr = [ -l*cos(ze(1) + ze(2)), -l*cos(ze(1) + ze(2)), 1, 0;
    -l*sin(ze(1) + ze(2)), -l*sin(ze(1) + ze(2)), 0, 1];

A1 =[                 2*m*s^2 + 2*I,         m*s^2 + I, -m*s*(cos(ze(1) + ze(2)) - cos(ze(1))), -m*s*(sin(ze(1) + ze(2)) - sin(ze(1)));
                     m*s^2 + I,         m*s^2 + I,             -m*s*cos(ze(1) + ze(2)),             -m*s*sin(ze(1) + ze(2));
 -m*s*(cos(ze(1) + ze(2)) - cos(ze(1))), -m*s*cos(ze(1) + ze(2)),                           2*m,                             0;
 -m*s*(sin(ze(1) + ze(2)) - sin(ze(1))), -m*s*sin(ze(1) + ze(2)),                             0,                           2*m];

%% Final  Velocity after Impact
X_dfinal = (eye(4) - inv(A1)*Jr'*(inv(Jr*inv(A1)*Jr')*Jr))*X_dinitial;

%Change of the legs
q1n = pi + ze(1) + ze(2);
q2n = -ze(2);
qd1n = X_dfinal(1) + X_dfinal(2);
qd2n = -X_dfinal(2);

z = [q1n q2n qd1n qd2n]';

%% Using the new legs to perfom motion in single support 
z0 = z;
[t,z,te,ze] = ode45(@SS_passif,[0:0.02:10],z0,options);

simulation(t,z)