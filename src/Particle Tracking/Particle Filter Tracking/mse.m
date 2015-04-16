function score = mse(center1,center2,frame1,frame2,w,h)
center_temp = center1;
center1(1) = center_temp(2);
center1(2) = center_temp(1);
center_temp = center2;
center2(1) = center_temp(2);
center2(2) = center_temp(1);
rw = floor(w/2);
rh = floor(h/2);
score = 0;
for i=-rw:rw
    for j=-rh:rh
        score = score+(255*frame1(center1(1)+rh,center1(2)+rw)-255*frame2(center2(1)+rh,center2(2)+rw))^2;
    end
end
score = score/(w*h);
end