clear
clc
A1 = rgb2gray(imread('proj2-pair1-L.png'));
A2 = rgb2gray(imread('proj2-pair1-R.png'));
C1 = A1*1.1;
C2 = A2*1.1;
A1 = imresize(C1,0.3);
A2 = imresize(C2,0.3);
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

%Match from left to right
for i=1:r
    for j=1:c
        %For each pixel in left image
        template = B1(i:i+2*ss,j:j+2*ss);
        if min(min(template)) == max(max(template))
            template(2,2) = min(min(template))+1;
        end
        AA = B2(i:i+2*ss,:);
        Corr = normxcorr2(template,AA);
        m = max(max(Corr));
        [x,y] = find(Corr==m);
        Dl(i,j) = j-y(1);
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
        %For each pixel in left image
        template = B2(i:i+2*ss,j:j+2*ss);
        if min(min(template)) == max(max(template))
            template(2,2) = min(min(template))+1;
        end
        AA = B1(i:i+2*ss,:);
        Corr = normxcorr2(template,AA);
        m = max(max(Corr));
        [x,y] = find(Corr==m);
        Dr(i,j) = abs(j-y(1));
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