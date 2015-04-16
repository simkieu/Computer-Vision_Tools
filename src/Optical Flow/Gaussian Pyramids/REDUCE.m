function [IR,a1,a2] = REDUCE(I)
a1 = 1;
a2 = 1;
f = [1/16  1/4  3/8  1/4  1/16]'*[1/16  1/4  3/8  1/4  1/16];
If = imfilter(I,f);
IR = If(1:2:end, 1:2:end);
[r,c] = size(I);
if mod(r,2) == 0
    a1 = 0;
end
if mod(c,2) == 0
    a2 = 0;
end
end