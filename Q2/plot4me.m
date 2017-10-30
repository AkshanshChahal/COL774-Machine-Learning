function p = plot4me(X,y,bandwidth)

p = 0;	
x = X(:,2);	
minx = floor(min(min(x)));
maxx = ceil(max(max(x)));
m = length(y);


W = zeros(m);
Xb = minx:0.01:maxx ; 		% Will evaluate W on these points
Yb = [];
range = length(Xb);


for i = 1:range
	% Calculating the Weight Matrix
	for j = 1:m
		W(j,j) = exp( -((Xb(1,i) - x(j,1))^2) / (2*bandwidth*bandwidth) );
	end
	% Getting the output using the Weights and Theta
	theta = (inv(X'*W*X))*X'*W*y;
	Yb(i) = theta(1) + theta(2)*Xb(i);
end

figure();
hold on;

plot(x, y, 'r.');
plot(Xb, Yb);

xlabel('X-axis'); 	%X-axis label
ylabel('Y-axis'); 	%Y-axis label

legend('Learning Data', 'Learnt Func'); %Legends 
title(num2str(bandwidth)); 	%Plot title
hold off;



end