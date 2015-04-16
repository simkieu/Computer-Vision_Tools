function [IE] = EXPAND(I,a1,a2)
[r,c] = size(I);
r2 = 2*r-1;
c2 = 2*c-1;
if a1 == 0
    r2 = 2*r;
end
if a2 == 0 
    c2 = 2*c;
end
IE = zeros(r2,c2);
for i = 1:r
    for j = 1:c
        IE(2*i-1,2*j-1) = I(i,j);
    end
end
f = 4*[1/16  1/4  3/8  1/4  1/16]'*[1/16  1/4  3/8  1/4  1/16];
IE = imfilter(IE,f);
end