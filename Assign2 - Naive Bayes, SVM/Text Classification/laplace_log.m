function z = laplace_log(x, y)

% This function returns the value of probability after Laplace smoothing
% and taking log to avoid underflow 
modV = 23585;
z = log((x+1)/(y+modV));    % Can even hardcode the value of modV !

end