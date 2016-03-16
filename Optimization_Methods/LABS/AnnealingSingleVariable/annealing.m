x =6;
Xopt=x; fopt=FuncAnnealing(Xopt); iter=0;
MaxIter = 5000;
Eps = 0.1;
T = 200;
Tf = 10;
while T>Tf
    while iter < MaxIter
        iter = iter+1;
        %find y close to x
        a = x - Eps; b = x + Eps;
        y = a + (a - b)*rand;
        Fx=FuncAnnealing(x);
        Fy=FuncAnnealing(y);
       
        delta=Fy-Fx;
        if delta<0 
            x = y;
            if Fx<fopt
                Xopt= y, fopt = Fy;
                               
                plot(Xopt,fopt,'*g')
                hold on;
            else
                p = rand; % p = probability
                if p < exp(-delta/T)
                    x = y;
                end
            end
        end
    end
    T = T/2;
end


x
iter 