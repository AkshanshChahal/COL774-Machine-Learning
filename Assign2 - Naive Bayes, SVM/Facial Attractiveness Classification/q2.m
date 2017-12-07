clc; 
clear; 
close all;

tic();

x = load('traindata.txt');
size(x)

y = load('trainlabels.txt');
size(y)

m = length(y);
b = ones(1,m);
Q = zeros(m,m);

% Converting all 2 to -1 in labels
for i = 1:m
    if(y(i)==2)
        y(i) = -1;
    end
end


% Preparing matrices b, Q for the CVX package
for i=1:m
    for j=1:m
       Q(i,j) = y(i)*y(j)*x(i,:)*x(j,:)'; 
    end
end

Q = -(0.5)*Q;
% disp(Q(1,:));
z1 = zeros(m,1);
z2 = 500*ones(m,1);

cvx_begin
    variable a(m)
    maximize( b*a + quad_form(a,Q) )
    subject to
        z1 <= a
        a <= z2
        a'*y == 0
cvx_end

% CVX package returns the alpha vector after optimizing
% support vectors are the one with their alpha values > 0
support = a > 0.001;
% disp(a);
% disp(supportx);

% collecting the indexes for the support vectors
support_a = [];
for i = 1:m
   if(support(i))
       support_a = [support_a i];
   end
end
support_a = support_a';
disp(support_a);
SV = sum(support);
disp('Total number of support vectors are');
disp(SV);










% //////////////////////////////////////////////////////////////
% (b) part   

w = zeros(length(x),1);
% calculating w
for i = 1:m
   w = w + a(i)*y(i)*x(i,:)'; 
end

% disp(w);

% Calculating W'x matrix
v = w'*x';  
% size of v is [1 m]


% Calculating b
k = 16;
disp(a(k));

disp(k);
disp(y(k));
b = y(k) - v(k);

disp(b);

% Loading the test data
x = load('testdata.txt');
y = load('testlabels.txt');
v = w'*x';
v = v + b;

% disp(v);
% Classifying the test data
yx = zeros(length(y),1);
for i = 1:length(y)
    if(v(i) >= 0.0000000000000000)
       yx(i) = 1; 
    else
       yx(i) = 0;
    end
end


% Calculating the accuracy
s = 0;
for i = 1:length(y)
    if( (yx(i)==1 && y(i)==1) || (yx(i)==0 && y(i)==2) )
       s = s + 1; 
    end
end

disp((s/(length(y))*100));


%  /////////////////////////////////////////////////////////////////
%  part c 


x = load('traindata.txt');
y = load('trainlabels.txt');


m = length(y);
b = ones(1,m);
Q = zeros(m,m);


% Converting all 2 to -1 in labels
for i = 1:m
    if(y(i)==2)
        y(i) = -1;
    end
end

% Preparing Q for CVX package
for i=1:m
    for j=1:m
        xz = x(i,:)-x(j,:);
        xz = (xz.^2)';
        modx = sum(xz);
%         disp(modx);
        Q(i,j) = y(i)*y(j)* exp(-2.5 * modx ); 
    end
end

Q = -(0.5)*Q;
z1 = zeros(m,1);
z2 = 500*ones(m,1);

cvx_begin
    variable a(m)  
    maximize( b*a + quad_form(a,Q) )
    subject to
        z1 <= a
        a <= z2
        a'*y == 0
cvx_end

support = floor(a) > 0;
% disp(a);    % THIS TIME k = 4
% disp(support);

% Calculating the indexes for the support vectors
support_c = [];
for i = 1:m
   if(support(i))
       support_c = [support_c i];
   end
end
support_c = support_c';
disp(support_c);
SV = sum(support);
disp('Total number of support vectors are');
disp(SV);


% Prediction time
% Loading the test data
X = load('testdata.txt');
Y = load('testlabels.txt');

for i = 1:length(Y)
    if(Y(i)==2)
        Y(i) = -1;
    end
end

v = zeros(size(X,1),1);
% Computing the matrix for W'x using the gaussian kernel function
for i = 1:m
    xx = repmat(x(i,:),size(X,1),1) - X;
    xx = xx';
    modx = sum(xx.^2);
    v = v + a(i)*y(i)* exp( -2.5 * modx' );
end

% disp(v);

% Calculating b, by finding the alpha which is strictly bw 0 and C
k = 4; % cuz alpha(4) is the one which is >0 and <C !!
h = 0;
for i = 1:m
   xx = x(i,:) - x(k,:);  % I was using X(k,:) here !!!!!
   xx = (xx.^2)';
   modx = sum(xx);
   h = h + a(i)*y(i)* exp( -2.5 * modx );
end

b = y(k) - h;
disp(b);
v = v+b;
yx = zeros(length(Y),1);
% Classifying the test data 
for i = 1:length(Y)
    if(v(i) >= 0.0000000000000000)
       yx(i) = 1; 
    else
       yx(i) = 0;
    end
end


% calculating the accuracy
s = 0;
for i = 1:length(Y)
    if( (yx(i)==1 && Y(i)==1) || (yx(i)==0 && Y(i)==-1) )
       s = s + 1; 
    end
end

disp((s/(length(Y))*100));




%  /////////////////////////////////////////////////////////////////
%  part d
% In separate file


toc();