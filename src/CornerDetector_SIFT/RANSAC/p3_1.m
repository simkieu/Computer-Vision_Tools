clear
clc

A = im2double(imread('transA.jpg'));
B = im2double(imread('transB.jpg'));

[r,c] = size(A);
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
    rand = rand_gen(1);
    u = kb(1,rand) - ka(1,rand);
    v = kb(2,rand) - ka(2,rand);
    count = 0;
    for j = 1:N
        x_shifted = ka(1,j) + u;
        y_shifted = ka(2,j) + v;
        error = sqrt((kb(1,j)-x_shifted)^2+(kb(2,j)-y_shifted)^2);
        if error < thresh
            p(j) = 1;
            count = count + 1;
        end
    end
    if count > count_max
        p_chosen = p;
        count_max = count;
        percent = count_max/N;
        uv_chosen = [u v];
    end
end

u = uv_chosen(1)
v = uv_chosen(2)
percent

%Draw matching lines
kb(1,:) = kb(1,:) + c*ones(1,N);
C = [A B];
imshow(C)
hold on
for i = 1:N
    if p_chosen(i) > 0
        scatter(ka(1,i),ka(2,i),20,'r','*','LineWidth',1);
        scatter(kb(1,i),kb(2,i),20,'r','*','LineWidth',1);
        line([ka(1,i), kb(1,i)], [ka(2,i), kb(2,i)], 'Color', 'g', 'LineWidth', 1);
    end
end
hold off