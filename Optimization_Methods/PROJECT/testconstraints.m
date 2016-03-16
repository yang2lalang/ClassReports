function [ G, Geq] = testconstraints(X0,params)
%% Constraints function
%% This function read obstacles 
%% ensures that points chosen for the path do not intersect or lie on Obstacles
    Y = params{1};
    circlec = params{2};
 

CC = circlec(:,[1,2]);
CR = circlec(:,3);
n = size(Y,1);
m = size(circlec,1);

G = [];
Geq = [];
   

for i = 1:n
    for j = 1:m
        G = [G; CR(j) - norm(Y(i,:)-CC(j,:))];
    end
end

% Line segment connecting points does not intersect obstacle
for i=1:n-1
    for j=1:m
        a = Y(i+1,:) - Y(i,:); %% Norm between the segments
        a_length = norm(a);
        a = a/norm(a);
        b = CC(j,:) - Y(i,:);
        b1 = a*b';
        b2 = b - b1*a;
        b2 = norm(b2);
        G = [Geq; min([b1,a_length - b1, CR(j)-b2 ]) ];
    end
end
for i=2:3
    G = [G; min([(Y(i,1)-20),(Y(i,2)-25),(25-Y(i,1)),(15-Y(i,2))])];
end
        
    
end
