clear
clc

I = im2double(imread('yos_img_01.jpg'));
I2 = REDUCE(I);
I3 = REDUCE(I2);
I4 = REDUCE(I3);
figure()
imshow(I)
figure()
imshow(I2)
figure()
imshow(I3)
figure()
imshow(I4)