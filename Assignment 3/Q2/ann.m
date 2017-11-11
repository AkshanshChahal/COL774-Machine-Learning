clc;clear;close all;

m = 50000;
fileID = fopen('train.data','r');
x = ones(m,126); % Add First collumn as all ones i.e. x0
y = zeros(m,3);

for i = 1:m
   C = strsplit(sscanf(fgetl(fileID), '%c'),',');
   n = size(C);
   for j = 1:n(1,2)-1
       x(i,j) = str2double(cell2mat(C(1,j)));
   end
   if strcmp('win', C(1,n(1,2)))
       y(i,1) = 1;
   elseif strcmp('loss', C(1,n(1,2)))
       y(i,2) = 1;
   elseif strcmp('draw', C(1,n(1,2)))
       y(i,3) = 1;
   end
end

disp('Data Read');
x = [ones(m,1) x];

units = 100;

theta1 = randn(units, 127);
theta2 = randn(3,units+1);

% disp(theta1)
% disp(theta2)

% Jf = getCost(m,theta1,theta2,x,y);
Ji = 0;
eta = 0.1;
iter = 0;
d = 0.001;
b = 0;

tic();
while (true)
    iter = iter + 1;
    for i = 1:m
        
        a = [1 ; sigmoid(theta1*x(i,:)')]; % 101*1 (oj for 2nd layer)
        o = sigmoid(theta2*a); % 3*1
        
        z = -(y(i,:)' - o) .* o .* (1 - o); % 3*1
        gradient2 = z * a'; % (3*1) * (1*101)
        
        % 100*127 =  ( (1*3) * (3*100) )   .*  ( 100*1 )
        gradient1 = (z' * theta2(:,2:units+1))' .* a(2:units+1) .* (1 - a(2:units+1)); % 100*1
        gradient1 = gradient1 * x(i,:);
        
%         eta = 0.3*(1/sqrt(iter));
        theta1 = theta1 - eta*gradient1;
        theta2 = theta2 - eta*gradient2; 
    end
    
    Jf = 0;
    for i = 1:m
        a = [1 ; sigmoid(theta1*x(i,:)')]; % 101*1
        o = sigmoid(theta2*a); % 3*1
        Jf = Jf + sum((y(i,:)'-o).^2);
    end
    
    Jf = Jf/(2*m);
    
    if abs(Ji-Jf) < d  % Assuming J is strictly decreasing (Which is incorrect !!)
        b = b + 1;
        if(b > 2)
            break; 
        end
    else
        b = 0;
    end
    disp(Jf);
    Ji = Jf;
end

% disp(theta1);
% disp(theta2);
disp('No. of iterations taken to converge : ');
disp(iter);

toc();
% 
% total = 0;
% 
% for i = 1:m
%    a = [1 ; sigmoid(theta1*x(i,:)')]; % 101*1
%    o = sigmoid(theta2*a); % 3*1
%    
%    [M, I] = max(o);
%    
% %    Y = y(i,:);
%    if(y(i,I(1)) == 1)
%        total = total + 1;
%    end
%    
% %    disp(o);
% %    disp(I);
% %    disp(Y);
%    
% end
% 
% disp('Accuracy on training data is ');
% disp( (total/m)*100 );


m = 17557;
% m = 100;
fileID = fopen('test.data','r');
x = ones(m,126); % Add First collumn as all ones i.e. x0
y = zeros(m,3);

for i = 1:m
   C = strsplit(sscanf(fgetl(fileID), '%c'),',');
   n = size(C);
   
   for j = 1:n(1,2)-1
       x(i,j) = str2double(cell2mat(C(1,j)));
   end
   
   if strcmp('win', C(1,n(1,2)))
       y(i,1) = 1;
   elseif strcmp('loss', C(1,n(1,2)))
       y(i,2) = 1;
   elseif strcmp('draw', C(1,n(1,2)))
       y(i,3) = 1;
   end
end

disp('Test Data Read');
x = [ones(m,1) x];

total = 0;

for i = 1:m
   a = [1 ; sigmoid(theta1*x(i,:)')]; % 101*1
   o = sigmoid(theta2*a); % 3*1
   
   [M, I] = max(o);
   
%    Y = y(i,:);
   if(y(i,I(1)) == 1)
       total = total + 1;
   end
   
%    disp(o);
%    disp(I);
%    disp(Y);
   
end

disp('Accuracy on test data is ');
disp( (total/m)*100 );









