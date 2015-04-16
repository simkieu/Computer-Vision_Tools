function R_new = harris_refine(R_old)
R_new = R_old;
thresh = 0.1;
win_nms = 2; %Window for non-maximal-suppression
[r,c] = size(R_new);

for i = 1:r
    for j = 1:c
        if R_new(i,j) < thresh
            R_new(i,j) = 0;
        end
    end
end
for i = 1:r
    for j = 1:c
        if R_new(i,j) > 0
            if R_new(i,j) < max(max(R_new(i-win_nms:i+win_nms,j-win_nms:j+win_nms)))
                R_new(i,j) = 0;
            end
        end
    end
end
end