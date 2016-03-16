%robot/slope caracteristics
global I s
g = 9.81;
theta = 3*pi/180;
l = 0.8;
m = 2;
options = optimset('display','iter','MaxFunEvals',1000,'TolX',1.0e-010,'TolFun',1.0e-006);

%% case 1
I = 0.1;
s = 0.5;
nb_of_steps = 30;
P = zeros(nb_of_steps,3);

X0 = [-0.1860+2*pi; -2.0504; -0.0428];
X = fsolve('test_periodic',X0,options);
J1 = Jacobian(X)
[V1] = eig(J1)

for i =1:nb_of_steps
    [t,z,X] = poincar(X); 
    figure(1)
    
    subplot(2,1,1)
    plot (z(:,1),z(:,3), 'g')
    xlabel('q1dot');
    ylabel('q1');
    title('Phase Plan for Case 1 for first leg')
    hold on
    
    figure(1)
    subplot(2,1,2)
    plot (z(:,2),z(:,4),'r')
    xlabel('q2dot');
    ylabel('q2');
    title('Phase Plan for Case 1 for second leg')
    hold on
   end


%% case 2
I = 0.08;
s = 0.45;

X0 = [-0.1933+2*pi; -2.0262; -0.1253];
X = fsolve('test_periodic',X0,options);
J2 = Jacobian(X)
[V2] = eig(J2)

for i =1:nb_of_steps
    [t,z,X] = poincar(X); 
    figure(2)
    subplot(2,1,1)
    plot (z(:,1),z(:,3),'g')
    xlabel('q1dot');
    ylabel('q1');
    title('Phase Plan for Case 2 for first leg')
    hold on
    
    figure(2)
    subplot(2,1,2)
    plot (z(:,2),z(:,4),'r')
    xlabel('q2dot');
    ylabel('q2');
    title('Phase Plan for Case 2 for second leg')
    hold on
end


