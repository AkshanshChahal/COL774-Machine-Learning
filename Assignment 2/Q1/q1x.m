clc; 
clear; 
close all;

tic();

m = 5485; % Size of the training data file.		

fileID = fopen('r8-train-all-terms.txt','r');

% Initializing all the 8 maps corresponding to each of the classes
% these are basically the parameters which will be used for prediction
y = zeros(8,1);
map1 = containers.Map;
map2 = containers.Map;
map3 = containers.Map;
map4 = containers.Map;
map5 = containers.Map;
map6 = containers.Map;
map7 = containers.Map;
map8 = containers.Map;


for i = 1:m
    
    % Splitting the document into words
	C = strsplit(sscanf(fgetl(fileID), '%c'));
	n = size(C);

    % Now checking for each document's class and then updating the
    % corresponding map for the count of each word in that document
    % Side by side also calculating the total number of words in each class
    % of documents
    if strcmp('acq', C(1,1))
		y(1) = y(1) + n(1,2)-2;
        for j = 2:n(1,2)-1  % cuz at 1 we have the class name !
            t = isKey(map1,C(1,j));
            if(t==0)
                map1(cell2mat(C(1,j))) = 0;
                map2(cell2mat(C(1,j))) = 0;
                map3(cell2mat(C(1,j))) = 0;
                map4(cell2mat(C(1,j))) = 0;
                map5(cell2mat(C(1,j))) = 0;
                map6(cell2mat(C(1,j))) = 0;
                map7(cell2mat(C(1,j))) = 0;
                map8(cell2mat(C(1,j))) = 0;
            end
             map1(cell2mat(C(1,j))) = map1(cell2mat(C(1,j))) + 1;
        end
	elseif strcmp('crude', C(1,1))
		y(2) = y(2) + n(1,2)-2;
        for j = 2:n(1,2)-1  % cuz at 1 we have the class name !
            t = isKey(map2,C(1,j));
            if(t==0)
                map1(cell2mat(C(1,j))) = 0;
                map2(cell2mat(C(1,j))) = 0;
                map3(cell2mat(C(1,j))) = 0;
                map4(cell2mat(C(1,j))) = 0;
                map5(cell2mat(C(1,j))) = 0;
                map6(cell2mat(C(1,j))) = 0;
                map7(cell2mat(C(1,j))) = 0;
                map8(cell2mat(C(1,j))) = 0;
            end
             map2(cell2mat(C(1,j))) = map2(cell2mat(C(1,j))) + 1;
        end
	elseif strcmp('earn', C(1,1))
		y(3) = y(3) + n(1,2)-2;
        for j = 2:n(1,2)-1  % cuz at 1 we have the class name !
            t = isKey(map3,C(1,j));
            if(t==0)
                map1(cell2mat(C(1,j))) = 0;
                map2(cell2mat(C(1,j))) = 0;
                map3(cell2mat(C(1,j))) = 0;
                map4(cell2mat(C(1,j))) = 0;
                map5(cell2mat(C(1,j))) = 0;
                map6(cell2mat(C(1,j))) = 0;
                map7(cell2mat(C(1,j))) = 0;
                map8(cell2mat(C(1,j))) = 0;
            end
             map3(cell2mat(C(1,j))) = map3(cell2mat(C(1,j))) + 1;
        end
	elseif strcmp('grain', C(1,1))
		y(4) = y(4) + n(1,2)-2;
        for j = 2:n(1,2)-1  % cuz at 1 we have the class name !
            t = isKey(map4,C(1,j));
            if(t==0)
                map1(cell2mat(C(1,j))) = 0;
                map2(cell2mat(C(1,j))) = 0;
                map3(cell2mat(C(1,j))) = 0;
                map4(cell2mat(C(1,j))) = 0;
                map5(cell2mat(C(1,j))) = 0;
                map6(cell2mat(C(1,j))) = 0;
                map7(cell2mat(C(1,j))) = 0;
                map8(cell2mat(C(1,j))) = 0;
            end
             map4(cell2mat(C(1,j))) = map4(cell2mat(C(1,j))) + 1;
        end
	elseif strcmp('interest', C(1,1))
		y(5) = y(5) + n(1,2)-2;
        for j = 2:n(1,2)-1  % cuz at 1 we have the class name !
            t = isKey(map5,C(1,j));
            if(t==0)
                map1(cell2mat(C(1,j))) = 0;
                map2(cell2mat(C(1,j))) = 0;
                map3(cell2mat(C(1,j))) = 0;
                map4(cell2mat(C(1,j))) = 0;
                map5(cell2mat(C(1,j))) = 0;
                map6(cell2mat(C(1,j))) = 0;
                map7(cell2mat(C(1,j))) = 0;
                map8(cell2mat(C(1,j))) = 0;
            end
             map5(cell2mat(C(1,j))) = map5(cell2mat(C(1,j))) + 1;
        end
	elseif strcmp('money-fx', C(1,1))
		y(6) = y(6) + n(1,2)-2;
        for j = 2:n(1,2)-1  % cuz at 1 we have the class name !
            t = isKey(map6,C(1,j));
            if(t==0)
                map1(cell2mat(C(1,j))) = 0;
                map2(cell2mat(C(1,j))) = 0;
                map3(cell2mat(C(1,j))) = 0;
                map4(cell2mat(C(1,j))) = 0;
                map5(cell2mat(C(1,j))) = 0;
                map6(cell2mat(C(1,j))) = 0;
                map7(cell2mat(C(1,j))) = 0;
                map8(cell2mat(C(1,j))) = 0;
            end
             map6(cell2mat(C(1,j))) = map6(cell2mat(C(1,j))) + 1;
        end
	elseif strcmp('ship', C(1,1))
		y(7) = y(7) + n(1,2)-2;
        for j = 2:n(1,2)-1  % cuz at 1 we have the class name !
            t = isKey(map7,C(1,j));
            if(t==0)
                map1(cell2mat(C(1,j))) = 0;
                map2(cell2mat(C(1,j))) = 0;
                map3(cell2mat(C(1,j))) = 0;
                map4(cell2mat(C(1,j))) = 0;
                map5(cell2mat(C(1,j))) = 0;
                map6(cell2mat(C(1,j))) = 0;
                map7(cell2mat(C(1,j))) = 0;
                map8(cell2mat(C(1,j))) = 0;
            end
             map7(cell2mat(C(1,j))) = map7(cell2mat(C(1,j))) + 1;
        end
	elseif strcmp('trade', C(1,1))
		y(8) = y(8) + n(1,2)-2;
        for j = 2:n(1,2)-1  % cuz at 1 we have the class name !
            t = isKey(map8,C(1,j));
            if(t==0)
                map1(cell2mat(C(1,j))) = 0;
                map2(cell2mat(C(1,j))) = 0;
                map3(cell2mat(C(1,j))) = 0;
                map4(cell2mat(C(1,j))) = 0;
                map5(cell2mat(C(1,j))) = 0;
                map6(cell2mat(C(1,j))) = 0;
                map7(cell2mat(C(1,j))) = 0;
                map8(cell2mat(C(1,j))) = 0;
            end
             map8(cell2mat(C(1,j))) = map8(cell2mat(C(1,j))) + 1;
        end
    end
