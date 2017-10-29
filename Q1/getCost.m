function J = getCost(X, y, theta)

m = length(y);
J = 0;

Z = X*theta - y;
Z = Z.^2;

J = (1/(2*m)) * sum(Z); 


end