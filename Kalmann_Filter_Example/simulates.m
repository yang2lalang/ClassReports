function [y, X, Ad,Bd,Cd] = simulates(u,G,T,Te,L,x1)
x = x1
A = [0 1; 0 -1/T];
B =  [0;G/T];
C = [1 0];
D = [0];
system=ss(A,B,C,D);
sysd=c2d(system,Te,'zoh');
[Ad,Bd,Cd,Dd]= ssdata(sysd);
X = zeros(2, length(u));
y = zeros(1, length(u));
for i = 1 : length(u)
    y(i) = Cd*x;
    X(:,i) = x;
    x = Ad*x + Bd*u(i);
end
y = round(y*L/2/pi)*2*pi/L;
figure(6)
subplot(3,1,1)
plot(X(1,:));
 ylabel('theta')
 xlabel('Time in secs')
 title('State Model from The simulator')
 subplot(3,1,2)
plot(y);
 ylabel('y')
 xlabel('Time in secs')
  title('Measurement Model from The simulator')
 subplot(3,1,3)
  plot(X(2,:));
 ylabel('Omega')
 xlabel('Time in secs')
 title('State Model from The simulator')


end

