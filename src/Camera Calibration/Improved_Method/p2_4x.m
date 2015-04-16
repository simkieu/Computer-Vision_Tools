clear
clc

a = load('pts2d-pic_a.txt');
b = load('pts2d-pic_b.txt');
N = size(a,1);

%Find Ta
c_u = mean(a(:,1));
c_v = mean(a(:,2));
diff = a - repmat([c_u c_v],N,1);
std = sqrt(sum(sum(diff.^2))/2/N);
s = 1/std;
s_mat = s*eye(3,3);
s_mat(3,3) = 1;
c_mat = eye(3,3);
c_mat(1,3) = -c_u;
c_mat(2,3) = -c_v;
Ta = s_mat*c_mat

%Find Tb
c_u = mean(b(:,1));
c_v = mean(b(:,2));
diff = b - repmat([c_u c_v],N,1);
std = sqrt(sum(sum(diff.^2))/2/N);
s = 1/std;
s_mat = s*eye(3,3);
s_mat(3,3) = 1;
c_mat = eye(3,3);
c_mat(1,3) = -c_u;
c_mat(2,3) = -c_v;
Tb = s_mat*c_mat

%Normalize points in pic_a
uv = [a ones(N,1)]';
uv_a = Ta*uv;
uv_a = uv_a(1:2,:)';

%Normalize points in pic_b
uv = [b ones(N,1)]';
uv_b = Tb*uv;
uv_b = uv_b(1:2,:)';

%Find F~
u1 = uv_a(:,1);
v1 = uv_a(:,2);
u2 = uv_b(:,1);
v2 = uv_b(:,2);
%Create matrix A
A = zeros(N,9);
for i=1:N
    a = [u2(i)*u1(i) u2(i)*v1(i) u2(i) v2(i)*u1(i) v2(i)*v1(i) v2(i) u1(i) v1(i) 1];
    A(i,:) = a;
end
[U,S,V] = svd(A);
x = V(:,9);
FF = vec2mat(x,3);
FF = FF';

%Find F^
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

%Find F
F_better = Tb'*F*Ta;
save('F_better.mat','F_better')