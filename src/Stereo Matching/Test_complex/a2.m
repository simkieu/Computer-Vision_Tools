clear
clc
A1 = rgb2gray(imread('proj2-pair1-L.png'));
A2 = rgb2gray(imread('proj2-pair1-R.png'));
A1 = imresize(A1,0.4);
A2 = imresize(A2,0.4);
imwrite(A1,'small_l.png');
imwrite(A2,'small_r.png');
subset = 3;
ss = floor(subset/2);
[r,c] = size(A1);
B1 = zeros(r+2*ss,c+2*ss);
B2 = zeros(r+2*ss,c+2*ss);
B1(1+ss:r+ss,1+ss:c+ss) = A1;
B2(1+ss:r+ss,1+ss:c+ss) = A2;
Dl = zeros(r,c);
Dr = zeros(r,c);
D = zeros(r,c);
SSD = ones(1,c);

%Match from left to right
for i=1:r
    for j=1:c
        %For each pixel in left image
        for jj=1:c
            SSD(jj) = sum(sum((B1(i:i+2*ss,j:j+2*ss)-B2(i:i+2*ss,jj:jj+2*ss)).^2));
        end
        [m,ind] = min(SSD);
        Dl(i,j) = j-ind;
        if SSD(ind)>1000
            Dl(i,j) = 0;
        end
        if Dl(i,j)<10
            Dl(i,j)=10;
        end
        if Dl(i,j)>40
            Dl(i,j) = 0;
        end
    end
end
Dl = Dl-min(min(Dl));
Dl = Dl/max(max(Dl));
imwrite(Dl,'disparity_left.png');

%Match from right to left
for i=1:r
    for j=1:c
        %For each pixel in right image
        for jj=1:c
            SSD(jj) = sum(sum((B2(i:i+2*ss,j:j+2*ss)-B1(i:i+2*ss,jj:jj+2*ss)).^2));
        end
        [m,ind] = min(SSD);
        Dr(i,j) = abs(j-ind);
        if SSD(ind)>1000
            Dr(i,j) = 0;
        end
        if Dr(i,j)<10
            Dr(i,j)=10;
        end
        if Dr(i,j)>40
            Dr(i,j) = 0;
        end
    end
end
Dr = Dr-min(min(Dr));
Dr = Dr/max(max(Dr));
imwrite(Dr,'disparity_right.png');

figure(1)
imshow(Dl)
figure(2)
imshow(Dr)
