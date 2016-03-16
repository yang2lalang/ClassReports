clear all;
close all;
clc;

%% Discretise the Angles for a sweep
step = 0.05;   
q_1 = sin([0:step:3*pi]);
N = size(q_1,2);

mass = 2;
l = 3;
g = 9.8;
%% Cartesian Position
x = l * sin(q_1);
y = l * cos(q_1);

%% Calculate the Cartesian Velocity
xd = (x(2:end)-x(1,end-1))/(2*step);
yd = (y(2:end)-y(1,end-1))/(2*step);

%% Calculate the Cartesian Acceleration
xdd = (x(5:end)-2*x(3:end-2)+x(1:end-4))/(4*step^2);
ydd= (y(5:end)-2*y(3:end-2)+y(1:end-4))/(4*step^2);

%% Calculate the joint velocity
q_d = (q_1(2:end)-q_1(1,end-1))/(2*step);
%% Calculate the Joint Acceleration
q_dd = (q_1(5:end)-2*q_1(3:end-2)+q_1(1:end-4))/(4*step^2);

e = length(l);

F2x(e,1)=0;
F2y(e,1)=0;

for tt = 1:N-5

x1=x(1,tt);
y1=y(1,tt);
  
%%%Animating the movement of the single inverted pendulum
figure(1)
subplot(3,3,[1,4]);
plot(0,0, 'ro')
hold on
plot ([0,x1],[0,y1], 'g','LineWidth',4); 
hold off
ylabel('y')
xlabel('x')
title('Single Inverted Pendulum')
axis([-4 4 -4 4])

if (tt>5)  %%% Because acceleration values are available only from time step 5 onwards

%%%Calculating the reaction force and torque    
    
[F1x,F1y,Tau,F2x,F2y]=calculation(mass,l,xdd(tt),ydd(tt),q_dd(tt),0,0,q_1(tt),e);



%%%%Storing the values of reaction forces and torque

Rx(tt,1)=F1x(1,1);
Ry(tt,1)=F1y(1,1);
torque(tt,1)=Tau(1,1);


%%%%%%Plotting the graphs

subplot(3,3,2), plot(xdd,'b');
xlabel('t')
ylabel('x_dd')
title('plotting the X_Component of Cartesian Velocity');
subplot(3,3,5), plot(ydd,''), 
xlabel('t')
ylabel('y_dd')
title('plotting the Y_Component of Cartesian Velocity');
subplot(3,3,3), plot(Rx(6:end,:),'b'), title('Rx');
xlabel('t')
ylabel('Rx')
title('plotting the X_Component of Reaction forces');
subplot(3,3,6), plot(Ry(6:end,:),'b'), 
xlabel('t')
ylabel('Ry')
title('plotting the Y_Component of Reaction Forces')
subplot(3,3,8), plot(torque(6:end,:),'b');
xlabel('t')
ylabel('tau')
title('plotting the Torque')
end
pause(0.005);
end

