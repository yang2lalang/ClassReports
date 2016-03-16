function [u] = inputvoltage(D1,A1,Delta,Te)
t=0:Te:D1;
f = 1/Delta;
u = A1*0.5*(square(2*pi*f*t));
% axis([0 0.1 -0.1 0.1]);
plot(t,u);
 ylabel('Input Voltage')
 xlabel('Time in secs')
  title('Input Voltage to the DC Motor')
u = u';
end

