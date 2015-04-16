A1 = imread('leftTest.png');
A2 = imread('rightTest.png');
subset = 11;
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
        %Handle multiple minimum
        [m,ind] = min(SSD);
        ind2 = find(SSD==m);
        diff = abs(ind2 - j);
        [d, d_ind] = min(diff);
        ind  = ind2(d_ind);
        Dl(i,j) = j-ind;
        if SSD(ind)>1
            Dl(i,j) = 0;
        end
    end
end

%Match from right to left
for i=1:r
    for j=1:c
        %For each pixel in right image
        for jj=1:c
            SSD(jj) = sum(sum((B2(i:i+2*ss,j:j+2*ss)-B1(i:i+2*ss,jj:jj+2*ss)).^2));
        end
        %Handle multiple minimum
        [m,ind] = min(SSD);
        ind2 = find(SSD==m);
        diff = abs(ind2 - j);
        [d, d_ind] = min(diff);
        ind  = ind2(d_ind);
        Dr(i,j) = j-ind;
        if SSD(ind)>1
            Dr(i,j) = 0;
        end
    end
end


figure(1)
imshow(Dl)
figure(2)
imshow(abs(Dr))
figure(3)
surf(D,'FaceColor','interp','EdgeColor','none','FaceLighting','phong')