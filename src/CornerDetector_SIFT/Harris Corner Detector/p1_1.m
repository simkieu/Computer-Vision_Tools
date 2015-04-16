clear
clc

transA = im2double(imread('transA.jpg'));
simA = im2double(imread('simA.jpg'));
sigma = 0.5;
transA = imfilter(transA,fspecial('gaussian',6*sigma,sigma));
%figure
%imshow(transA)
%simA = imfilter(simA,fspecial('gaussian',6*sigma,sigma));
figure
[transAx,transAy] = gradient_pair(transA);
figure
[simAx,simAy] = gradient_pair(simA);