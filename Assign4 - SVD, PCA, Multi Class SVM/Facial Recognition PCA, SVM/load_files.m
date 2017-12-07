tic();

% //////////////////////////////////////////////////////////////////////////////////////////////////////////
% /////////////////////////////////////////// Loading 1st Dataset //////////////////////////////////////////
% //////////////////////////////////////////////////////////////////////////////////////////////////////////

dirName = '/Users/macbook/Desktop/MLA4/lfw_easy';
dirData = dir(dirName);      %# Get the data for the current directory
dirIndex = [dirData.isdir];  %# Find the index for directories
fileList = {dirData(~dirIndex).name}';  %'# Get a list of the files
if ~isempty(fileList) %# Prepend path to files
    fileList = cellfun(@(x) fullfile(dirName,x), fileList,'UniformOutput',false);
end
subDirs = {dirData(dirIndex).name};  %# Get a list of the subdirectories
disp('subDirs is ');
validIndex = ~ismember(subDirs,{'.','..'});  %# Find index of subdirectories
                                               %#   that are not '.' or '..'
images1 = zeros(1288,1850); % 50 * 37
labels1 = zeros(1288,1);    
images2 = zeros(400,10304); % 112 * 92
labels2 = zeros(400,1);

iter = 0;
iterx = 0;

for iDir = find(validIndex)                  % Loop over valid subdirectories
    iterx = iterx + 1;
    nextDir = fullfile(dirName,subDirs{iDir});    % Get the subdirectory path
    pathx = strcat(nextDir,'/*.jpg');
    pngFiles = dir(pathx);
    for k = 1:length(pngFiles)
        iter = iter + 1;
        filename = pngFiles(k).name;
        fl = strcat(nextDir, '/');
        fl = strcat(fl, filename);
        I = imread(fl);
        % operations on "I", book keeping ...
        I = rgb2gray(I);
        info = imfinfo(fl);
        x = I(:)';
        images1(iter,:) = x;
        labels1(iter) = iterx; 
    end
end

% ///////////   Just checking  
% size(I)
% I = images1(1,:);
% I = reshape(I,50,37);
% imshow(mat2gray(I));
% image(I);

% ///////////   Printing the average
a1 = zeros(1,1850);
for i = 1:1288
    a1 = a1 + images1(i,:);
end

a1 = a1/1288;
avg1 = a1;
a1 = reshape(a1,50,37);
figure();
imshow(uint8(255*mat2gray(a1)));
% image(I);


% //////////////////////////////////////////////////////////////////////////////////////////////////////////
% /////////////////////////////////////////// Loading 2nd Dataset //////////////////////////////////////////
% //////////////////////////////////////////////////////////////////////////////////////////////////////////




dirName = '/Users/macbook/Desktop/MLA4/orl_faces';
dirData = dir(dirName);      %# Get the data for the current directory
dirIndex = [dirData.isdir];  %# Find the index for directories
fileList = {dirData(~dirIndex).name}';  %'# Get a list of the files
if ~isempty(fileList) %# Prepend path to files
    fileList = cellfun(@(x) fullfile(dirName,x), fileList,'UniformOutput',false);
end
subDirs = {dirData(dirIndex).name};  %# Get a list of the subdirectories
validIndex = ~ismember(subDirs,{'.','..'});  %# Find index of subdirectories
                                               %#   that are not '.' or '..'
iter = 0;
iterx = 0;

for iDir = find(validIndex)                  % Loop over valid subdirectories
    %disp('Hello');
    nextDir = fullfile(dirName,subDirs{iDir});    % Get the subdirectory path
    pathx = strcat(nextDir,'/*.pgm');
    pngFiles = dir(pathx);
    % size(pngFiles)
    iterx = 0; 
    for k = 1:length(pngFiles)
        iter = iter + 1;
        iterx = iterx + 1;
        filename = pngFiles(k).name;
        fl = strcat(nextDir, '/');
        fl = strcat(fl, filename);
        I = imread(fl);
        % operations on "I", book keeping ...
        x = I(:)';
        images2(iter,:) = x;
        labels2(iter) = iterx;   % /////  ??????  10 classes ...
    end
end

% ///////////   Just checking  
% iter
% iterx
% size(I)
% disp('I is');
% disp(I);
% imshow(I);
% I = images2(1,:);
% I = reshape(I,112,92);
% imshow(mat2gray(I));
% image(I);

% ///////////   Printing the average
a2 = zeros(1,10304);
for i = 1:400
    a2 = a2 + images2(i,:);
end

a2 = a2/400;
avg2 = a2;
a2 = reshape(a2,112,92);
figure();
imshow(uint8(255*mat2gray(a2)));



%/////////////////////////////////////////////// b part ////////////////////////////////////////////////////
% //////////////////////////////////////////////////////////////////////////////////////////////////////////
% /////////////////////////////////////////// COVARIANCE MATRIX ////////////////////////////////////////////
% //////////////////////////////////////////////////////////////////////////////////////////////////////////

% sigma1 = (1/m) * (X'*X); 
% Need to calculate that X;
m = 1288;
X1 = images1 - repmat(avg1,m,1);

m = 400;
X2 = images2 - repmat(avg2,m,1);


% X1 is 1288 * 1850
% X2 is 400  * 10304

[U1,S1,V1] = svd(X1,'econ');
[U2,S2,V2] = svd(X2,'econ');


% here S is in pace of D, which was taught in class
% V1 and V2 are transposes of the matrices whose collumns are the eigen vectors
% So take the rows of V1 and V2 for the eigen vectors.

% BUT HERE ITS COLLUMNS ???????????
disp('size of V1 is ');
disp(size(V1));

disp('size of V2 is ');
disp(size(V2));

% store in a file -------------
PC1 = V1(:,1:50)';  % 50 * 1850
PC2 = V2(:,1:50)';  % 50 * 10304




%////////////////////////////////////////// c part ////////////////////////////////////////////////
for i = 1:5
   I = reshape(PC1(i,:),50,37);
   figure();
   imshow(uint8(255*mat2gray(I)));
end

for i = 1:5
   I = reshape(PC2(i,:),112,92);
   figure();
   imshow(uint8(255*mat2gray(I)));
end

% ///////   

%////////////////////////////////////////// d part ////////////////////////////////////////////////
% projections1 : 1288 * 50
% projections2 : 400 * 50

% images1 : 1288 * 1850
% images2 : 400 * 10304

projections1 = images1 * PC1';
projections2 = images2 * PC2';







% CAREFULL !!!!
% V1 and V2 give eigen vectors of (X'*X), but we need eigen vectors of (1/m) * (X'*X)
% ANYWAYS WE HAVE TO SCALE THESE EIGEN VECTORS (TOP PRINCIPAL COMPONENTS) B4 DISPLAYING



toc();


