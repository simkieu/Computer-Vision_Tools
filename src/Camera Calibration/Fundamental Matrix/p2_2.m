clear
clc
load('FF.mat')

[U,S,V] = svd(FF);
SS = S;
S_min = 1e6;
for i = 1:9
    if SS(i) < S_min
        ind = i;
    end
end
SS(ind) = 0;
F = U*SS*V'

save('F.mat','F')