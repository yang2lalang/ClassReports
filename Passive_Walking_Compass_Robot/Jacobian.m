function [ J ] = Jacobian( X )
%JACOBIAN Summary of this function goes here
%   Detailed explanation goes here
J = zeros(3,3);
Jp = zeros(3,3);
Jm = zeros(3,3);



[~,~,Jp(:,1)] = poincar(X+[0.5e-4; 0; 0]);
[~,~,Jp(:,2)] = poincar(X+[0; 0.5e-3; 0]);
[~,~,Jp(:,3)] = poincar(X+[0; 0; 0.5e-3]);


[~,~,Jm(:,1)] = poincar(X-[0.5e-4; 0; 0]);
[~,~,Jm(:,2)] = poincar(X-[0; 0.5e-3; 0]);
[~,~,Jm(:,3)] = poincar(X-[0; 0; 0.5e-3]);

J(:,1) = (Jp(:,1)-Jm(:,1))/(2*0.5e-4);
J(:,2) = (Jp(:,2)-Jm(:,2))/(2*0.5e-3);
J(:,3) = (Jp(:,3)-Jm(:,3))/(2*0.5e-3);
end

