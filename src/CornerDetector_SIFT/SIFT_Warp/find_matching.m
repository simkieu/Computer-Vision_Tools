function [ka, kb] = find_matching(A,B)
[r,c] = size(A);
A = single(A);
[F_a, D_a] = find_feature(A);
B = single(B);
[F_b, D_b] = find_feature(B);
M = vl_ubcmatch(D_a,D_b);
N = size(M,2);
ka = zeros(2,N);
kb = ka;
for i = 1:N
    ka(:,i) = F_a(1:2,M(1,i));
    kb(:,i) = F_b(1:2,M(2,i));
end
end