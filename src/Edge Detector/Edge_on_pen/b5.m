A = imread('ps1-input1-smooth.jpg');
E = edge(A,'canny',[0.2 0.3],1);
imshow(E)
imwrite(E,'ps1-input1-edge.jpg');