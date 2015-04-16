function [m]=testwarp(im1,im2,dx,dy)
w = warpI2(im1,dx,dy);
s1 = size(im1); s2 = size(im2);
if not(all (s1 == s2)) error('Unmatched sizes.'); end

m = zeros(s1(1),s1(2),1,2);
m(:,:,1,1) = w;
m(:,:,1,2) = im2;
implay(m,2);