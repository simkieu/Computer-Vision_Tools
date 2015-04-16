clear
clc

%For DataSeq1: image 1 to 2
I1 = im2double(imread('yos_img_01.jpg'));
I2 = im2double(imread('yos_img_02.jpg'));
II1 = imfilter(I1, fspecial('gaussian', 21,4));
II2 = imfilter(I2, fspecial('gaussian', 21,4));
[U,V] = LK(II1,II2,21,8);

figure()
subplot(2,1,1)
imagesc(U)
colorbar
title('U displacement')
subplot(2,1,2)
imagesc(V)
colorbar
title('V displacement')

I21 = warpI2(I1,U,V);
% figure()
% imshow(I1)
% figure()
% imshow(I21)
figure()
imshow(I1-I21)
%m = testwarp(I2,I1,U,V);

%For DataSeq1: image 2 to 3
I1 = im2double(imread('yos_img_02.jpg'));
I2 = im2double(imread('yos_img_03.jpg'));
II1 = imfilter(I1, fspecial('gaussian', 21,4));
II2 = imfilter(I2, fspecial('gaussian', 21,4));
[U,V] = LK(II1,II2,21,8);

figure()
subplot(2,1,1)
imagesc(U)
colorbar
title('U displacement')
subplot(2,1,2)
imagesc(V)
colorbar
title('V displacement')

I21 = warpI2(I1,U,V);
% figure()
% imshow(I1)
% figure()
% imshow(I21)
figure()
imshow(I1-I21)
%m = testwarp(I2,I1,U,V);


%For DataSeq2: image 1 to 2
I1 = im2double(rgb2gray(imread('0.png')));
I2 = im2double(rgb2gray(imread('1.png')));
II1 = imfilter(I1, fspecial('gaussian',21,8));
II2 = imfilter(I2, fspecial('gaussian',21,8));
[U,V] = LK(II1,II2,21,8);

figure()
subplot(2,1,1)
imagesc(U)
colorbar
title('U displacement')
subplot(2,1,2)
imagesc(V)
colorbar
title('V displacement')

I21 = warpI2(I1,U,V);
% figure()
% imshow(I1)
% figure()
% imshow(I21)
figure()
imshow(I1-I21)
%m = testwarp(I2,I1,U,V);

%For DataSeq2: image 2 to 3
I1 = im2double(rgb2gray(imread('1.png')));
I2 = im2double(rgb2gray(imread('2.png')));
II1 = imfilter(I1, fspecial('gaussian', 21,8));
II2 = imfilter(I2, fspecial('gaussian', 21,8));
[U,V] = LK(II1,II2,21,8);

figure()
subplot(2,1,1)
imagesc(U)
colorbar
title('U displacement')
subplot(2,1,2)
imagesc(V)
colorbar
title('V displacement')

I21 = warpI2(I1,U,V);
% figure()
% imshow(I1)
% figure()
% imshow(I21)
figure()
imshow(I1-I21)
%m = testwarp(I2,I1,U,V);