%HUMRO Lab Report By Antoine MARTIN and Franklin OKOLI
%% Exercise 1
%Variables 
syms l s m I g real
syms q1 q2 qd1 qd2 theta real

%Coordinates
%We define the position vector of the center of mass of each leg 
syms G1 G2 real
G1 = (l-s)*[-sin(q1) ; cos(q1)];
G2 = l*[-sin(q1) ; cos(q1)]+s*[-sin(q1+q2) ; cos(q1+q2)];

%Velocities
%The velocity is obtained by performing a time derivative of the position
syms vG1 vG2 real
vG1 = jacobian(G1,[q1 q2]')*[qd1 qd2]';
vG2 = jacobian(G2,[q1 q2]')*[qd1 qd2]';

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
A = simplify(jacobian(Ec,[qd1 qd2]));
A = simplify(jacobian(A,[qd1 qd2]))

%We calculate the potential energy of the robot to get the gravity effect
syms U1 U2 Q
U1 = m*g*[-sin(theta) cos(theta)]*G1;
U2 = m*g*[-sin(theta) cos(theta)]*G2;
Q = simplify(jacobian([U1+U2],[q1 q2])');

%Then we create matrix H with the previous results
syms B C H
B(1,1) = jacobian(A(1,1),q2)+jacobian(A(1,2),q1)-jacobian(A(1,2),q1);
B(2,1) = jacobian(A(2,1),q2)+jacobian(A(2,2),q1)-jacobian(A(1,2),q2);

C(1,1) = jacobian(A(1,1),q1)-1/2*jacobian(A(1,1),q1);
C(1,2) = jacobian(A(1,2),q2)-1/2*jacobian(A(2,2),q1);
C(2,1) = jacobian(A(2,1),q1)-1/2*jacobian(A(1,1),q2);
C(2,2) = jacobian(A(2,2),q2)-1/2*jacobian(A(2,2),q2);

H = B*qd1*qd2+C*[qd1^2 qd2^2]'+Q

%% Exercise 2
%Acceleration
%The accelerations are computed by derivating the velocity of the legs 
syms aG1 aG2 qdd1 qdd2 real
aG1 = jacobian(vG1,[q1 q2]')*[qd1 qd2]'+jacobian(vG1,[qd1 qd2]')*[qdd1 qdd2]';
aG2 = jacobian(vG2,[q1 q2]')*[qd1 qd2]'+jacobian(vG2,[qd1 qd2]')*[qdd1 qdd2]';

%Force
%We can now deduce the reaction force needed on the floor 
syms F
F = simplify(m*(aG1+aG2)-m*g*[-sin(theta) cos(theta)]')