function [ t,z,Xn ] = poincar( X )
%% Poincare return map to define periodic motion

global m l I s 

%% Define relationship between q1 and q2 at Impact
q2 = pi-2*X(1);

%% Compute the State vector at Impact
xd = -l*cos(X(1))*X(2);
yd = -l*sin(X(1))*X(2);

X_dinitial = [X(2); X(3);xd; yd ];

%% Compute the Impact Model
Jr = [ -l*cos(X(1) + q2), -l*cos(X(1) + q2), 1, 0;
    -l*sin(X(1) + q2), -l*sin(X(1) + q2), 0, 1];

A1 =[                 2*m*s^2 + 2*I,         m*s^2 + I, -m*s*(cos(X(1) + q2) - cos(X(1))), -m*s*(sin(X(1) + q2) - sin(X(1)));
                     m*s^2 + I,         m*s^2 + I,             -m*s*cos(X(1) + q2),             -m*s*sin(X(1) + q2);
 -m*s*(cos(X(1) + q2) - cos(X(1))), -m*s*cos(X(1) + q2),                           2*m,                             0;
 -m*s*(sin(X(1) + q2) - sin(X(1))), -m*s*sin(X(1) + q2),                             0,                           2*m];


X_dfinal = (eye(4) - inv(A1)*Jr'*(inv(Jr*inv(A1)*Jr')*Jr))*X_dinitial;

%% Use Velocity after Impact to perform the relabelling of the joints
q1n = pi + X(1) + q2;
q2n = -q2;
qd1n = X_dfinal(1) + X_dfinal(2);
qd2n = -X_dfinal(2);

%% Create new State vector for the new single support mode
z = [q1n q2n qd1n qd2n]';

options = odeset('Events',@PEvents);
z0 = z;
[t,z,te,ze] = ode45(@SS_passif,[0:0.02:10],z0,options);

%% Limit the solutions to only those in the range 0<q<2pi
if ze(1) > 2*pi
    ze(1) = mod(ze(1),2*pi);
elseif ze(1) < 0
    ze(1) = mod(ze(1),2*pi);
end

Xn = [ze(1); ze(3); ze(4)];
end

