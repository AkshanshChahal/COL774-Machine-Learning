clc; 
clear; 
close all;



x = load('attr.txt');
y = load('label.txt');

m = length(y)
n = size(x,2)
k = 6;


% c = zeros(m,1);
% cc = zeros(m,1);
centroids = zeros(6,n);
% r = randi([1,m],6,1)

r = [ 9486; 4865; 5503; 8060; 424; 7863 ];


centroids(1:6,:) = x(r',:); 
% for i = 1:6
% 	centroids(i,:) = x(r(i,1),:);
% end

tic();
% ////////////////////////////////   EM Algorithm   /////////////////////////////////

t = zeros(6,1); % for E step
z = false(6,m); % for M step
% w = zeros(1,m) % for M step
% iter = 0;
yy = [];

for iter = 1:60
	% iter = iter + 1;
	% E Step  ////////////////////////////////////////////////////////////////
	for i = 1:m
		for j = 1:6
			t(j) = sum( (x(i,:) - centroids(j,:)) .^ 2 ); % sum returns sum of each collumn, unless its a row vector
		end
		[M,I] = min(t);
		c(i) = I(1);
	end

	% t

	% M Step  ////////////////////////////////////////////////////////////////

	for i = 1:6
		z(i,:) = c == i;
	end

	for i = 1:6
		% resize z(i) to m,n and then elemnt wise * with x
		w = repmat(z(i,:)', 1, n);
		w = w.*x;
		% size(w)
		% size(z(i,:))
		% p = sum(w);
		% size(p)
		centroids(i,:) = (1/sum(z(i,:)))* (sum(w));
	end


	% Check convergence with c or centroids
	% if ( sum((cc-c).^2) < 0.01 * m ) % 1 percent of m examples allowed to have errors = 1
	% 	break;
	% end

	% cc = c;

	yy = [yy distortion(x,c,centroids)];
end

% c
% centroids
iter

% yy = [ yy distortion(x,c,centroids)]

iter = 1:60;
figure();
hold on;

plot(iter, yy);

xlabel('Iterations'); 	%X-axis label
ylabel('Value of J'); 	%Y-axis label

% legend('Accuracies', 'Validations'); %Legends 
% title(num2str(bandwidth)); 	%Plot title
hold off;



toc();