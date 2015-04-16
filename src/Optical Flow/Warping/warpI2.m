function [warpI2] = warpI2(i2,vx,vy)
[M,N]=size(i2);
[x,y]=meshgrid(1:N,1:M);
warpI3=interp2(x,y,i2,x+vx,y+vy,'nearest'); 
warpI2=interp2(x,y,i2,x+vx,y+vy,'linear'); 
I=find(isnan(warpI2));
warpI2(I)=warpI3(I);