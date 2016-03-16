function[Xopt,F]=Dichotonous_multi(X0,a,b,eps)
L=b-a;
 d=[1 1];
while L>2*eps
    alpha1=a+(L-eps)/2;
    alpha2=a+(L+eps)/2;
    
    X1 = X0+alpha1*d ;
    X2 = X0+alpha2*d;  

    if multiF(X1)<multiF(X2)
        b=alpha2;
    else
        a=alpha1;
    end
    L=b-a;
end
Xopt=(X1+X2)/2
F=multiF(Xopt)
end