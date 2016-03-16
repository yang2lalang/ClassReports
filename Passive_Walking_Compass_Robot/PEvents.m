function [ VALUE, ISTERMINAL, DIRECTION ] = PEvents( t,z )
%% This function is used to test the integration 
%% to detect when an event occurs and therefore stop the integration.
%% Its returns parameters used by ode45, In this case they are scalars 
%% but we might decide to have more than one event
%% and in that case we use the vecotrial form

global l 
pos = l*[-sin(z(1)) ; cos(z(1))]+l*[-sin(z(1)+z(2)) ; cos(z(1)+z(2))];
VALUE(1)=0.5;
ISTERMINAL(1) = 1;
DIRECTION(1) =  0;

if pos(1) > 0.1
    VALUE(1) = pos(2);
end
end

