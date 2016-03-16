clear all;
close all;
clc;

%% Discretise the Angles for a sweep
step = 0.05;   
q_1 = sin([0:step:3*pi]);
q_2 = sin([0:step:3*pi]);
N = size(q_1,2);

%% Paremeters
mass1 = 2;
l1 = 3;
mass2 = 2;
l2 = 3;
g = 9.8;
mass = [mass1;mass2];
l = [l1;l2];

%% Cartesian Position to link 1
x1 = l1 * sin(q_1);
y1 = l1 * cos(q_1);

%% Cartesian point to end effector
x2 = l1*sin(q_1)+ l2*sin(q_1+q_2);
y2 = l1*cos(q_1)+ l2*cos(q_1+q_2);

%% Calculate the Cartesian Velocity by 
%% second order finite difference method 
xd1 = (x1(2:end)-x1(1,end-1))/(2*step);
yd1 = (y1(2:end)-y1(1,end-1))/(2*step);
xd2 = (x2(2:end)-x2(1,end-1))/(2*step);
yd2 = (y2(2:end)-y2(1,end-1))/(2*step);

%% Calculate the Cartesian Acceleration
xdd1 = (x1(5:end)-2*x1(3:end-2)+x1(1:end-4))/(4*step^2);
ydd1 = (y1(5:end)-2*y1(3:end-2)+y1(1:end-4))/(4*step^2);
xdd2 = (x2(5:end)-2*x2(3:end-2)+x2(1:end-4))/(4*step^2);
ydd2 = (y2(5:end)-2*y2(3:end-2)+y2(1:end-4))/(4*step^2);

%% Calculate the joint velocity
q_d1 = (q_1(2:end)-q_1(1,end-1))/(2*step);
q_d2 = (q_2(2:end)-q_2(1,end-1))/(2*step);
%% Calculate the Joint Acceleration
q_dd1 = (q_1(5:end)-2*q_1(3:end-2)+q_1(1:end-4))/(4*step^2);
q_dd2 = (q_2(5:end)-2*q_2(3:end-2)+q_2(1:end-4))/(4*step^2);
e = length(l);

F2x(e,1)=0;
F2y(e,1)=0;

for tt = 1:N-5

X1= x1(1,tt);
Y1= x1(1,tt);

X2= x2(1,tt);
Y2= x2(1,tt);


if (tt>5)  
xxdd1= xdd1(1,tt);
yydd1= ydd1(1,tt);

xxdd2 = xdd2(1,tt);
yydd2= ydd2(1,tt);

qdd1=q_dd1(1,tt);
qdd2=q_dd2(1,tt);

Ax=[xxdd1;xxdd2];
Ay=[yydd1;yydd2];
Aq=[qdd1;qdd2];

q_joint = [q_1(1,tt);q_2(1,tt)];
    
%%%Calculating the reaction force and torque    
    
[F1x,F1y,Tau,F2x,F2y] = calculation(mass,l,Ax,Ay,Aq,F2x,F2y,q_joint,e);

%%%%Storing the values of reaction forces and torque

Rx(tt,1)=F1x(1,1);
Ry(tt,1)=F1y(1,1);
torque(tt,1)=Tau(1,1);
Axx(tt,1) = xxdd2;
Ayy(tt,1) = yydd2;

%%%%%%Plotting the graphs
%%%Animating the movement of the DOUBLE inverted pendulum
figure(1)
subplot(3,3,[1,4]);
plot(0,0, 'ro')
hold on
plot(X1,Y1, 'ro')
plot ([0,X1],[0,Y1], 'g','LineWidth',4);
plot ([X1,X2],[Y1,Y2], 'cy','LineWidth',4);
hold off
ylabel('y')
xlabel('x')
title('Double Inverted Pendulum')
axis([-8 8 -8 8])

subplot(3,3,2), plot(Axx(6:end,:),'b');
xlabel('t')
ylabel('x_dd')
title('plotting the X_Component of Cartesian Acceleration');
subplot(3,3,5), plot(Ayy(6:end,:),''), 
xlabel('t')
ylabel('y_dd')
title('plotting the Y_Component of Cartesian Acceleration');
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

