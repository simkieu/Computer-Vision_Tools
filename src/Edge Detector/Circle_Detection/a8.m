clear
clc
A = rgb2gray(imread('ps1-input2.jpg'));
sigma = 5;
A = imfilter(A,fspecial('gaussian',6*sigma,sigma));
imshow(A)
E = edge(A,'canny',[0.1 0.14],1);
imshow(E)

%Parameters
t_bin_len = 10;
a_bin_len = 1;
b_bin_len = 1;
r_bin_len = 2;
r_min = 20;
r_max = 40;
a_min = 85;
a_max = 570;
b_min = 130;
b_max = 500;

[r,c] = size(E);
[m,n] = find(E);
len = length(m);
ri_max = floor((r_max-r_min)/r_bin_len)+1;
ai_max = floor((a_max-a_min)/a_bin_len)+1;
bi_max = floor((b_max-b_min)/b_bin_len)+1;
H = zeros(ai_max,bi_max,ri_max);

%Build Histogram
for i=1:len
    x = n(i);
    y = m(i);
    for r=r_min:r_bin_len:r_max
        for t=0:t_bin_len:360-t_bin_len
            a = x - r*cosd(t);
            b = y + r*sind(t);
            ai = floor((a-a_min)/a_bin_len)+1;
            bi = floor((b-b_min)/b_bin_len)+1;
            ri = floor((r-r_min)/r_bin_len)+1;
            if ai>0 && ai<ai_max && bi>0 && bi<bi_max
                H(ai,bi,ri) = H(ai,bi,ri)+1;
            end
        end
    end
end

%Thresholding
thresh = 12;
no_cir = 0;
max_cir = 15;
m1 = zeros(1,max_cir);
n1 = zeros(1,max_cir);
l1 = zeros(1,max_cir);
for i=1:ai_max
    for j=1:bi_max
        for k=1:ri_max
            if H(i,j,k)>thresh
                no_cir = no_cir+1;
                m1(no_cir)=i;
                n1(no_cir)=j;
                l1(no_cir)=k;
            end
        end
    end
end

%Draw circles
imshow(A)
for i=1:no_cir
    hold on
    aa = (m1(i)-1)*a_bin_len+a_min;
    bb = (n1(i)-1)*b_bin_len+b_min;
    rr = (l1(i)-1)*r_bin_len+r_min;
    circle(aa,bb,rr);
end
