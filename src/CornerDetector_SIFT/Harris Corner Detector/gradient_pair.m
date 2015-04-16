function [Ax, Ay] = gradient_pair(A)
[Ax, Ay] = imgradientxy(A);
Ax = Ax - min(min(Ax));
Ax = Ax/max(max(Ax));
Ay = Ay - min(min(Ay));
Ay = Ay/max(max(Ay));
Ag = [Ax Ay];
imshow(Ag)
title('gradient-pair')
end