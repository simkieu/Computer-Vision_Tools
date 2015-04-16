clear
clc

%For R10
I1 = im2double(imread('Shift0.png'));
I2 = im2double(imread('ShiftR10.png'));
[r,c] = size(I1);
%Filter to scale down the image
I1 = imfilter(I1, fspecial('gaussian', 21,8));
I2 = imfilter(I2, fspecial('gaussian', 21,8));

%Get image gradient
Ix = imfilter(I1, [-1 1]);
Iy = imfilter(I1, [-1 1]');

Ix2 = Ix .^ 2;
Iy2 = Iy .^ 2;
Ixy = Ix .* Iy;
It  = I2 - I1;
Ixt = Ix .* It;
Iyt = Iy .* It;

wsize = 21;  wsig = 8;
%Find weighted sum of Ix2, Iy2, Ixy, Ixt, Iyt by filtering instead of
%looping and adding
wIx2 = imfilter(Ix2, fspecial('gaussian', wsize, wsig));
wIy2 = imfilter(Iy2, fspecial('gaussian', wsize, wsig));
wIxy = imfilter(Ixy, fspecial('gaussian', wsize, wsig));
wIxt = imfilter(Ixt, fspecial('gaussian', wsize, wsig));
wIyt = imfilter(Iyt, fspecial('gaussian', wsize, wsig));

U = zeros(r,c);
V = zeros(r,c);
for i = 1:r
    for j = 1:c
        A = [wIx2(i,j) wIxy(i,j); wIxy(i,j) wIy2(i,j)];
        b = [-wIxt(i,j); -wIyt(i,j)];
        uv = A\b;
        U(i,j) = uv(1);
        V(i,j) = uv(2);
    end
end

figure(1)
subplot(2,1,1)
imagesc(U)
colorbar
title('U displacement')
subplot(2,1,2)
imagesc(V)
colorbar
title('V displacement')



%For R20
I1 = im2double(imread('Shift0.png'));
I2 = im2double(imread('ShiftR20.png'));
[r,c] = size(I1);
%Filter to scale down the image
I1 = imfilter(I1, fspecial('gaussian', 21,8));
I2 = imfilter(I2, fspecial('gaussian', 21,8));

%Get image gradient
Ix = imfilter(I1, [-1 1]);
Iy = imfilter(I1, [-1 1]');

Ix2 = Ix .^ 2;
Iy2 = Iy .^ 2;
Ixy = Ix .* Iy;
It  = I2 - I1;
Ixt = Ix .* It;
Iyt = Iy .* It;

wsize = 21;  wsig = 8;
%Find weighted sum of Ix2, Iy2, Ixy, Ixt, Iyt by filtering instead of
%looping and adding
wIx2 = imfilter(Ix2, fspecial('gaussian', wsize, wsig));
wIy2 = imfilter(Iy2, fspecial('gaussian', wsize, wsig));
wIxy = imfilter(Ixy, fspecial('gaussian', wsize, wsig));
wIxt = imfilter(Ixt, fspecial('gaussian', wsize, wsig));
wIyt = imfilter(Iyt, fspecial('gaussian', wsize, wsig));

U = zeros(r,c);
V = zeros(r,c);
for i = 1:r
    for j = 1:c
        A = [wIx2(i,j) wIxy(i,j); wIxy(i,j) wIy2(i,j)];
        b = [-wIxt(i,j); -wIyt(i,j)];
        uv = A\b;
        U(i,j) = uv(1);
        V(i,j) = uv(2);
    end
end

figure(2)
subplot(2,1,1)
imagesc(U)
colorbar
title('U displacement')
subplot(2,1,2)
imagesc(V)
colorbar
title('V displacement')


%For R40
I1 = im2double(imread('Shift0.png'));
I2 = im2double(imread('ShiftR40.png'));
[r,c] = size(I1);
%Filter to scale down the image
I1 = imfilter(I1, fspecial('gaussian', 21,8));
I2 = imfilter(I2, fspecial('gaussian', 21,8));

%Get image gradient
Ix = imfilter(I1, [-1 1]);
Iy = imfilter(I1, [-1 1]');

Ix2 = Ix .^ 2;
Iy2 = Iy .^ 2;
Ixy = Ix .* Iy;
It  = I2 - I1;
Ixt = Ix .* It;
Iyt = Iy .* It;

wsize = 21;  wsig = 8;
%Find weighted sum of Ix2, Iy2, Ixy, Ixt, Iyt by filtering instead of
%looping and adding
wIx2 = imfilter(Ix2, fspecial('gaussian', wsize, wsig));
wIy2 = imfilter(Iy2, fspecial('gaussian', wsize, wsig));
wIxy = imfilter(Ixy, fspecial('gaussian', wsize, wsig));
wIxt = imfilter(Ixt, fspecial('gaussian', wsize, wsig));
wIyt = imfilter(Iyt, fspecial('gaussian', wsize, wsig));

U = zeros(r,c);
V = zeros(r,c);
for i = 1:r
    for j = 1:c
        A = [wIx2(i,j) wIxy(i,j); wIxy(i,j) wIy2(i,j)];
        b = [-wIxt(i,j); -wIyt(i,j)];
        uv = A\b;
        U(i,j) = uv(1);
        V(i,j) = uv(2);
    end
end

figure(3)
subplot(2,1,1)
imagesc(U)
colorbar
title('U displacement')
subplot(2,1,2)
imagesc(V)
colorbar
title('V displacement')