function g = sigmoid(z)
	
% This function returns the same matrix back after calculating sigmoid of each element of the matrix individually
g = zeros(size(z));
g = 1 ./ (1 + exp(-z));

end