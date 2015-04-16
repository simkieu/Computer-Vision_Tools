function [F_out, D] = find_feature(A)
[r,c] = size(A);

%Prefilter the image
sigma = 0.5; %Lightly prefilter the image
A = imfilter(A,fspecial('gaussian',6*sigma,sigma));

%Find image gradient
[Ix, Iy] = imgradientxy(A);

%Find Harris Output
R_raw = harris_output(A);
R = harris_refine(R_raw);

%Compute the angle
Rot = zeros(r,c);
for i = 1:r
    for j = 1:c
        Rot(i,j) = atan2(Iy(i,j),Ix(i,j));
    end
end

%Find number of features
[rr cc] = find(R>0);
N = length(rr);

%Build feature matrix
f_in = ones(4,N);
for i = 1:N
    f_in(1,i) = cc(i);
    f_in(2,i) = rr(i);
    f_in(4,i) = Rot(rr(i),cc(i));
end

%Draw frame
A = single(A);
[F_out, D] = vl_sift(A, 'frames', f_in);
end