clc; 
clear; 
close all;

x = load('q3x.dat');
y = load('q3y.dat');

tic();

x = normalize(x);

m = length(x); 	% No. of training sets
X = [ones(m,1),x];


%///////////////////////////////////////////////// (a) part

theta = (inv(X'*X))*X'*y; 	% Formula for the parameters to minimize cost function

disp('Theta is ');
disp(theta);

figure(1);
hold on;

plot(x, y, 'r.');	%// plot(x, y, 'rx', 'MarkerSize', 10);
plot(x, X*theta);

xlabel('X-axis'); 	%X-axis label
ylabel('Y-axis'); 	%Y-axis label

legend('Learning Data', 'Hypothesis Func'); %Legends 
title('Q2(a)'); 							%Plot title
hold off;



%//////////////////////////////////////////////// (b & c) part

%bandwidth = 0.8;

p = plot4me(X,y,0.8);
p = plot4me(X,y,0.1);
p = plot4me(X,y,0.3);
p = plot4me(X,y,2);
p = plot4me(X,y,10);


toc();





