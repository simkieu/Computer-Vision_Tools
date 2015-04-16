clear
clc
vr = VideoReader('pres_debate.avi');
fr = read(vr);
load 'pres_debate.txt';

%Get frames
[r,c,cl,fr_num] = size(fr);
%fr_num = 10; %Frame where we stop
frgi = zeros(r,c,fr_num);
for i = 1:fr_num
    frgi(:,:,i) = im2double(rgb2gray(fr(:,:,:,i)));
end
aa = imresize(frgi(:,:,1),0.5);
[r,c] = size(aa);
frg = zeros(r,c,fr_num);
for i = 1:fr_num
    frg(:,:,i) = imresize(frgi(:,:,i),0.5);
end

%Parameters
n_particles = 200;
sigma_d = 15;
SIGMA_d = [sigma_d^2, 0; 0, sigma_d^2];
sigma_mse_sqr = 5;
alpha = 0.9;

%Get box information
box = round(pres_debate/2);
if mod(box(3),2) == 0
    box_w = box(3) + 1;
else
    box_w = box(3);
end
if mod(box(4),2) == 0
    box_h = box(4) + 1;
else
    box_h = box(4);
end
center = 500*ones(fr_num,2); %center saves the position of the box at each frame
center(1,1) = box(1) + floor(box_w/2);
center(1,2) = box(2) + floor(box_h/2);

%Particle Filter: Find the u,v at frame i
particles = zeros(n_particles,2,fr_num);
for i=2:fr_num
    center_x = center(i-1,1);
    center_y = center(i-1,2);
    mu = repmat([center_x,center_y],n_particles,1);
    
    %Generate particles
    R = round(mvnrnd(mu,SIGMA_d));
    
    %Get a set of particles at each frame
    particles(:,:,i-1) = R;
    
    %Score particles based on their distribution weights
    p_dis = (R-mu).^2;
    p_dis = (p_dis(:,1)+p_dis(:,2))/(2*sigma_d^2);
    p_dis = exp(-p_dis);
    
    %Score each particle based on MSE and random distribution
    mse_score = zeros(n_particles,1);
    for j=1:n_particles
        mse_score(j) = mse(center(i-1,:),R(j,:),frg(:,:,i-1),frg(:,:,i),box_w,box_h);
    end
    p_mse = exp(-mse_score/(2*sigma_mse_sqr));
    
    %Final score for particles
    weight = p_dis.*p_mse;
    [weight_max, max_ind] = max(weight);
    
    %Update new center
    center(i,1) = round(alpha*R(max_ind,1)+(1-alpha)*center(i-1,1));
    center(i,2) = round(alpha*R(max_ind,2)+(1-alpha)*center(i-1,2));
end

%Draw the bounding box and particles
box_draw = zeros(fr_num,4);
box_draw(:,3) = box_w;
box_draw(:,4) = box_h;
for i=1:fr_num
    box_draw(i,1) = center(i,1) - floor(box_w/2);
    box_draw(i,2) = center(i,2) - floor(box_h/2);
end

%Display for testing
for i=1:fr_num-1
    imshow(frg(:,:,i))
    rectangle('Position',box_draw(i,:),'LineWidth',2,'EdgeColor','r')
    hold on
    plot(particles(:,1,i),particles(:,2,i),'.');
    plot(center(i,1),center(i,2),'r*');
    pause(0.01)
    hold off
end