% Harshit Rai
% 2017152

clear all;
clc;

f=[1 3 4; 2 5 3; 6 8 9]; 
w=[-1 -2 -3; -4 0 1; -6 -5 -1];

ff=padarray(f,[2 2],0,'post'); 

pad=(3+3-1)+1;
ww=padarray(w,[pad pad],0,'post');
ww=imcrop(ww,[2 2 4 4]);

for i=1:3
    pos_x=mod(-1,5)+1;
    pos_y=mod(i-2,5)+1;
    ww(pos_x,pos_y)=w(1,i);
end

for i=1:3
    pos_x=mod(i-2,5)+1;
    pos_y=mod(-1,5)+1;
    ww(pos_x,pos_y)=w(i,1);
end

ww
fftres=ifft2(fft2(ff).*fft2(ww))

