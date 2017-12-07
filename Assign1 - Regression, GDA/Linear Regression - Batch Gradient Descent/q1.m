clc; 
clear; 
close all;

x = load('q1x.dat');
y = load('q1y.dat');

x = normalize(x);

m = length(x); 			% No. of training sets
X = [ones(m,1),x];
thetax = zeros(2,1); 	%// zeros(size(X,2), 1);
eta = 0.1;				%// Learning rate
stopMargin = 0.0000001;

tic; % Start timer

%/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
%/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
% MESH GRAPH PLOT COMING !!
theta = thetax;

Ji = getCost(X, y, theta);
Jf = Ji;


[p,q] = meshgrid(-1:0.1:11.5);
points = length(p);

f = zeros(points, points);

% evaluating f or Cost at each point in the meshgrid
for i = 1:points
	for j = 1:points
		v = [p(i,j);q(i,j)];
		f(i,j) = (1/(2*m))*sum((X*v - y).^2);
	end	
end	

figure();
hold on;
mesh(p,q,f);
plot3(theta(1),theta(2), getCost(X, y, theta), '*k'); % Plotting the first point


while (true) 	
	
	pause(0.2);

	Z = X*theta - y;
	A = X'*Z;	
	theta = theta - (eta/m)*A; % One step of gradient descent evaluated

	% Plotting the point on the mesh 
	Jf = getCost(X, y, theta);
	plot3(theta(1),theta(2), Jf, '*k');

	% Checking for convergence
	if (abs(Jf - Ji) < stopMargin)
		break;
	end

	Ji = Jf;
	i++;	% No. of iterations
endwhile


hold off;



%/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
%/////////////////////////////////////////////////////////////////////////////////////////////////////////////////



fprintf(' No. of iterations : %d', i);
disp('\nTheta is');
disp(theta)
toc; % Stop timer



%//////////////////// (b) part
figure();
hold on;

plot(x, y, 'r.');	% Plotting the training data
plot(x, X*theta);	% Plotting the learnt function

xlabel('Area of the Houses'); 	%X-axis label
ylabel('Price'); 				%Y-axis label

legend('Learning Data', 'Hypothesis Function Learned');		%Legends 
title('Q1(b)'); 											%Plot title
hold off;



%/////////////////// (c) part
% CONTOUR GRAPH PLOT COMING !!



theta = thetax;

Ji = getCost(X, y, theta);
Jf = Ji;

figure();
hold on;

while (true) 	% // try for more smaller and larger values than 0.05
	
	Z = X*theta - y;
	A = X'*Z;

	v = getCost(X,y,theta);
	contour(p,q,f,[v v],'k');theta = theta - (eta/m)*A;
	pause(0.2);

	Jf = getCost(X, y, theta);

	if (abs(Jf - Ji) < stopMargin)
		break;
	end

	Ji = Jf;

endwhile

v = getCost(X,y,theta);
contour(p,q,f,[v v],'k');	

hold off;


