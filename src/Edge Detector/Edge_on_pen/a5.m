A = rgb2gray(imread('ps1-input1.jpg'));
sigma = 3;
B = imfilter(A,fspecial('gaussian',6*sigma,sigma));
imwrite(B,'ps1-input1-smooth.jpg');
imshow(B)