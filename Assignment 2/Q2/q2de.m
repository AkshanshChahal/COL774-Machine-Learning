tic();

% part d //////////////////////////////
x = load('traindata.txt');
y = load('trainlabels.txt');

X = load('testdata.txt');
Y = load('testlabels.txt');

disp('--------LINEAR KERNEL-------');
% LIBSVM statement for LINEAR KERNEL
% Training
model = svmtrain(y, x, '-c 500 -t 0');
% Predicting
[predict_label, accuracy, prob_values] = svmpredict(Y, X, model);


disp('--------GAUSSIAN KERNEL-------');
% LIBSVM statement for GAUSSIAN KERNEL
% Training
model = svmtrain(y, x, '-c 500 -g 2.5');
% Predicting
[predict_label, accuracy, prob_values] = svmpredict(Y, X, model);


% part e //////////////////////////////

c = [];
% preparing the vector for C values
for i=1:7
   c = [c 10^(i-1)]; 
end

acc = [];
valid = [];
for i = 1:7
    % Training 
    model = svmtrain(y, x, ['-g 2.5 -c ', num2str(c(i))]);
    % Predicting
    [predict_label, accuracy, prob_values] = svmpredict(Y, X, model);
    acc = [acc accuracy(1)];
    
    % CROSS VALIDATION
    validation = svmtrain(y, x, ['-g 2.5 -v 10 -c ', num2str(c(i))]);
    valid = [valid validation];
    
end

disp(acc);
disp(valid);


% PLOTTING the curves
xx = log10(c);

figure();
hold on;

plot(xx, acc);
plot(xx, valid);

xlabel('X-axis'); 	%X-axis label
ylabel('Y-axis'); 	%Y-axis label

legend('Accuracies', 'Validations'); %Legends 
% title(num2str(bandwidth)); 	%Plot title
hold off;



toc();