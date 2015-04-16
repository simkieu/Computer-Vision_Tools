clear
clc

%For the image pair transA.jpg and transB.jpg
%For image A
A = im2double(imread('transA.jpg'));
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
[rr, cc] = find(R>0);
N = length(rr);

%Build feature matrix
f_in = 4*ones(4,N);
for i = 1:N
    f_in(1,i) = cc(i);
    f_in(2,i) = rr(i);
    f_in(4,i) = Rot(rr(i),cc(i));
end

%Draw frame
A = single(A);
[F_outA, D_outA] = vl_sift(A, 'frames', f_in);

%For image B
B = im2double(imread('transB.jpg'));
[r,c] = size(B);

%Prefilter the image
sigma = 0.5; %Lightly prefilter the image
B = imfilter(B,fspecial('gaussian',6*sigma,sigma));

%Find image gradient
[Ix, Iy] = imgradientxy(B);

%Find Harris Output
R_raw = harris_output(B);
R = harris_refine(R_raw);

%Compute the angle
Rot = zeros(r,c);
for i = 1:r
    for j = 1:c
        Rot(i,j) = atan2(Iy(i,j),Ix(i,j));
    end
end

%Find number of features
[rr, cc] = find(R>0);
N = length(rr);

%Build feature matrix
f_in = 4*ones(4,N);
for i = 1:N
    f_in(1,i) = cc(i)+c;
    f_in(2,i) = rr(i);
    f_in(4,i) = Rot(rr(i),cc(i));
end

%Draw frame
B = single(B);
[F_outB, D_outB] = vl_sift(B,'frames',f_in);

%Draw
C = [A B];
figure()
imshow(C)
hold on
h1 = vl_plotframe(F_outA);
h2 = vl_plotframe(F_outB);
set(h1,'color','y','linewidth',1);
set(h2,'color','y','linewidth',1);



%For the image pair simA.jpg and simB.jpg
%For image A
A = im2double(imread('simA.jpg'));
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
[rr, cc] = find(R>0);
N = length(rr);

%Build feature matrix
f_in = 4*ones(4,N);
for i = 1:N
    f_in(1,i) = cc(i);
    f_in(2,i) = rr(i);
    f_in(4,i) = Rot(rr(i),cc(i));
end

%Draw frame
A = single(A);
[F_outA, D_outA] = vl_sift(A, 'frames', f_in);

%For image B
B = im2double(imread('simB.jpg'));
[r,c] = size(B);

%Prefilter the image
sigma = 0.5; %Lightly prefilter the image
B = imfilter(B,fspecial('gaussian',6*sigma,sigma));

%Find image gradient
[Ix, Iy] = imgradientxy(B);

%Find Harris Output
R_raw = harris_output(B);
R = harris_refine(R_raw);

%Compute the angle
Rot = zeros(r,c);
for i = 1:r
    for j = 1:c
        Rot(i,j) = atan2(Iy(i,j),Ix(i,j));
    end
end

%Find number of features
[rr, cc] = find(R>0);
N = length(rr);

%Build feature matrix
f_in = 4*ones(4,N);
for i = 1:N
    f_in(1,i) = cc(i)+c;
    f_in(2,i) = rr(i);
    f_in(4,i) = Rot(rr(i),cc(i));
end

%Draw frame
B = single(B);
[F_outB, D_outB] = vl_sift(B,'frames',f_in);

%Draw
C = [A B];
figure()
imshow(C)
hold on
h1 = vl_plotframe(F_outA);
h2 = vl_plotframe(F_outB);
set(h1,'color','y','linewidth',1);
set(h2,'color','y','linewidth',1);