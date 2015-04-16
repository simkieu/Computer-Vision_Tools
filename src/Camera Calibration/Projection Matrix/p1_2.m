clear
clc

w = load('pts3d.txt');
p = load('pts2d-pic_a.txt');
n = size(w,1);
XX = w(:,1);
YY = w(:,2);
ZZ = w(:,3);
uu = p(:,1);
vv = p(:,2);

kk = [8 12 16];
nk = length(kk);
R_best = 1e6;
M_best = zeros(3,4);
avg_residual = zeros(10,3);

for ik = 1:nk
    k = kk(ik);
    for rep = 1:10
        ran = randperm(n);
        ran_k = ran(1:k); 
        u = uu(ran_k,:);
        v = vv(ran_k,:);
        X = XX(ran_k,:);
        Y = YY(ran_k,:);
        Z = ZZ(ran_k,:);
        N = size(u,1);
        
        %Create matrix A
        A = zeros(2*N,12);
        for i=1:N
            a = [X(i) Y(i) Z(i) 1 0 0 0 0 -u(i)*X(i) -u(i)*Y(i) -u(i)*Z(i) -u(i);
                0 0 0 0 X(i) Y(i) Z(i) 1 -v(i)*X(i) -v(i)*Y(i) -v(i)*Z(i) -v(i)];
            A(2*i-1:2*i,:) = a;
        end
        
        %Compute projection matrix M
        [U,S,V] = svd(A);
        x = V(:,12);
        M = vec2mat(x,4);
        
        %Pick 4 points and compute the average residual
        ran_4 = ran(k+1:k+4);
        sum_residual = 0;
        for i = 1:4
            ind = ran_4(i);
            
            w1 = [w ones(n,1)];
            pp = M*w1';
            ppn = (pp./repmat(pp(3,:),3,1))';
            ppn = ppn(:,1:2);

            uv_output = ppn(ind,:);
            uv_actual = [uu(ind) vv(ind)];
            residual = sqrt(sum((uv_output - uv_actual).^2));
            
            sum_residual = sum_residual + residual;
        end
        avg_residual(rep,ik) = sum_residual/4;
        
        %Save M that gives the lowest average residual
        if avg_residual(rep,ik) < R_best
            R_best = avg_residual(rep,ik);
            M_best = M;
        end
    end
end

save('M.mat','M')
avg_residual
M_best