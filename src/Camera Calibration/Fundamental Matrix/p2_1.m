clear
clc

a = load('pts2d-pic_a.txt');
b = load('pts2d-pic_b.txt');
N = size(a,1);
u1 = a(:,1);
v1 = a(:,2);
u2 = b(:,1);
v2 = b(:,2);

%Create matrix A
A = zeros(N,9);
for i=1:N
    aa = [u2(i)*u1(i) u2(i)*v1(i) u2(i) v2(i)*u1(i) v2(i)*v1(i) v2(i) u1(i) v1(i) 1];
    A(i,:) = aa;
end

[U,S,V] = svd(A);
x = V(:,9);
FF = vec2mat(x,3);
FF = FF'

save('FF.mat','FF')