function [ zdot ] = SS_passif( t,z )
%SS_PASSIF Summary of this function goes here
%   Detailed explanation goes here
global l m I s theta g
zdot = [z(3), z(4), ((m*s^2 + I)*(l*m*s*sin(z(2))*z(4)^2 + 2*l*m*z(3)*s*sin(z(2))*z(4) + g*m*(s*sin(z(1) + z(2) - theta) + 2*l*sin(z(1) - theta) - s*sin(z(1) - theta))))/(I^2 + m^2*s^4 - 2*l*m^2*s^3 + 2*l^2*m^2*s^2 + 2*I*l^2*m + 2*I*m*s^2 - 2*I*l*m*s - l^2*m^2*s^2*cos(z(2))^2) - ((- l*m*s*sin(z(2))*z(3)^2 + g*m*s*sin(z(1) + z(2) - theta))*(m*s^2 + l*m*cos(z(2))*s + I))/(I^2 + m^2*s^4 - 2*l*m^2*s^3 + 2*l^2*m^2*s^2 + 2*I*l^2*m + 2*I*m*s^2 - 2*I*l*m*s - l^2*m^2*s^2*cos(z(2))^2) ,(2*(- l*m*s*sin(z(2))*z(3)^2 + g*m*s*sin(z(1) + z(2) - theta))*(I + l^2*m + m*s^2 - l*m*s + l*m*s*cos(z(2))))/(I^2 + m^2*s^4 - 2*l*m^2*s^3 + 2*l^2*m^2*s^2 + 2*I*l^2*m + 2*I*m*s^2 - 2*I*l*m*s - l^2*m^2*s^2*cos(z(2))^2) - ((m*s^2 + l*m*cos(z(2))*s + I)*(l*m*s*sin(z(2))*z(4)^2 + 2*l*m*z(3)*s*sin(z(2))*z(4) + g*m*(s*sin(z(1) + z(2) - theta) + 2*l*sin(z(1) - theta) - s*sin(z(1) - theta))))/(I^2 + m^2*s^4 - 2*l*m^2*s^3 + 2*l^2*m^2*s^2 + 2*I*l^2*m + 2*I*m*s^2 - 2*I*l*m*s - l^2*m^2*s^2*cos(z(2))^2)]';
 

end

