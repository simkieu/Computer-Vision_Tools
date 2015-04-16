transA = im2double(imread('transA.jpg'));
transB = im2double(imread('transB.jpg'));
simA = im2double(imread('simA.jpg'));
simB = im2double(imread('simB.jpg'));

R1 = harris_output(transA);
R1 = R1 - min(min(R1));
R1 = R1/max(max(R1));

R2 = harris_output(transB);
R2 = R2 - min(min(R2));
R2 = R2/max(max(R2));

R3 = harris_output(simA);
R3 = R3 - min(min(R3));
R3 = R3/max(max(R3));

R4 = harris_output(simB);
R4 = R4 - min(min(R4));
R4 = R4/max(max(R4));

figure()
imshow(R1)
figure()
imshow(R2)
figure()
imshow(R3)
figure()
imshow(R4)