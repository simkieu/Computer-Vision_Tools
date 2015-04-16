A = im2double(imread('transA.jpg'));
B = im2double(imread('transB.jpg'));
[r,c] = size(A);
RR = harris_output(A);
RA = harris_refine(RR);
[ra,ca] = find(RA);
RR = harris_output(B);
RB = harris_refine(RR);
[rb,cb] = find(RB);

figure()
cb = cb + c*ones(size(cb));
C = [A B];
imshow(C)
hold on
scatter(ca,ra,10,'r','*','LineWidth',0.5)
scatter(cb,rb,10,'r','*','LineWidth',0.5)
hold off


A = im2double(imread('simA.jpg'));
B = im2double(imread('simB.jpg'));
[r,c] = size(A);
RR = harris_output(A);
RA = harris_refine(RR);
[ra,ca] = find(RA);
RR = harris_output(B);
RB = harris_refine(RR);
[rb,cb] = find(RB);

figure()
cb = cb + c*ones(size(cb));
C = [A B];
imshow(C)
hold on
scatter(ca,ra,10,'r','*','LineWidth',0.5)
scatter(cb,rb,10,'r','*','LineWidth',0.5)
hold off