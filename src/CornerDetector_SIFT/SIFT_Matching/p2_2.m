%For the image pair transA.jpg and transB.jpg
A = im2double(imread('transA.jpg'));
B = im2double(imread('transB.jpg'));

[r,c] = size(A);
[ka, kb] = find_matching(A,B);
N = size(ka,2);

%Draw matching lines
kb(1,:) = kb(1,:) + c*ones(1,N);
C = [A B];
figure()
imshow(C);
hold on
scatter(ka(1,:),ka(2,:),20,'r','*','LineWidth',1);
scatter(kb(1,:),kb(2,:),20,'r','*','LineWidth',1);
for i = 1:N
    line([ka(1,i), kb(1,i)], [ka(2,i), kb(2,i)], 'Color', 'g', 'LineWidth', 1);
end
hold off


%For the image pair simA.jpg and simB.jpg
A = im2double(imread('simA.jpg'));
B = im2double(imread('simB.jpg'));

[r,c] = size(A);
[ka, kb] = find_matching(A,B);
N = size(ka,2);

%Draw matching lines
kb(1,:) = kb(1,:) + c*ones(1,N);
C = [A B];
figure()
imshow(C);
hold on
scatter(ka(1,:),ka(2,:),20,'r','*','LineWidth',1);
scatter(kb(1,:),kb(2,:),20,'r','*','LineWidth',1);
for i = 1:N
    line([ka(1,i), kb(1,i)], [ka(2,i), kb(2,i)], 'Color', 'g', 'LineWidth', 1);
end
hold off