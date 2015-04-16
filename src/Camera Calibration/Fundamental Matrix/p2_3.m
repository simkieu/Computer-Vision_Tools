clear
clc

aa = load('pts2d-pic_a.txt');
bb = load('pts2d-pic_b.txt');
IA = imread('pic_a.jpg');
IB = imread('pic_b.jpg');
IA_gray = rgb2gray(IA);
[r,c] = size(IA_gray);
N = size(aa,1);
load('F.mat')

a = [aa ones(N,1)];
b = [bb ones(N,1)];

%Draw lines on pic_a
figure(1)
imshow(IA)
hold on
scatter(aa(:,1),aa(:,2),50,'r','*','LineWidth',1)
for i = 1:N
    pi = b(i,:)';
    li = F*pi;
    PUL = [0,0,1];
    PBL = [0,r,1];
    PUR = [c,0,1];
    PBR = [c,r,1];
    lL = cross(PUL,PBL);
    lR = cross(PUR,PBR);
    PL = cross(li,lL);
    PR = cross(li,lR);
    PL = PL/PL(3);
    PR = PR/PR(3);
    line([PL(1), PR(1)], [PL(2), PR(2)], 'Color', 'b', 'LineWidth', 1);
end
hold off

%Draw lines on pic_b
figure(2)
imshow(IB)
hold on
scatter(bb(:,1),bb(:,2),50,'r','*','LineWidth',1)
for i = 1:N
    pi = a(i,:)';
    li = F'*pi;
    PUL = [0,0,1];
    PBL = [0,r,1];
    PUR = [c,0,1];
    PBR = [c,r,1];
    lL = cross(PUL,PBL);
    lR = cross(PUR,PBR);
    PL = cross(li,lL);
    PR = cross(li,lR);
    PL = PL/PL(3);
    PR = PR/PR(3);
    line([PL(1), PR(1)], [PL(2), PR(2)], 'Color', 'b', 'LineWidth', 1);
end
hold off