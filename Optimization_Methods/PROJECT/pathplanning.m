clc
close all
clear all
dbstop if error

%% Create Figure
figure
rect1 = [0 0 50 50];
rectangle('Position',rect1);
%% Rectangle Obstacles
hold on
rect2 = [20 0 5 15];
rectangle('Position',rect2);
rect2c = rectToPolygon(rect2);
hold on
rect3 = [20 25 5 25];
rectangle('Position',rect3);
rect3c = rectToPolygon(rect3);
rectc = [rect2c;rect3c];
hold on
%% Circle Obstacles
circle1 = [8 15 4];
circle2 = [40 5 4];
circle3 = [12 30 5];
circle4 = [5 40 4];
circle5 = [35 40 4];
circle6 = [40 30 6];
circle7 = [32 15 2];
circle8 = [32 20 2];
circlec = [circle1;circle2;circle3;circle4;circle5;circle6;circle7;circle8];

circle1 = circleToPolygon(circle1,99);
circle2 = circleToPolygon(circle2,99);
circle3 = circleToPolygon(circle3,99);
circle4 = circleToPolygon(circle4,99);
circle5 = circleToPolygon(circle5,99);
circle6 = circleToPolygon(circle6,99);
circle7 = circleToPolygon(circle7,99);
circle8 = circleToPolygon(circle8,99);
drawPolygon(circle1)
drawPolygon(circle2)
drawPolygon(circle3)
drawPolygon(circle4)
drawPolygon(circle5)
drawPolygon(circle6)
drawPolygon(circle7)
drawPolygon(circle8)
hold on

%%Defining the Initial  guess of  Points
start = [5,5];
p1 = [10,10];
p2 = [15,15];
p3 = [20,20];
p4 = [32,17];
p5 = [40,15];
p6 = [45,15];
final =[49,2];
Y = [start;p1;p2;p3;p4;p5;p6;final];
X0 = [p1;p2;p3;p4;p5;p6];

point1 = plot(5,5,'g*');
point2 = plot(20,20,'g*');
point3 = plot(45,15,'g*');
point4 = plot(49,2,'g*');
point5 = plot(15,15,'g*');
point6 = plot(10,10,'g*');
point7 = plot(32,17,'g*');
point8 = plot(40,15,'g*');

UB = zeros((size(X0,1)),2);
for i = 1:(size(X0,1))
    for j = 1:(size(X0,2))
    UB(i,j) = X0(i,j)+2;
    end
end
LB = zeros((size(X0,1)),2);
for i = 1:(size(X0,1))
    for j = 1:(size(X0,2))
    LB(i,j) = X0(i,j)-2;
    end
end

line1 = plot(Y(1:2,1),Y(1:2,2),'r');
line2 = plot(Y(2:3,1),Y(2:3,2),'r');
line3 = plot(Y(3:4,1),Y(3:4,2),'r');
line4 = plot(Y(4:5,1),Y(4:5,2),'r');
line5 = plot(Y(5:6,1),Y(5:6,2),'r');
line6 = plot(Y(6:7,1),Y(6:7,2),'r');
line7 = plot(Y(7:8,1),Y(7:8,2),'r');


hold on
params = {Y,circlec,rectc};
options = ['fmincon','Algorithm','active-set'];
path = fmincon(@objective,X0,[],[],[],[],LB,UB,@testconstraints,options,params);

line8 = plot([Y(1,1),path(1,1)],[Y(1,2),path(1,2)],'y');
line9 = plot(path(1:6,1),path(1:6,2),'y');
line10 = plot([Y(8,1),path(6,1)],[Y(8,2),path(6,2)],'y');

point9 = plot(path(1,1),path(1,2),'b*');
point10 = plot(path(2,1),path(2,2),'b*');
point11 = plot(path(3,1),path(3,2),'b*');
point12 = plot(path(4,1),path(4,2),'b*');
point13 = plot(path(5,1),path(5,2),'b*');
point14 = plot(path(6,1),path(6,2),'b*');






















