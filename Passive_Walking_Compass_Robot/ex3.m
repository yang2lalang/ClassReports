%HUMRO Lab Report By Antoine MARTIN and Franklin OKOLI
%% Exercise 1
%Variables 
syms l s m I g real
syms q1 q2 qd1 qd2 x y xd yd theta real

%Coordinates
%We define the position vector of the center of mass of each leg without
%implicit constraint 
syms G1 G2 real
G1 = [x ; y]-s*[-sin(q1) ; cos(q1)];
G2 = [x ; y]+s*[-sin(q1+q2) ; cos(q1+q2)];


%intermedial variable
syms pos vel
pos = [q1 q2 x y];
vel = [qd1 qd2 xd yd];

%Velocities
%The velocity is obtained by performing a time derivative of the position
syms vG1 vG2 real
vG1 = jacobian(G1,pos')*vel';
vG2 = jacobian(G2,pos')*vel';

%Angular velocities 
%The angular velocity corresponds to a time derivative of the joint angles 
syms w1 w2 real
w1 = qd1;
w2 = qd1 + qd2;

%Kinetic energy
%We obtain the total kinetic energy of the body 
syms Ec1 Ec2 Ec real
Ec1 = 1/2*(m*vG1'*vG1+I*w1*w1);
Ec2 = 1/2*(m*vG2'*vG2+I*w2*w2);
Ec = Ec1+Ec2;

%The inertia matrix is deduced by factorizing the Kinetic Energy
%We derivate the Kinetic Energy twice by qd1/2 to isolate the terms of the
%inertia matrix
A1 = simplify(jacobian(Ec,vel));
A1 = simplify(jacobian(A1,vel))


%compute Jr
Point = [x ; y]+l*[-sin(q1+q2) ; cos(q1+q2)];
Jr = simplify(jacobian(Point,pos))
