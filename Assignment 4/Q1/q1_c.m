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
r = randi([1,m],6,1)

% r = [ 9486; 4865; 5503; 8060; 424; 7863 ];


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
yy = [];  % Accuracies

for iter = 1:60

	% E Step  ////////////////////////////////////////////////////////////////
	for i = 1:m
		for j = 1:6
			t(j) = sum( (x(i,:) - centroids(j,:)) .^ 2 ); % sum returns sum of each collumn, unless its a row vector
		end
		[M,I] = min(t);
		c(i) = I(1);
	end

	% M Step  ////////////////////////////////////////////////////////////////

	for i = 1:6
		z(i,:) = c == i;
	end

	for i = 1:6
		% resize z(i) to m,n and then elemnt wise * with x
		w = repmat(z(i,:)', 1, n);
		w = w.*x;
		centroids(i,:) = (1/sum(z(i,:)))* (sum(w));
	end


	% Calculating Accuracies
	acc = 0;
	count = zeros(6,6);  % To find max label for each cluster
	for i = 1:m
		count(c(i),y(i)) += 1;
	end
	total = 0;
	for i = 1:6
		[M,I] = max(count(i,:)');
		acc += count(i,I(1));
		total += sum(count(i,:)'); 
	end

	acc = acc/total;

	yy = [yy acc];
end


total

% c
% centroids
iter

yy

iter = 1:60;
figure();
hold on;

plot(iter, yy);

xlabel('Iterations'); 	%X-axis label
ylabel('Accuracies'); 	%Y-axis label

% legend('Accuracies', 'Validations'); %Legends 
% title(num2str(bandwidth)); 	%Plot title
hold off;



toc();