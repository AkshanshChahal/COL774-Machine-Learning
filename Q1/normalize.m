function XX = normalize(X)

m = size(X,1);
mean = sum(X)/m;
r = repmat(mean, m, 1);				% mean ready
temp = sqrt((1/m)*sum((X-r).^2));	% variance ready 
p = repmat(temp, m, 1);								
XX = (X-r)./p;		% Normalised

end 