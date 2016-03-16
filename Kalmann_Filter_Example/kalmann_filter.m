function [X_E] = kalmann_filter(y,u,G,T,Te,L,x1_0,p1_0,q)
%% This function is used to prepare the kalmann filter


x=x1_0;
P=p1_0;

X_E = zeros(2, length(u));

A = [0 1; 0 -1/T];
B =  [0;G/T];
C = [1 0];
D = [0];


R = (2*pi/L)^2/12;

system=ss(A,B,C,D);
sysd=c2d(system,Te,'zoh');
[Ad,Bd,Cd,Dd]= ssdata(sysd);
H = Cd;
for i = 1 : length(u)
%% State prediction
%% Observation Prediction
y_e = H*x;

Cyy = H*P*H' + R;
Cxy = P*H';


%%  Compute Kalman Gain
K = Cxy*inv(Cyy);

%% Update the state estimate with Measurement 
x_e = x + K*(y(i)-y_e);
X_E(:,i) = x_e;

%% Update the error in co-variance 
p_e = P - K*H*P;

%%state Prediction
x = Ad*x_e + Bd*u(i);
P  =  Ad*p_e*Ad' +  Bd'*q*Bd;


end

end

