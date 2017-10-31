clc; 
clear; 
close all;


x = load('q2x.dat');
y = load('q2y.dat');

x = normalize(x);

tic();

% // m : No. of training sets
% // n : No. of features/attributes
m = length(x); 		% OR by size(x,2)
n = length(x(1,:)); % OR by size(x,2)
X = [ones(m,1),x];

%fprintf('Yo man !!!');

theta = zeros(n+1,1);
thetax = ones(n+1,1);

%display(theta);

% //while ( sum( (theta - thetax).^2 ) > 0.001 )  %// also check by Delta_L(theta) == 0 or not
while (  (theta - thetax)'*(theta - thetax)  > 0.000001 ) 
	
	xx = sigmoid(X*theta);

	% Delta_L(theta)
	Delta_L = X' * (y - xx); 

	% H : Hessian(theta)
	H = zeros(n+1, n+1);
	for i = 1:m
		xi = xx(i,1);
		H = H - sigmoid(xi)*(1-sigmoid(xi))*(X(i,:)'*X(i,:)); 
	end	

	% UPdating theta using the Hessian and Delta
	thetax = theta;
	theta = theta - inv(H)*Delta_L;


end	

disp('Theta is ');
display(theta);


% ////////////////////////// part (b)

X1 = [];
X2 = [];
Y1 = [];
Y2 = [];

% Computing row vectors from given data for plotting
for i = 1:m
	if (y(i) == 0)
		X1 = [X1 X(i,2)];
		Y1 = [Y1 X(i,3)];
	else
		X2 = [X2 X(i,2)];
		Y2 = [Y2 X(i,3)];
	end	
end


toc();

figure(1);
hold on;

% The two types of points differentiated by circle and star
plot(X1, Y1, 'ro');		
plot(X2, Y2, 'c*');	


% Now plotting the decision boundary on the graph
minx = floor(min(min(x)))
maxx = ceil(max(max(x)))
Xg = minx:0.01:maxx;
Yg = (- theta(1) - theta(2)*Xg)/(theta(3));
plot(Xg, Yg);


xlabel('X-axis'); 	%X-axis label
ylabel('Y-axis'); 	%Y-axis label

legend('y(i)=0    ', 'y(i)=1    ', 'Boundary '); %Legends 
title('Q3(b)'); 							%Plot title
hold off;



