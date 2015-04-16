A = imread('ps1-input0-noise.png');
B = imread('ps1-input0-smooth.png');
EA = edge(A,'canny',[0.1 0.3],.6);
figure(1)
imshow(EA)
EB = edge(B,'canny',[0.25 0.3],.5);
figure(2)
imshow(EB)