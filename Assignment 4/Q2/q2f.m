

%% //////////  For dataset 1

id1 = 1;
% original face
figure();
imshow(uint8(255*mat2gray(reshape(images1(id1,:),50,37))));

projected_face = zeros(1,1850);

% PC1 is 50 * 1850
% projections1 : 1288 * 50
for i = 1:50
   projected_face = projected_face + projections1(id1,i)*PC1(i,:);
end

figure();
imshow(uint8(255*mat2gray(reshape(projected_face,50,37))));



%% //////////  For dataset 2

id2 = 1;
% original face
figure();
imshow(uint8(255*mat2gray(reshape(images2(id2,:),112,92))));

projected_face = zeros(1,10304);

% PC1 is 50 * 1850
% projections1 : 1288 * 50
for i = 1:50
   projected_face = projected_face + projections2(id2,i)*PC2(i,:);
end

figure();
imshow(uint8(255*mat2gray(reshape(projected_face,112,92))));


