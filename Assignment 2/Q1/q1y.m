clc; 
clear; 
close all;


% This file is same as q1x.m except it trains on the text files after stop
% words removal and stemming
tic();

m = 5485; 		

fileID = fopen('r8-train-all-terms-new.txt','r');

y = zeros(8,1);
% V = {};
map1 = containers.Map;
map2 = containers.Map;
map3 = containers.Map;
map4 = containers.Map;
map5 = containers.Map;
map6 = containers.Map;
map7 = containers.Map;
map8 = containers.Map;



for i = 1:m
	C = strsplit(sscanf(fgetl(fileID), '%c'));
	n = size(C);

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

modV = length(map1);
disp(modV);
% phi_subscript(k|class=i) = (mapi(k)+1)/(y(i)+modV);   => Laplace Smoothing
% Take log of the above value;      => Avoiding Underflow


Ax = zeros(8,1);

Ax(1) = Ax(1) + log(1596/m);
Ax(2) = Ax(2) + log(253/m);
Ax(3) = Ax(3) + log(2840/m);
Ax(4) = Ax(4) + log(41/m);
Ax(5) = Ax(5) + log(190/m);
Ax(6) = Ax(6) + log(206/m);
Ax(7) = Ax(7) + log(108/m);
Ax(8) = Ax(8) + log(251/m);




confuse = zeros(8,8);
%####################### TESTING ON TEST DATA #######################
fileID = fopen('r8-test-all-terms-new.txt','r');

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
            A(1) = A(1) + laplace_logx(map1(cell2mat(C(1,j))), y(1));
            A(2) = A(2) + laplace_logx(map2(cell2mat(C(1,j))), y(2));
            A(3) = A(3) + laplace_logx(map3(cell2mat(C(1,j))), y(3));
            A(4) = A(4) + laplace_logx(map4(cell2mat(C(1,j))), y(4));
            A(5) = A(5) + laplace_logx(map5(cell2mat(C(1,j))), y(5));
            A(6) = A(6) + laplace_logx(map6(cell2mat(C(1,j))), y(6));
            A(7) = A(7) + laplace_logx(map7(cell2mat(C(1,j))), y(7));
            A(8) = A(8) + laplace_logx(map8(cell2mat(C(1,j))), y(8));
        else
            A(1) = A(1) + laplace_logx(0, y(1));
            A(2) = A(2) + laplace_logx(0, y(2));
            A(3) = A(3) + laplace_logx(0, y(3));
            A(4) = A(4) + laplace_logx(0, y(4));
            A(5) = A(5) + laplace_logx(0, y(5));
            A(6) = A(6) + laplace_logx(0, y(6));
            A(7) = A(7) + laplace_logx(0, y(7));
            A(8) = A(8) + laplace_logx(0, y(8));
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


