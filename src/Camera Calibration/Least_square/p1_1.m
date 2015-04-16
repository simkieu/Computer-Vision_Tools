clear
clc

w = load('pts3d-norm.txt');
p = load('pts2d-norm-pic_a.txt');
N = size(w,1);
X = w(:,1);
Y = w(:,2);
Z = w(:,3);
u = p(:,1);
v = p(:,2);

%Create matrix A
A = zeros(2*N,12);
for i=1:N
    a = [X(i) Y(i) Z(i) 1 0 0 0 0 -u(i)*X(i) -u(i)*Y(i) -u(i)*Z(i) -u(i);
        0 0 0 0 X(i) Y(i) Z(i) 1 -v(i)*X(i) -v(i)*Y(i) -v(i)*Z(i) -v(i)];
    A(2*i-1:2*i,:) = a;
end

[U,S,V] = svd(A);
x = V(:,12);
M = vec2mat(x,4);
M = -M %Scale by -1 for checking with given result 

w1 = [w ones(N,1)];
pp = M*w1';
ppn = (pp./repmat(pp(3,:),3,1))';
ppn = ppn(:,1:2);

last_uv_output = ppn(N,:)
last_uv_actual = [u(N) v(N)];
residual = sqrt(sum((last_uv_output - last_uv_actual).^2))