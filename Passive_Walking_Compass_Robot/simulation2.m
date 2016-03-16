function [  ] = simulation( t,z,ze )
%SIMULATION Summary of this function goes here
%   Detailed explanation goes here
global l theta
R = [cos(theta) sin(theta);-sin(theta) cos(theta)];
%R = [1 0;0 1]
for i = 1:length(t)
   clf(figure(1))
   p1 = R*[ze(1),ze(2)]';
   p2 = R*[ze(1),0]'+l*R*[-sin(z(i,1)) ; cos(z(i,1))];
   p3 = R*[ze(1),0]'+l*R*[-sin(z(i,1)) ; cos(z(i,1))]+l*R*[-sin(z(i,1)+z(i,2)) ; cos(z(i,1)+z(i,2))];
   figure (1)
   axis([-0.3 0.9 -0.2 1])
   line([p1(1) p2(1)],[p1(2) p2(2)],'Color','b','LineWidth',1)
   line([p2(1) p3(1)],[p2(2) p3(2)],'Color','r','LineWidth',1)
   %hold on  
   pause(0.2);
   
end


end

