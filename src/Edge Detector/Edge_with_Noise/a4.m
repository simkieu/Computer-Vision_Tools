A = imread('ps1-input0-noise.png');
sigma = 3;
B = imfilter(A,fspecial('gaussian',6*sigma,sigma));
imwrite(B,'ps1-input0-smooth.png');
imshow(B)