end
% For Loop END
fclose(fileID);
% modV is the size of vocabulary
modV = length(map1);
disp(modV);
% phi_subscript(k|class=i) = (mapi(k)+1)/(y(i)+modV);   => Laplace Smoothing
% Take log of the above value;      => Avoiding Underflow


Ax = zeros(8,1);
% Ax store the phi parameters for the probability P(y=j) j = 1,2,3,4,5,6,7,8 
Ax(1) = Ax(1) + log(1596/m);
Ax(2) = Ax(2) + log(253/m);
Ax(3) = Ax(3) + log(2840/m);
Ax(4) = Ax(4) + log(41/m);
Ax(5) = Ax(5) + log(190/m);
Ax(6) = Ax(6) + log(206/m);
Ax(7) = Ax(7) + log(108/m);
Ax(8) = Ax(8) + log(251/m);


confuse = zeros(8,8);
%####################### TESTING ON TRAINING DATA #######################
fileID = fopen('r8-train-all-terms.txt','r');
 
right = 0;
z = 1;
for i = 1:m
	C = strsplit(sscanf(fgetl(fileID), '%c'));
	n = size(C);
%     A = zeros(8,1);
    
% First identifying the class which it belongs to
    if strcmp('acq', C(1,1))
		z = 1;
	elseif strcmp('crude', C(1,1))
		z = 2;
	elseif strcmp('earn', C(1,1))
		z = 3;
	elseif strcmp('grain', C(1,1))
		z = 4;
	elseif strcmp('interest', C(1,1))
		z = 5;
	elseif strcmp('money-fx', C(1,1))
		z = 6;
	elseif strcmp('ship', C(1,1))
		z = 7;
	elseif strcmp('trade', C(1,1))
		z = 8;
    elseif(true)
        disp('---------------------------------------------------'); 
    end	

    A = Ax;
    
    for j = 2:n(1,2)-1  % cuz at 1 we have the class name !
        
        % Going to each word in each document and preparing all the 8 probability
        % values for the prediction time
        t = isKey(map1,C(1,j));
        if(t==1)
            A(1) = A(1) + laplace_log(map1(cell2mat(C(1,j))), y(1));
            A(2) = A(2) + laplace_log(map2(cell2mat(C(1,j))), y(2));
            A(3) = A(3) + laplace_log(map3(cell2mat(C(1,j))), y(3));
            A(4) = A(4) + laplace_log(map4(cell2mat(C(1,j))), y(4));
            A(5) = A(5) + laplace_log(map5(cell2mat(C(1,j))), y(5));
            A(6) = A(6) + laplace_log(map6(cell2mat(C(1,j))), y(6));
            A(7) = A(7) + laplace_log(map7(cell2mat(C(1,j))), y(7));
            A(8) = A(8) + laplace_log(map8(cell2mat(C(1,j))), y(8));
        else
            A(1) = A(1) + laplace_log(0, y(1));
            A(2) = A(2) + laplace_log(0, y(2));
            A(3) = A(3) + laplace_log(0, y(3));
            A(4) = A(4) + laplace_log(0, y(4));
            A(5) = A(5) + laplace_log(0, y(5));
            A(6) = A(6) + laplace_log(0, y(6));
            A(7) = A(7) + laplace_log(0, y(7));
            A(8) = A(8) + laplace_log(0, y(8));
        end
    end
        
     
    [M, I] = max(A);
    % Max of all the 8 probs will give the class we will predict
    
