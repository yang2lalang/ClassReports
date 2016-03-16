X=[9 9];
Xopt=X;
fopt = FuncAnnealing(Xopt(1),Xopt(2));
Iter = 0;

clf;
hold on
%plot  the contour
x1=[-10:0.1:10]; x2=[-10:0.1:10];
[X1, X2]=meshgrid(x1,x2);

figure(1);clf; figure(1);  hold on;
contour(X1,X2,FuncAnnealing(X1,X2))

plot(X(1),X(2),'*r') ;


MaxIter = 5000;
Eps = [0.02,0.02];
T = 500;
Tf = 15;
while T>Tf
    while Iter < MaxIter
        Iter = Iter+1;
        %find y close to x
        a = X - Eps; b = X + Eps;
        Y(1) = a(1) + (a(1) - b(1))*rand;
        Y(2) = a(2) + (a(2) - b(2))*rand;
        Fx=FuncAnnealing(X(1),X(2));
        Fy=FuncAnnealing(Y(1),Y(2));
        delta=Fy-Fx; 
        if delta<0 
            X = Y;
            if Fx<fopt
                Xopt= Y;
                fopt = Fy;
                plot(Xopt(1),Xopt(2),'*g')
            else
                p = rand; % p = probability
                if p < exp(-delta/T)
                    X = Y ;
                end
            end
        end
    end
    T = T/2; iter=0;
end  
figure(1); plot(X(1),X(2),'*r')
title('Plot of the path of the Function')
xlabel('x1');
ylabel('x2');

[x1,x2]=meshgrid([-10:0.1:10]);

figure(2) ;clf; figure(2)
v = 3+x1*x2-x1+2*x2;
F =(X(1)-2).^2+(X(2)-2).^2
contour(x1,x2,v)


X

