function [ f ] = objective(X0,params)

%% objective function which is to be minimised 
%% Objective is minimum distance along the path

Y = params{1};
start = Y(1,:);
goal = Y(4,:);
f = pdist([start;X0;goal],'euclidean');
f = squareform(f);
f = [f(1,2) f(2,3) f(3,4) ];
f = sum(f);

end