%     disp(A);
%     disp(M);
%     disp(I);
    
    if(I == z)
        right = right + 1;
    end
    
    % Confusion Matrix
    confuse(z,I(1)) = confuse(z,I(1)) + 1;
    
end
% For Loop END
fclose(fileID);

disp('Accuracy for training data is');
disp((right/m)*100);
disp('');
disp('Confusion Matrix is');
disp(confuse);

% Now similarly testing on test data
confuse = zeros(8,8);
%####################### TESTING ON TEST DATA #######################
fileID = fopen('r8-test-all-terms.txt','r');

right = 0;
z = 1;
for i = 1:2189
    
%     disp(class(fgetl(fileID)));
	C = strsplit(sscanf(fgetl(fileID), '%c'));
%     disp(C(1,1));
	n = size(C);
%     A = zeros(8,1);
    
    if strcmp('acq', C(1,1))
		z = 1;
	elseif strcmp('crude', C(1,1))
		z = 2;
	elseif strcmp('earn', C(1,1))
		z = 3;
	elseif strcmp('grain', C(1,1))
		z = 4;
	elseif strcmp('interest', C(1,1))
		z = 5;
	elseif strcmp('money-fx', C(1,1))
		z = 6;
	elseif strcmp('ship', C(1,1))
		z = 7;
	elseif strcmp('trade', C(1,1))
		z = 8;
    end	
    
    A = Ax;
	
    for j = 2:n(1,2)-1  % cuz at 1 we have the class name !
        
        t = isKey(map1,C(1,j));
        if(t==1)
            A(1) = A(1) + laplace_log(map1(cell2mat(C(1,j))), y(1));
            A(2) = A(2) + laplace_log(map2(cell2mat(C(1,j))), y(2));
            A(3) = A(3) + laplace_log(map3(cell2mat(C(1,j))), y(3));
            A(4) = A(4) + laplace_log(map4(cell2mat(C(1,j))), y(4));
            A(5) = A(5) + laplace_log(map5(cell2mat(C(1,j))), y(5));
            A(6) = A(6) + laplace_log(map6(cell2mat(C(1,j))), y(6));
            A(7) = A(7) + laplace_log(map7(cell2mat(C(1,j))), y(7));
            A(8) = A(8) + laplace_log(map8(cell2mat(C(1,j))), y(8));
        else
            A(1) = A(1) + laplace_log(0, y(1));
            A(2) = A(2) + laplace_log(0, y(2));
            A(3) = A(3) + laplace_log(0, y(3));
            A(4) = A(4) + laplace_log(0, y(4));
            A(5) = A(5) + laplace_log(0, y(5));
            A(6) = A(6) + laplace_log(0, y(6));
            A(7) = A(7) + laplace_log(0, y(7));
            A(8) = A(8) + laplace_log(0, y(8));
        end
    end
    
    
    [M, I] = max(A);
    
    if(I(1) == z)
        right = right + 1;
    end
    
    confuse(z,I(1)) = confuse(z,I(1)) + 1;
    
end
% For Loop END
fclose(fileID);

disp('Accuracy for test data is');
disp((right/2189)*100);
disp('');
disp('Confusion Matrix is');
disp(confuse);






toc();


