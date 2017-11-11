function J = distortion(x,c,centroids)

	J = 0;
	b = 1;
	for i = 1:size(x,1)
		b = c(i);
		e = sum( ( x(i,:) - centroids(b,:) ) .^ 2) ;
		J = J + e;
	end

end