clc; 
clear; 
close all;

x = load('q4x.dat');

% // m : No. of training sets
% // n : No. of features/attributes
m = length(x); 		% OR by size(x,2)
n = length(x(1,:)); % OR by size(x,2)

fileID = fopen('q4y.dat','r');

% Preparing the boolean vector Y from data of Alaska and Canada
y = zeros(m,1);
for i = 1:m
	if(strcmp(sscanf(fgetl(fileID), '%s'), 'Alaska'))
		y(i,1) = 1;
	else
		y(i,1) = 0;
	end
end
fclose(fileID);

x = normalize(x);

tic();

yi1 = y == 1;
yi0 = y == 0;

X = x;

% Preparing intermediate me=atrices to compute mean0 and mean1 matrices !
y1 = repmat(yi1,1,n);		% y1,y0 is m*(n), same as X
y0 = repmat(yi0,1,n);

u1 =  ( 1/sum(yi1) )*(sum( X.*y1 ))';  	% mean1
u0 =  ( 1/sum(yi0) )*(sum( X.*y0 ))'; 	% mean0


% Now preparing intermediate matrices for Sigma matrixl
r1 = repmat(u1',m,1);
r0 = repmat(u0',m,1);

t1 = (X - r1).*y1;
t0 = (X - r0).*y0;

t = t1 + t0;

sigma = zeros(n,n);

for i = 1:m
	sigma = sigma + t(i,:)'*t(i,:);		
end

sigma = (1/m)*sigma;

disp('mean1 is');
disp(u1);
disp('');
disp('');
disp('mean0 is');
disp(u0);
disp('');
disp('');
disp('Sigma = Sigma0 = Sigma1 is');
disp(sigma);
disp('');
disp('');

% ////////////////////// part (b)


X1 = [];
X2 = [];
Y1 = [];
Y2 = [];

% Preparing row vectors for plotting the data
for i = 1:m
	if (y(i) == 1)
		X1 = [ X1 X(i,1)];
		Y1 = [ Y1 X(i,2)];
	else
		X2 = [ X2 X(i,1)];
		Y2 = [ Y2 X(i,2)];
	end	
end




figure(1);
hold on;

plot(X1, Y1, 'r+');	
plot(X2, Y2, 'co');	

xlabel('X-axis'); 	%X-axis label
ylabel('Y-axis'); 	%Y-axis label

title('Gradient Discriminant Analysis'); 								%Plot title
%hold off;



% ////////////////////// part (c)
% Decisoin boundary general form :-
% th0 + th1*x1 + th2*x2 = 0 

% CASE of same covariance matrices

sv = inv(sigma);
t1 = sv*(u0-u1);
t2 = (u0'-u1')*sv;

phi = (1/m)*sum(yi1);

% Calculating the coefficients of the equation of the decision boundary
theta0 = u1'*sv*u1 - u0'*sv*u0 - 2*log(phi/(1-phi));
theta1 = t1(1,1) + t2(1,1);
theta2 = t1(2,1) + t2(1,2);

% Plotting the decision boundary
minx = floor(min(min(x(:,1))));
maxx = ceil(max(max(x(:,1))));
Xg = minx:0.01:maxx;
Yg = (- theta0 - theta1*Xg)/theta2;
plot(Xg, Yg);


% ////////////////////// part (d)

% CASE of different covariance matrices
sigma1 = zeros(n,n);
sigma0 = zeros(n,n);

for i = 1:m
	sigma1 = sigma1 + yi1(i,1)*(t(i,:)'*t(i,:));		
	sigma0 = sigma0 + yi0(i,1)*(t(i,:)'*t(i,:));		
end

% Calculating the sigma0 and sigma1 matrices;
sigma1 = (1/sum(yi1))*sigma1;
sigma0 = (1/sum(yi0))*sigma0;


disp('Sigma1 is ');
disp(sigma1);
disp('');
disp('');
disp('Sigma0 is ');
disp(sigma0);
disp('');



% ////////////////////// part (e)

% Ranges for the meshgrid points
min1 = floor(min(min(x(:,1))));
max1 = ceil(max(max(x(:,1))));

min2 = floor(min(min(x(:,2))));
max2 = ceil(max(max(x(:,2))));

stepp = 0.05; % The step bw 2 points in meshgrid
[p,q] = meshgrid(min1:stepp:max1, min2:stepp:max2);

f = zeros((max1-min1)/stepp,(max2-min2)/stepp);

% Evaluating function f on each point of meshgrid
for i = 1:(max1-min1)/stepp
	for j = 1:(max2-min2)/stepp
		v = [p(i,j);q(i,j)];
		f(i,j) = (v-u1)'*inv(sigma1)*(v-u1) - (v-u0)'*inv(sigma0)*(v-u0); 
	end	
end	

% Equating function f to value v
% This equation bw f and v is the equation of the decision boundary in the case of unequal covariances 
v = log(abs(det(sigma1)/det(sigma0))) + 2*log(phi/(1-phi)) ;

% Plotting the decision boundary
contour(p,q,f,[v v],'g');

toc();

legend('Alaska  ', 'Canada    ', 'Sigma0 = Sigma1 '); %Legends 




