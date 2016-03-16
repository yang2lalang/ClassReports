%%Script to run Kalman filter 
clear all
close all
clc
global A1 Te Delta D1 G T L q x1 x1_0 p1_0
A1 = 0.1;
Te =1*10^-3;
Delta = 100*10^-3;
D1 = 1;
G = 50;
T = 20*10^-3;
Tf = 25*10^-3;
L = 512;
q = 0.05;
x1 = [0;0];
x1_0 = [1.5;0];
p1_0 =  (2*pi)^2/12;
p1_0 = [p1_0 0;
     0 0]  
u = inputvoltage(D1,A1,Delta,Te);
[y, X, Ad,Bd,Cd] = simulates(u,G,T,Te,L,x1);
[X_E] = kalmann_filter(y,u,G,Tf,Te,L,x1_0,p1_0,q)
errortheta = X_E(1,:) - X(1,:)
 figure(2)
 subplot(2,1,1)
plot ((0:Te:D1),X_E(1,:),'r');
hold on 
plot ((0:Te:D1),X(1,:));
ylabel('theta_actual and theta_filter')
 xlabel('Time in secs')
 title('Comparing the state vector when we are using the Kalmann_filter ')
subplot(2,1,2)
plot ((0:Te:D1),errortheta); 
 ylabel('Error')
 xlabel('Time in secs')
 title('Comparing the Error when we are using the Kalmann_filter ')
[X_E2] = Stationary_Kalmann(y,u,G,Tf,Te,L,x1_0,p1_0,q);
figure(3)
 subplot(2,1,1)
plot ((0:Te:D1),X_E(1,:),'r');
hold on 
plot ((0:Te:D1),X(1,:));
ylabel('theta_actual and theta_filter')
 xlabel('Time in secs')
 title('Comparing the state vector when we are using the Stationary Kalmann_filter ')
errortheta2 = X_E2(1,:) - X(1,:);
 subplot(2,1,2)
plot ((0:Te:D1),errortheta2); 
ylabel('Error')
 xlabel('Time in secs')
 title('Comparing the Error when we are using the Stationary Kalmann_filter ')

