function R = harris_output(A)
[r,c] = size(A);
alpha = 0.05;
win_radi = 3; %Weight gaussian window radius
sigma = 0.5; %Lightly prefilter the image
%w = ones*(2*win_radi+1)/(2*win_radi+1);%Window weight function
w = fspecial('gaussian', 2*win_radi+1, win_radi/3);%Gaussian window weight function
R = zeros(r,c);

%Prefilter the image
A = imfilter(A,fspecial('gaussian',6*sigma,sigma));

%Find image gradient
[Ax,Ay] = imgradientxy(A);

%Find Harris Output 
for i = 1+win_radi:r-win_radi
    for j = 1+win_radi:c-win_radi
        M = zeros(2,2);
        Ix = Ax(i-win_radi:i+win_radi,j-win_radi:j+win_radi);
        Iy = Ay(i-win_radi:i+win_radi,j-win_radi:j+win_radi);
        Ix2 = Ix.^2;
        Iy2 = Iy.^2;
        M(1,1) = sum(sum(w.*Ix2));
        M(1,2) = sum(sum(w.*Ix.*Iy));
        M(2,1) = M(1,2);
        M(2,2) = sum(sum(w.*Iy2));
        R(i,j) = det(M) - alpha*trace(M)^2;
    end
end
end