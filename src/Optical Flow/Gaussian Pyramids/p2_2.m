clear
clc

I = im2double(imread('yos_img_01.jpg'));
[R2,a1,a2] = REDUCE(I);
[R3,b1,b2] = REDUCE(R2);
[R4,c1,c2] = REDUCE(R3);

E3 = EXPAND(R4,c1,c2);
E2 = EXPAND(R3,b1,b2);
E1 = EXPAND(R2,a1,a2);

L1 = I - E1;
L2 = R2 - E2;
L3 = R3 - E3;
L4 = R4;

L1 = imnormalize(L1);
L2 = imnormalize(L2);
L3 = imnormalize(L3);

figure()
imshow(L1)
figure()
imshow(L2)
figure()
imshow(L3)
figure()
imshow(L4)