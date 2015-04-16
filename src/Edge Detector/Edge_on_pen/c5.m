clear
clc
A = imread('ps1-input1-smooth.jpg');
E = edge(A,'canny',[0.2 0.3],1);
[r,c] = size(E);
[m,n] = find(E);
len = length(m);
t_bin_len = 5;
d_bin_len = 3;
d_max = sqrt(r^2+c^2);
di_max = round(d_max/d_bin_len);
H = zeros(2*di_max+1,180/t_bin_len);
for i=1:len
    x = n(i);
    y = m(i);
    for t=0:t_bin_len:180-t_bin_len
        d = x*cosd(t) - y*sind(t);
        di = round(d/d_bin_len)+di_max+1;
        ti = t/t_bin_len+1;
        H(di,ti) = H(di,ti)+1;
    end
end
[m1,n1] = find(H>147);
figure(1)
imshow(A)
hold on
xx = 1:c;
for i=1:length(m1)
    tt = (n1(i)-1)*t_bin_len;
    dd = (m1(i)-di_max-1)*d_bin_len;
    if tt==0||tt==180
        x1 = dd;
        x2 = dd;
        y1 = 1;
        y2 = r;
        plot([x1 x2],[y1 y2],'g','LineWidth',3) 
    else
        yy = xx*cosd(tt)/sind(tt)-ones(size(xx))*dd/sind(tt);
        plot(xx,yy,'g','LineWidth',3)
    end
end
figure(2)
imshow(H/max(max(H)))