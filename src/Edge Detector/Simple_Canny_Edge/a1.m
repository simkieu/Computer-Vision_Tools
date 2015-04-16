A = imread('ps1-input0.png');
E = edge(A,'canny',[0.1 0.9],1);
imshow(E)