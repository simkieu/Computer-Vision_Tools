clear
clc

I1 = im2double(rgb2gray(imread('1.png'))); %remove rgb2gray if input image is a grayscale one
I2 = im2double(rgb2gray(imread('2.png')));

n = 5;

%Parameters for correct reducing and expanding
a = zeros(n,2);
b = zeros(n,2);

%Step 1
k = n;

while (k>=0)
    %Step 2: Reduce both images to level k
    Lk = I1;
    Rk = I2;
    for i = 1:k
        [Lk,a1,a2] = REDUCE(Lk);
        [Rk,b1,b2] = REDUCE(Rk);
        a(i,1) = a1;
        a(i,2) = a2;
        b(i,1) = b1;
        b(i,2) = b2;
    end
    
    %Step 3
    if k == n
        [r,c] = size(Lk);
        U = zeros(r,c);
        V = zeros(r,c);
    else
        U = 2*EXPAND(U,a(k+1,1),a(k+1,2));
        V = 2*EXPAND(V,b(k+1,1),b(k+1,2));
    end
    
    %Step 4
    Wk = warpI2(Rk,U,V);
    
    %Step 5
    [Dx,Dy] = LK(Lk,Wk,5,15);
    
    %Step 6
    U = U + Dx;
    V = V + Dy;
    
    %Step 7
    k = k - 1;
end

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
I3 = [I1 I21];
figure()
imshow(I3)
figure()
imshow(I1-I21)
m = testwarp(I2,I1,U,V);