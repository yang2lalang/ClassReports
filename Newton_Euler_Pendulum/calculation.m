function [F1x,F1y,tau,F2x,F2y]=calculation(mass,l,xdd,ydd,q_dd,F2x,F2y,q_joint,N)
g=9.81;
for t = N:-1:1
%% Calculting the forces and torques for a each link 
qdd=sum(q_dd(1:t));
q = sum(q_joint(1:t));
F1y(t,1)=(mass(t,1)*ydd(t,1)-F2y(t,1) + mass(t,1)*g);
F1x(t,1)=(mass(t,1)*xdd(t,1)-F2x(t,1));
tau(t,1) = -mass(t,1)*l(t,1)^2*qdd-mass(t,1)*l(t,1)*g*sin(q);
if t>1
    F2x(t-1,1)=-F1x(t,1);
    F2y(t-1,1)=-F1y(t,1);
end

end

end
