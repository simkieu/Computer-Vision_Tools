A = im2double(imread('simA.jpg'));
B = im2double(imread('simB.jpg'));

[rr,cc] = size(A);
[ka, kb] = find_matching(A,B);
N = size(ka,2);

%RANSAC parameters
n = 7; %Number of iterations
thresh = 50;

%RANSAC loop
count_max = 0;
for i = 1:n
    p = zeros(1,N);
    rand_gen = randperm(N);
    rand1 = rand_gen(1);
    rand2 = rand_gen(2);
    UV_a1 = [ka(1,rand1) -ka(2,rand1) 1 0; ka(2,rand1) ka(1,rand1) 0 1];
    UV_a2 = [ka(1,rand2) -ka(2,rand2) 1 0; ka(2,rand2) ka(1,rand2) 0 1];
    UV_a = [UV_a1; UV_a2];
    uv_b1 = [kb(1,rand1); kb(2,rand1)];
    uv_b2 = [kb(1,rand2); kb(2,rand2)];
    uv_b = [uv_b1; uv_b2];
    
    %Find transformation matrix T
    para = UV_a\uv_b;
    T = [para(1), -para(2), para(3); para(2), para(1), para(4)];
    
    %Find mapped points
    uv_mapped = T*[ka; ones(1,N)];
    
    count = 0;
    for j = 1:N
        x_shifted = uv_mapped(1,j);
        y_shifted = uv_mapped(2,j);      
        error = sqrt((kb(1,j)-x_shifted)^2+(kb(2,j)-y_shifted)^2);
        if error < thresh
            p(j) = 1;
            count = count + 1;
        end
    end
    if count > count_max
        p_chosen = p;
        count_max = count;
        T_chosen = T;
    end
end

%Warping



% %Draw matching lines
% kb(1,:) = kb(1,:) + cc*ones(1,N);
% C = [A B];
% imshow(C)
% hold on
% for i = 1:N
%     if p_chosen(i) > 0
%         scatter(ka(1,i),ka(2,i),20,'r','*','LineWidth',1);
%         scatter(kb(1,i),kb(2,i),20,'r','*','LineWidth',1);
%         line([ka(1,i), kb(1,i)], [ka(2,i), kb(2,i)], 'Color', 'g', 'LineWidth', 1);
%     end
% end
% hold off