clear
clc

I1 = im2double(imread('Shift0.png'));
I2 = im2double(imread('ShiftR10.png'));

n = 1;

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
        Lk = imfilter(Lk,fspecial('gaussian', 21,4));
        Rk = imfilter(Rk,fspecial('gaussian', 21,4));
    end
    
    %Step 3
    if k == n
        [r,c] = size(Lk);
        U = zeros(r,c);
        V = zeros(r,c);
    end
    
    %Step 4
    Wk = warpI2(Rk,U,V);
    
    %Step 5
    [Dx,Dy] = LK(Lk,Wk,5,16);
    
    %Step 6
    U = U + Dx;
    V = V + Dy;
    
    m = testwarp(Rk,Lk,U,V);
    
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

%m = testwarp(I2,I1,U,V);